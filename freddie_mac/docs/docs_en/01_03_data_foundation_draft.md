# Stages 1–3. Dataset foundation

**Status: draft.** This text will be finalised after the stages have been
completed using the actual downloaded Freddie Mac files.

## 1. Dataset design

### 1.1. Unit of observation and study population

The unit of analysis is an individual mortgage loan acquired or guaranteed by
Freddie Mac within the US single-family mortgage market. The study does not
model a universal borrower profile or the borrower’s complete debt portfolio.
Accordingly, its conclusions concern deterioration in a specific mortgage-loan
exposure rather than overall borrower creditworthiness.

The early-warning dataset is constructed as a longitudinal loan-month panel at
the `loan_id × observation_month` level. Each record represents one loan’s state
at observation time `t`, and predictors are limited to information available no
later than that date.

### 1.2. Prediction horizons

The study will consider three- and six-month early-warning horizons. For loan
`i` observed in month `t`, the task is to estimate the probability of
deterioration over `(t, t+h]`, where `h ∈ {3, 6}`. The specific periods,
vintages and inclusion rules will be fixed after examining the available source
files.

### 1.3. Reproducible design

The study period, included vintages, exclusion rules, prediction horizons and
outcome definitions are specified before model development. Any change to these
decisions requires a new dataset version and a documented rationale.

## 2. Documentation and data dictionary

### 2.1. Data-dictionary construction

The data dictionary will be developed from the official Freddie Mac user guide
applicable to the release used in the study. Fields will be classified as
origination characteristics, monthly servicing information, loan-termination
information or technical identifiers.

For each variable, the dictionary will record its original and standardised
names, data type, economic meaning, allowed values, missing-value treatment,
source and information-availability date.

### 2.2. Information-availability principle

Origination variables are treated as known at loan origination. Monthly
performance variables may only be used after confirming that they describe the
loan’s state at time `t`. Fields containing future delinquency, termination,
subsequent modification or other post-event information are excluded from the
predictor set.

## 3. Data storage and reproducibility

### 3.1. Storage architecture

Source files will be retained unchanged in `data/raw/`, cleaned intermediate
tables in `data/interim/`, and final analytical datasets in `data/processed/`.
This separation enables transformations to be reproduced from the primary
source through to the final sample.

### 3.2. Data provenance and versioning

A manifest will record each file’s source, download date, release version,
coverage period, file name, size, checksum and row count. Any change in the
processing rules will create a new dataset version rather than overwrite an
existing result.
