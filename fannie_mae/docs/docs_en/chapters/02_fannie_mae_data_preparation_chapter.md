# Chapter 2. Construction and preparation of the Fannie Mae dataset

## 2.1. Data source and empirical scope

The empirical basis of this study is the **Fannie Mae Single-Family Loan
Performance Primary Dataset**, distributed through the Data Dynamics platform.
It contains mortgage characteristics and subsequent monthly performance. The
current version has processed seven acquisition cohorts: `2006Q1`, `2008Q1`,
`2012Q1`, `2016Q1`, `2020Q1`, `2022Q1`, and `2024Q1`. The `2008Q1` cohort
established the pipeline, which was then applied unchanged to additional vintages.

Only the Primary Dataset is included. HARP, multifamily and Freddie Mac data
are not pooled with this sample: each source has a separate directory, variable
dictionary and processing pipeline. The source defines the Primary Dataset as
conventional, fully amortising, full-documentation, fixed-rate mortgages with
an original term no longer than 30 years. Accordingly, the conclusions apply to
this population rather than to the entire U.S. mortgage market.

The original archive is retained unchanged at `data/raw/2008Q1/2008Q1.zip`.
Its SHA-256 digest is
`6d9d3df9737fc321e70cc76bcbdf03a8bfe9ec190e472a1e1f2f9b9bd8460ae9`.
Recording the digest identifies the exact source version and enables the
reproduction of subsequent computations.

## 2.2. Unit of observation and temporal structure

The unit of observation is a loan-month pair,
`(loan_identifier, monthly_reporting_period)`. This creates an unbalanced
longitudinal panel: a loan can be observed in several reporting months and loan
histories can have different lengths.

Initial validation of the `2008Q1` archive found 22,415,219 records and
380,832 unique loans. The observation period spans January 2008 to March 2026.
All records contain 113 positions and non-empty loan and reporting-month keys.
A full external-sort audit of `loan_identifier × monthly_reporting_period`
found no duplicate keys. The raw file is not globally sorted by that key; this
is not a data defect, but it rules out checking uniqueness from adjacent records
alone.

This structure is appropriate for early warning. At month *t*, the model may
use only information available on or before *t*, whereas the outcome must occur
after *t*. Later stages will create three- and six-month outcomes. For either
horizon, only observations with a sufficiently complete future window will be
analysed, preventing a non-event from being confused with right censoring.

The expanded version contains 185,931,842 loan-month records and 3,343,420
loans in seven separate processed panels. They have not yet been physically
pooled, preserving the provenance of every acquisition cohort. All seven raw
archives passed validation. The sample composition and temporal coverage are
reported in **Table 2.1** — [“Acquisition-cohort coverage”](../../../reports/eda_v01/01_cohort_overview.csv).
Key origination characteristics are reported in **Table 2.2** —
[“Origination characteristics”](../../../reports/eda_v01/03_origination_characteristics.csv).
The visual comparison of FICO and original LTV is in **Figure 2.1** —
[“Origination characteristics by cohort”](../../../reports/figures/eda_v01/03_origination_characteristics_trend.png).

## 2.3. Raw-file quality control

Download and validation were executed as a stream from the ZIP archive; the
six-gigabyte CSV was not extracted to `raw/`. Every one of the 22,415,219
records has exactly 113 pipe-delimited fields; no record has an empty loan ID or
reporting month; and no loan-month key duplicates exist. Results are recorded in
the project JSON report and data manifest.

The current Fannie Mae delivery already combines origination characteristics
and monthly performance in one file. Therefore, joining separate acquisition
and performance files is unnecessary.

## 2.4. Cleaning and data typing

Cleaning is implemented as a reproducible software pipeline. Empty and
whitespace-only strings are converted to missing values. Core `MMYYYY` dates,
including reporting month, origination date, first-payment date and legal
maturity date, are converted to calendar dates. Numeric fields needed for the
initial panel are converted to numeric types. Validation found no invalid values
in these converted core dates or numeric fields.

The official **SF Glossary & File Layout (Excel)** has been saved in
`docs/sources/` and imported into a machine-readable project dictionary.
Positions 1–113 of the archive have official names, types and descriptions. The
glossary includes position 114, Origination VantageScore 4.0, which is not
present in this 113-column `2008Q1` archive. This is recorded as a format-
version difference rather than as missing data.

Special codes are deliberately retained in their raw form for now. The
dictionary defines their meanings, but recoding will be done separately and
only according to the outcome and feature-construction rules. This avoids
arbitrary interpretation and leakage through post-event fields.

## 2.5. Base panel and prevention of information leakage

The current output is a 35-field monthly base panel at
`data/processed/2008Q1_monthly_panel_base.parquet`. It includes loan ID,
observation date, selected origination characteristics, current balance/rate/
loan-age measures, delinquency status, payment history and a modification
indicator. The full cleaned 113-position version is retained separately at
`data/interim/2008Q1_cleaned.parquet`.

Zero Balance Code and Zero Balance Effective Date are excluded from candidate
features and stored separately as event metadata. These fields may describe loan
termination and thus contain future information relative to the prediction date.
They may be used only for outcome construction, termination rules and competing
risks, never as model input features.

A formal leakage register now identifies each of the 113 fields' economic
meaning, availability time, eligibility for prediction at *t*, and final
treatment: “feature”, “label only”, or “exclude”.

## 2.6. Limitations and next steps

Seven cohorts substantially broaden temporal coverage but do not yet form a full
annual sample. Other planned Q1 vintages can be added with the same pipeline.
Final pooling will retain an acquisition-cohort variable, after which features
and a time-based sample split will be created.

The project has therefore produced validated, reproducible loan-month panels as
well as v01 outcome/censoring and leakage rules. The initial missingness and
delinquency analysis is provided in Chapter 3. The next necessary step is
feature engineering and a temporal train/validation/out-of-time split.
