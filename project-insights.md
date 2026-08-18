# Project Insights

## 1. Activation Funnel

The activation funnel evaluates the movement of accounts through:

**Signup → Trial → Paid**

### Results

| Metric | Result |
|--------|--------|
| Signed-up accounts | 500 |
| Trial accounts | 403 |
| Paid converters | 403 |
| Signup → Trial | 80.6% |
| Trial → Paid | 100.0% |
| Overall Signup → Paid | 80.6% |

### Insight

The largest observed drop-off occurs between signup and trial, with 403 of 500 accounts starting a trial.

Among the analyzed trial population, all 403 accounts subsequently converted to paid, resulting in a 100% trial-to-paid conversion rate.

This indicates that the primary activation opportunity in this dataset is the **signup-to-trial stage**, rather than the trial-to-paid stage.

---

## 2. Active Account Analysis

The dashboard also compares currently active accounts with paid converters.

The resulting ratio is **124.1%**.

This metric should not be interpreted as a sequential conversion rate. It compares two account populations:

**Currently Active Accounts / Paid Converters × 100**

A value above 100% indicates that the current active-account population is larger than the analyzed paid-converter population.

---

## 3. Cohort Retention Analysis

Customers were grouped according to their first paid subscription month.

Retention was measured from:

**Month 0 → Month 6**

Month 0 represents the cohort baseline.

### Key Findings

#### Strong overall retention

Most observed cohorts maintain approximately 100% retention across the analyzed months, indicating limited observed customer drop-off in the dataset.

#### April 2023 cohort

The April 2023 cohort shows the clearest retention decline, reaching approximately **93.3% from Month 1 onward**.

This cohort represents a potential retention issue that warrants further investigation.

#### September 2023 cohort

The September 2023 cohort declines to approximately **92.9% from Month 2 onward**.

This represents another cohort-level retention anomaly worth investigating.

---

## 4. Business Interpretation

The analysis suggests that:

1. **Signup-to-trial activation is the main funnel drop-off point.**
2. **Trial-to-paid conversion is exceptionally strong** within the analyzed population.
3. **Overall observed retention is high**, with most cohorts remaining close to their Month 0 baseline.
4. **April 2023 and September 2023** stand out as cohorts with comparatively lower retention.
5. These cohorts could be investigated further by examining customer characteristics, subscription plans, acquisition channels, product usage, or other available segmentation variables.

---

## 5. Analytical Limitations

The findings should be interpreted within the scope of the available dataset.

- The dataset is synthetic and sourced from Kaggle.
- The analysis covers the available observation period and a maximum of six months of cohort retention.
- High trial-to-paid conversion should not automatically be generalized to a real-world SaaS business.
- Cohort-level anomalies identify where investigation is warranted but do not establish the underlying cause.
- The Active Accounts / Paid Converters metric is a population comparison, not a sequential funnel conversion metric.

---

## 6. Overall Conclusion

The project demonstrates an end-to-end SaaS analytics workflow:

**Relational Data → SQL Validation → Funnel Analysis → Cohort Analysis → Power BI → Business Insights**

The analysis identifies the primary activation drop-off, evaluates paid conversion, measures cohort-level retention, and highlights specific cohorts requiring further investigation.
