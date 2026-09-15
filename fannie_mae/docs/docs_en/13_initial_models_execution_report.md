# Stage 13. Initial baseline models

**Status: logistic baseline models are complete for both six-month outcomes.**
Separate models were fitted for `formal_adverse_6m` (90+ DPD) and
`early_deterioration_6m` (30+ DPD), using only the 25 v01 features fixed as
available at prediction date *t*.

For CPU-feasible fitting, train is a deterministic case-control sample:
628,102 rows for formal adverse and 604,627 for early deterioration. Validation
and out-of-time test are independent 1% deterministic samples retaining the
natural event rate. This preserves ranking metrics such as ROC-AUC and PR-AUC,
but makes raw probabilities uncalibrated; calibration is deferred to stage 14.

| Target | Validation ROC-AUC / PR-AUC | Out-of-time ROC-AUC / PR-AUC |
|---|---:|---:|
| Formal adverse, 6m | 0.8592 / 0.2044 | 0.8794 / 0.1879 |
| Early deterioration, 6m | 0.7450 / 0.0930 | 0.7254 / 0.0596 |

The full results are **Table 13.1**:
[logistic_baseline_v01_summary.csv](../../reports/models/logistic_baseline_v01_summary.csv).
Sample manifests: [formal adverse](../../data/model_samples_v01/formal_adverse_6m_sample_manifest_v01.json)
and [early deterioration](../../data/model_samples_v01/early_deterioration_6m_sample_manifest_v01.json).

## Current interpretation

The formal-adverse model ranks future 90+ DPD events and non-events well in the
later out-of-time period. Early deterioration is harder: its ROC-AUC and,
particularly, PR-AUC are lower, consistent with the earlier and less specific
nature of a 30+ DPD event. These are not yet production probabilities or a
final model comparison: the nonlinear competitor, calibration, threshold
policy, and SHAP analysis are still pending.

## Nonlinear competitor and stage-13 conclusion

XGBoost was trained on the same fixed samples and outperformed logistic
regression on the out-of-time test. Formal adverse achieved ROC-AUC 0.8943 and
PR-AUC 0.2866; early deterioration achieved 0.7310 and 0.0663. XGBoost is thus
the leading ranking model for stage 14, while logistic regression remains the
interpretable baseline. Stage 13 is complete.

## Probability calibration

Because train uses case-control sampling, its raw logistic score cannot be
interpreted as an event probability in the natural population. The logistic
model ranks observations by

$$
\hat{p}_i = \frac{1}{1 + \exp\left[-\left(\beta_0 + \sum_{j=1}^{m}\beta_j x_{ij}\right)\right]}.
$$

An isotonic non-decreasing mapping \(g\) is fitted on the natural-rate
validation sample, yielding \(\tilde p_i = g(\hat p_i)\). On the independent
out-of-time test, probabilistic accuracy is assessed by the Brier score:

$$
\operatorname{BS} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \tilde{p}_i)^2.
$$

| Target | Brier: before calibration | Brier: isotonic calibration | ROC-AUC after calibration |
|---|---:|---:|---:|
| Formal adverse, 6m | 0.021646 | 0.004320 | 0.8790 |
| Early deterioration, 6m | 0.059429 | 0.022507 | 0.7251 |

Results are in **Table 13.2** —
[“Logistic-model calibration”](../../reports/models/logistic_isotonic_calibration_v01_summary.csv).
Reliability diagrams: **Figure 13.1** —
[formal adverse](../../reports/figures/models/formal_adverse_6m_calibration_v01.png),
and **Figure 13.2** —
[early deterioration](../../reports/figures/models/early_deterioration_6m_calibration_v01.png).

Isotonic calibration substantially improves the Brier score. Its small PR-AUC
decline reflects tied calibrated probabilities introduced by the monotonic
mapping; ranking models should be compared using their original ROC-AUC and
PR-AUC, while calibrated scores support probability communication and later
threshold selection.
