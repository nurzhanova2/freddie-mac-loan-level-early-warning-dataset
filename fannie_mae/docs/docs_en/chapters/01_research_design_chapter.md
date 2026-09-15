# Chapter 1. Research concept and design

## 1.1. Research problem

Mortgage-credit deterioration may become observable in monthly servicing data
before it reaches the 90+ days-past-due threshold used here as a formal adverse
outcome. The research problem is therefore to distinguish, using only
information available at a given reporting month, loan-month observations that
require earlier expert attention. The study addresses this problem through an
explainable loan-level predictive model for the U.S. single-family mortgage
segment.

## 1.2. Aim, subject and working hypothesis

The aim is to develop and evaluate a reproducible procedure for estimating the
risk of subsequent mortgage-credit deterioration. Its subject is the
relationship between information available at the observation date and a future
six-month deterioration outcome. The working hypothesis is that a model
validated on later periods can provide practically informative early-warning
signals. Explanation methods are used to audit the model's associations with
input variables; they do not identify causal mechanisms.

## 1.3. Research design

The analytical sequence links the research objective to a review process:

`data → risk estimate → deterioration signal → explanation → alert tier → expert review`.

The sequence separates prediction from decision-making. A model score ranks
observations by estimated risk, while a pre-specified threshold determines
which observations are presented for review. Performance is assessed through
discrimination, probability calibration, alert precision and recall, lead time,
and temporal stability. The Fannie Mae and Freddie Mac sources are maintained
as separate empirical workstreams because their field definitions and data
generation processes are not assumed to be interchangeable.

## 1.4. Dissertation structure

Chapter 2 establishes the empirical sample and data-quality controls. Chapter
3 defines the outcomes, admissible predictors, and information-leakage rules.
Chapter 4 describes modelling, calibration, and temporal validation. Chapter
5 examines explainability and model governance. Chapter 6 interprets the
results within the scope and limitations of the study.
