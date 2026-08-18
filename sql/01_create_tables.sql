-- ============================================================
-- RavenStack: Create Tables
-- ============================================================

CREATE TABLE accounts (
    account_id       VARCHAR PRIMARY KEY,
    account_name     VARCHAR,
    industry         VARCHAR,
    country          VARCHAR,
    signup_date      DATE,
    referral_source  VARCHAR,
    plan_tier        VARCHAR,
    seats            INTEGER,
    is_trial         BOOLEAN,
    churn_flag       BOOLEAN
);

CREATE TABLE subscriptions (
    subscription_id     VARCHAR PRIMARY KEY,
    account_id          VARCHAR REFERENCES accounts(account_id),
    start_date          DATE,
    end_date            DATE,
    plan_tier            VARCHAR,
    seats                INTEGER,
    mrr_amount           NUMERIC,
    arr_amount           NUMERIC,
    is_trial              BOOLEAN,
    upgrade_flag          BOOLEAN,
    downgrade_flag      BOOLEAN,
    churn_flag           BOOLEAN,
    billing_frequency   VARCHAR,
    auto_renew_flag     BOOLEAN
);

CREATE TABLE feature_usage (
    usage_id              VARCHAR PRIMARY KEY,
    subscription_id       VARCHAR REFERENCES subscriptions(subscription_id),
    usage_date            DATE,
    feature_name          VARCHAR,
    usage_count           INTEGER,
    usage_duration_secs   INTEGER,
    error_count           INTEGER,
    is_beta_feature       BOOLEAN
);

CREATE TABLE support_tickets (
    ticket_id                      VARCHAR PRIMARY KEY,
    account_id                     VARCHAR REFERENCES accounts(account_id),
    submitted_at                   TIMESTAMP,
    closed_at                      TIMESTAMP,
    resolution_time_hours          NUMERIC,
    priority                       VARCHAR,
    first_response_time_minutes    INTEGER,
    satisfaction_score             INTEGER,
    escalation_flag                BOOLEAN
);

CREATE TABLE churn_events (
    churn_event_id             VARCHAR PRIMARY KEY,
    account_id                 VARCHAR REFERENCES accounts(account_id),
    churn_date                 DATE,
    reason_code                VARCHAR,
    refund_amount_usd          NUMERIC,
    preceding_upgrade_flag     BOOLEAN,
    preceding_downgrade_flag   BOOLEAN,
    is_reactivation            BOOLEAN,
    feedback_text              TEXT
);
