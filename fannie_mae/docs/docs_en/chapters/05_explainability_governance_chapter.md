# Chapter 5. Explainability, stability and model-risk governance

## 5.1. Explainability

For the nonlinear model, the analysis will produce SHAP global importance, dependence plots and local explanations for individual loans. LIME may serve as an additional local check. Model explanations will not be interpreted as causal effects.

## 5.2. Stability

The study will test whether SHAP rankings and directions remain stable across periods, segments and class-imbalance strategies. Unstable or economically implausible explanations will be subject to audit.

## 5.3. Governance

The manifest, dictionary, outcome/censoring register, leakage register, temporal split, configurations and calibration results will form a reproducible audit trail. If leakage is found, the model and its explanations are invalid until retrained on eligible features.

## 5.4. Status

Global and local TreeSHAP audits have been completed for both outcomes. For
formal adverse, leading factors include original interest rate, current
delinquency status, FICO, loan age, DTI and LTV/CLTV. Temporal rank stability
is high: Spearman correlation is 0.994615 for formal adverse and 0.984609 for
early deterioration. The results are documented in the
[stage-15 report](../15_explainability_execution_report.md).
