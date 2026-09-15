# Chapter 3. Outcomes, features and information-leakage control

## 3.1. Temporal eligibility

For loan i at month t, features may include only information available no later than t. The outcome is realised after t at a three- or six-month horizon. Future delinquency, termination, modification and post-event information cannot be model features.

## 3.2. Outcomes and censoring

In outcome version v01, formal adverse event is a future delinquency status 03–98, the 90+ DPD threshold. Early deterioration is a transition, for a loan current at t, to a future status 01–98, the 30+ DPD threshold. XX and 99 are not events. Prepayment, maturity and any Zero Balance termination are not treated as default.

## 3.3. Features and leakage register

Candidate features comprise origination characteristics, current balance/rate/loan-age measures and past payment states only. A [leakage register](../../data/dictionaries/fannie_2008q1_leakage_register_v01.csv) records a decision for all 113 fields. Zero Balance Code, Zero Balance Effective Date, foreclosure/disposition and other post-event fields are excluded. In the absence of an observed event, termination, unknown future status or incomplete future coverage causes censoring.

## 3.4. Status

Labels were built for 22,415,219 loan-month records. Formal adverse event has 264,892 events among 20,007,896 labelled observations at three months and 503,395 among 18,986,874 at six months. Early deterioration has 758,624 among 19,152,309 and 1,277,828 among 18,168,886, respectively. The full description and QA are in the [Stages 7–9 report](07_09_execution_report.md). Definitions are v01 and can be revised only through a new versioned specification.

## 3.5. Initial exploratory analysis

An initial analysis across the seven acquisition cohorts was completed before
model development. It covers 185,931,842 loan-month observations and 3,343,420
loans. The highest labelled six-month early-deterioration and formal-adverse
rates occur in 2008Q1, at 7.033% and 2.651%; the corresponding 2012Q1 values
are 1.353% and 0.231%. The vintage differences justify retaining cohort
information and testing performance temporally rather than treating all years
as interchangeable. The outcome comparison is shown in **Figure 3.1** —
[“Six-month outcomes by cohort”](../../reports/figures/eda_v01/01_six_month_outcome_rates_by_cohort.png),
and the numerical values are in **Table 3.1** — [“Six-month outcome summary”](../../reports/eda_v01/05_six_month_outcome_summary.csv).

The descriptive current-status distribution also differs: the 90+ DPD share is
4.435% for 2008Q1 and 0.263% for 2012Q1. These values are not estimates of
US-wide mortgage-market risk because the panels contain selected vintages and
their composition changes over calendar time. The cohort-level status distribution
is shown in **Figure 3.2** — [“Current delinquency status”](../../reports/figures/eda_v01/02_current_delinquency_distribution.png)
and **Table 3.2** — [“Delinquency-status distribution”](../../reports/eda_v01/04_current_delinquency_distribution.csv).
The calendar trend in 30+ and 90+ DPD is shown in **Figure 3.3** —
[“Calendar delinquency trend”](../../reports/figures/eda_v01/05_calendar_month_delinquency_trend.png).
Full tables, figures, and interpretation limits are provided in the [stage-11 report](11_exploratory_data_analysis_report.md).
