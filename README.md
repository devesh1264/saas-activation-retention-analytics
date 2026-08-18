# SaaS Activation & Retention Analytics

An end-to-end SaaS analytics project analyzing customer activation, paid conversion, and cohort retention using PostgreSQL and Power BI.

## Project Overview

The objective of this project was to understand how users move through the SaaS customer lifecycle and whether customers remain active after becoming paid users.

The analysis focuses on two core business questions:

1. How effectively do users move from signup → trial → paid?
2. How well are different customer cohorts retained over time?

The project combines SQL-based analysis and validation with an interactive Power BI dashboard.

## Business Problem

A SaaS business needs to understand where users drop off during activation and whether customers continue to remain active after conversion.

The analysis therefore evaluates:

- Signup-to-trial activation
- Trial-to-paid conversion
- Overall signup-to-paid conversion
- Active accounts relative to paid converters
- Cohort retention over six months
- Cohort-level retention anomalies

## Dataset & Attribution

This project uses the **RavenStack synthetic SaaS dataset** sourced from ** Kaggle (Rivalytics) **.

The dataset is used for educational and portfolio-based analytical purposes. All SQL analysis, transformations, business metrics, and Power BI visualizations were independently developed for this project.

**Source:** Kaggle — Rivalytics  
**Dataset:** RavenStack synthetic SaaS dataset

> Dataset credit belongs to the original creator/publisher on Kaggle. This repository does not claim ownership of the underlying dataset.

## Tools & Technologies

- PostgreSQL
- SQL
- Power BI
- DAX
- CTEs
- Window functions
- Date arithmetic
- Conditional formatting
- Data validation / QA

## Analysis Workflow

### 1. Data Validation

Validated account and subscription populations and checked relationships between the relevant tables before calculating business metrics.

### 2. Activation Funnel

Built a sequential customer activation funnel:

Signup → Trial → Paid

Key metrics include:

- Total signed-up accounts
- Trial accounts
- Paid converters
- Signup-to-trial conversion
- Trial-to-paid conversion
- Overall signup-to-paid conversion

### 3. Cohort Retention

Customers were grouped into cohorts based on their first paid subscription month.

Retention was then evaluated across:

- Month 0
- Month 1
- Month 2
- Month 3
- Month 4
- Month 5
- Month 6

Month 0 represents the cohort baseline.

### 4. Power BI Dashboard

The final dashboard contains two analytical views:

- Activation Funnel
- Cohort Retention

Conditional formatting is used to highlight retention values that deviate from the cohort baseline.

## Key Findings

### Activation

- 500 accounts were present in the signup population.
- 403 accounts started a trial.
- 403 accounts converted to paid in the analyzed funnel population.
- Signup-to-trial conversion was approximately 80.6%.
- Trial-to-paid conversion was 100% for the analyzed trial population.

### Retention

Overall retention was high across the observed cohorts.

However, specific cohorts showed noticeable declines:

- April 2023 showed retention around 93.3% from Month 1 onward.
- September 2023 showed retention around 92.9% from Month 2 onward.
- These cohorts warrant further investigation to identify possible product, customer-segment, or subscription-related causes.

## Important Metric Definition

The dashboard distinguishes between sequential funnel conversion metrics and population-ratio metrics.

The "Active Accounts / Paid Converters (%)" metric compares the current active-account population with paid converters. It is not a sequential conversion rate.

## SQL Analysis

The SQL layer contains queries for:

- Data validation
- Activation funnel construction
- Cohort creation
- Month-level retention calculation
- Retained-account counts
- Retention percentages

CTEs and date-based cohort logic are used to keep the analytical steps explicit and reproducible.

## Dashboard

### Activation Funnel

![Activation Funnel](screenshots/activation-funnel.png)

### Cohort Retention

![Cohort Retention](screenshots/cohort-retention.png)

## Project Outcome

This project demonstrates an end-to-end analytics workflow:

Raw relational data
→ SQL validation
→ Business metric definition
→ Funnel analysis
→ Cohort analysis
→ Power BI visualization
→ Business insights

The project focuses on analytical correctness as well as communicating results in a stakeholder-readable format.
