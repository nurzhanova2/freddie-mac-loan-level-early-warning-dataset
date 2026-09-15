# Chapter 1. Research concept and design

## 1.1. Research problem

The dissertation develops an **explainable SupTech-inspired early-warning
system for mortgage-credit deterioration** before formal default. The object is
an individual mortgage loan in the U.S. single-family segment, not a universal
person-level borrower model. SupTech-inspired means that the research emulates
supervisory analytics logic; it does not claim deployment by a central bank.
The official dissertation title remains unchanged; its relation to the
practical result is stated in the [abstract](00_annotation.md).

## 1.2. Aim, subject and hypothesis

The aim is to develop and validate a reproducible loan-level risk-prediction
system that turns observations into an early warning score, explanation, and
trigger for a human supervisory decision. The subject is future deterioration
using information available at the observation date. The working hypothesis is
that a temporally valid loan-month model can provide useful early warning, while
SHAP/LIME support decision audit but do not establish causality.

## 1.3. Research design

The prototype architecture is:

`data → early-warning score → deterioration detection → explanation → risk trigger → human supervisory decision`.

Performance is assessed using discrimination, calibration, lead time, false
alarms, stability and out-of-time validation. Fannie Mae and Freddie Mac remain
independent workstreams; the current cycle contains seven Q1 acquisition cohorts
from the Fannie Mae Primary Dataset. The sources are never pooled.

## 1.4. Dissertation structure

Chapter 2 describes data; Chapter 3 specifies outcomes, features and leakage; Chapter 4 addresses modelling and validation; Chapter 5 addresses explainability and governance; Chapter 6 reports results, limitations and conclusions.
