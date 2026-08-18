-- ============================================================
-- Funnel Conversion + Cohort Retention
-- Tables used: accounts, subscriptions ONLY
--
-- Activation definition: no native "activation" event exists in this dataset.
-- Trial -> Paid conversion (subscriptions.is_trial = false) is used as the activation-equivalent proxy.
-- ============================================================
-- ------------------------------------------------------------
-- QUERY 1: Funnel stage counts + conversion rates
-- Stages: Signed Up -> Started Trial -> Converted to Paid -> Retained
-- ------------------------------------------------------------

WITH stage_signup AS (
    SELECT account_id
    FROM accounts
),

stage_trial AS (
    SELECT DISTINCT account_id
    FROM subscriptions
    WHERE is_trial = true
),

stage_paid AS (
    -- first paid conversion per account = activation-equivalent event
    SELECT account_id, MIN(start_date) AS paid_start_date
    FROM subscriptions
    WHERE is_trial = false
    GROUP BY account_id
),

stage_retained AS (
    -- currently active paid subscription: not ended, not churned
    SELECT DISTINCT account_id
    FROM subscriptions
    WHERE is_trial = false
      AND end_date IS NULL
      AND churn_flag = false
),

funnel_counts AS (
    SELECT
        (SELECT COUNT(*) FROM stage_signup)   AS signed_up,
        (SELECT COUNT(*) FROM stage_trial)    AS started_trial,
        (SELECT COUNT(*) FROM stage_paid)     AS converted_to_paid,
        (SELECT COUNT(*) FROM stage_retained) AS retained_active
)

SELECT
    signed_up,
    started_trial,
    converted_to_paid,
    retained_active,
    ROUND(started_trial::numeric / NULLIF(signed_up, 0) * 100, 2)
        AS signup_to_trial_pct,
    ROUND(converted_to_paid::numeric / NULLIF(started_trial, 0) * 100, 2)
        AS trial_to_paid_pct,
    ROUND(retained_active::numeric / NULLIF(converted_to_paid, 0) * 100, 2)
        AS paid_to_retained_pct,
    ROUND(converted_to_paid::numeric / NULLIF(signed_up, 0) * 100, 2)
        AS overall_signup_to_paid_pct
FROM funnel_counts;


-- ------------------------------------------------------------
-- QUERY 2: Cohort retention by signup month (activation-based cohorts)
-- Cohort = month of first paid conversion (activation proxy)
-- Retention = % of cohort with an active, non-churned paid
-- subscription overlapping each subsequent month (Month 0-6)
-- ------------------------------------------------------------

WITH first_paid AS (
    SELECT account_id, MIN(start_date) AS cohort_date
    FROM subscriptions
    WHERE is_trial = false
    GROUP BY account_id
),

cohorts AS (
    SELECT account_id, DATE_TRUNC('month', cohort_date)::date AS cohort_month
    FROM first_paid
),

months AS (
    SELECT generate_series(0, 6) AS month_number
),

cohort_month_grid AS (
    SELECT
        c.account_id,
        c.cohort_month,
        m.month_number,
        (c.cohort_month + (m.month_number || ' months')::interval)::date AS check_month
    FROM cohorts c
    CROSS JOIN months m
),

retained AS (
    -- account counts as retained in a given month if it had a paid,
    -- non-churned subscription that was active during that month
    SELECT DISTINCT
        g.account_id,
        g.cohort_month,
        g.month_number
    FROM cohort_month_grid g
    JOIN subscriptions s
        ON s.account_id = g.account_id
        AND s.is_trial = false
        AND s.start_date <= g.check_month
        AND (s.end_date IS NULL OR s.end_date >= g.check_month)
),

cohort_size AS (
    SELECT cohort_month, COUNT(DISTINCT account_id) AS cohort_total
    FROM retained
    WHERE month_number = 0
    GROUP BY cohort_month
)

SELECT
    r.cohort_month,
    r.month_number,
    COUNT(DISTINCT r.account_id) AS retained_accounts,
    cs.cohort_total,
    ROUND(COUNT(DISTINCT r.account_id)::numeric / cs.cohort_total * 100, 1)
        AS retention_pct
FROM retained r
JOIN cohort_size cs ON r.cohort_month = cs.cohort_month
GROUP BY r.cohort_month, r.month_number, cs.cohort_total
ORDER BY r.cohort_month, r.month_number;
