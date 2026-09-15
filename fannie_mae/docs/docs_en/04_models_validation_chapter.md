# Chapter 4. Early-warning modelling and temporal validation

## 4.1. Candidate models

Logistic regression will be the baseline. XGBoost or LightGBM will be the nonlinear competitor. A Cox proportional hazards model will assess time to adverse event; a survival forest or survival gradient boosting model may be added if resources allow. No model is declared best before validation.

## 4.2. Temporal split

The sample is split only in time: train covers January 2006–December 2016,
validation covers January 2017–December 2020, and the out-of-time test covers
January 2021–September 2025. The last date is selected because the source data
end in March 2026, leaving a complete six-month future window. The scheme is
shown in **Figure 4.1** — [“Chronological split”](../../reports/figures/splits/fannie_temporal_split_timeline_v01.png).

The volumes, eligible observations, and rates for the two six-month outcomes
are reported in **Table 4.1** — [“Temporal-split summary”](../../reports/splits/fannie_temporal_split_v01_summary.csv).
Preprocessing, feature selection, calibration, and class balancing are fitted
only on the training period. Loan identifier is used only for joining and audit,
never as a model feature. A loan may occur in several time sections of the
panel; this is appropriate for dynamic monitoring because the model cannot use
the identifier and is never fitted on future months.

## 4.3. Evaluation

ROC-AUC, PR-AUC, recall, precision, Brier score, calibration curve, calibration slope/intercept, lead time, false-positive rate and cost-sensitive measures will be reported. C-index and time-dependent AUC are planned for survival models.

For binary outcome $y_i \in \{0,1\}$, the Brier score is
$\operatorname{BS} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \hat{p}_i)^2$. Lower values
indicate more accurate predicted probabilities. After case-control training, a
calibration mapping is fitted on validation only and assessed on the independent
out-of-time test.

## 4.4. Status

Stage 12 is complete for the primary six-month evaluation frame. Train contains
62,310,424 eligible formal-adverse observations and 61,008,721 eligible
early-deterioration observations; the out-of-time test contains 65,970,573 and
65,331,004, respectively. Model-performance results are not yet available: they
will be reported only after fitting on train and tuning on validation.

The first logistic baseline has now been fitted as a ranking-oriented
experiment. Out-of-time ROC-AUC is 0.8794 for formal adverse and 0.7254 for
early deterioration. PR-AUC, sample volumes, and the limitation of uncalibrated
probabilities are reported in **Table 4.2** —
[“Logistic baseline v01”](../../reports/models/logistic_baseline_v01_summary.csv).
The detailed log is in the [stage-13 report](13_initial_models_execution_report.md).
For the logistic model, isotonic calibration reduces out-of-time Brier score
from 0.021646 to 0.004320 for formal adverse and from 0.059429 to 0.022507 for
early deterioration; see **Table 4.3** —
[“Calibration summary”](../../reports/models/logistic_isotonic_calibration_v01_summary.csv)
and **Figure 4.2** — [“Formal-adverse reliability”](../../reports/figures/models/formal_adverse_6m_calibration_v01.png).
