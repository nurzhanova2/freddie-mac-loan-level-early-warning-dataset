# Chapter 4. Early-warning modelling and temporal validation

## 4.1. Modelling rationale

The empirical comparison uses logistic regression and XGBoost. Logistic
regression provides a transparent reference against which the incremental value
of nonlinear interactions can be assessed. XGBoost is included because the
relationship between loan characteristics, payment status, and subsequent
deterioration need not be linear. The study does not interpret superior
predictive performance as evidence of a causal relationship between a feature
and an outcome.

## 4.2. Temporal validation design

To reflect the prospective use of an early-warning model, observations are
partitioned only by calendar time: January 2006–December 2016 for training,
January 2017–December 2020 for validation, and January 2021–September 2025 for
the independent out-of-time test. September 2025 is the latest admissible
prediction month because the source ends in March 2026 and a complete
six-month outcome window is required. The design is shown in **Figure 4.1** —
[“Chronological split”](../../../reports/figures/splits/fannie_temporal_split_timeline_v01.png).

All transformations, feature selection, sampling decisions, and calibration
mapping are estimated without access to the out-of-time period. The loan
identifier is retained solely for linkage and audit, not as a predictor. Thus,
repeated monthly observations of the same loan are consistent with the intended
dynamic-monitoring setting and do not expose the model to the identifier or to
future-month values. The resulting sample composition is reported in
**Table 4.1** — [“Temporal-split summary”](../../../reports/splits/fannie_temporal_split_v01_summary.csv).

## 4.3. Evaluation criteria

ROC-AUC and PR-AUC assess ranking performance, whereas calibration assesses
whether predicted probabilities correspond to observed frequencies. For a binary
outcome $y_i \in \{0,1\}$, the Brier score is
$\operatorname{BS}=\frac{1}{n}\sum_{i=1}^{n}(y_i-\hat{p}_i)^2$; lower values
indicate smaller squared probability errors. Alert thresholds are additionally
evaluated by precision, recall, false-positive burden, and lead time, since a
high-ranking model is not by itself sufficient to define a review policy.

## 4.4. Empirical model results

The logistic benchmark obtains out-of-time ROC-AUC values of 0.8794 for formal
adverse status and 0.7254 for early deterioration. Isotonic calibration reduces
its Brier score from 0.021646 to 0.004320 for formal adverse status and from
0.059429 to 0.022507 for early deterioration. These results establish a
calibrated linear reference rather than a final model selection. They are
reported in **Table 4.2** — [“Logistic baseline”](../../../reports/models/logistic_baseline_v01_summary.csv),
**Table 4.3** — [“Calibration summary”](../../../reports/models/logistic_isotonic_calibration_v01_summary.csv),
and **Figure 4.2** — [“Formal-adverse reliability”](../../../reports/figures/models/formal_adverse_6m_calibration_v01.png).

On the independent out-of-time period, XGBoost yields ROC-AUC of 0.8943 and
PR-AUC of 0.2866 for formal adverse status, and 0.7310 and 0.0663 for early
deterioration. The numerical comparison is presented in [Table 6.1](../../../reports/models/final_model_comparison_v01.csv).
The results support the use of XGBoost as the leading model in this empirical
sample; the scope of that conclusion is considered in Chapter 6.
