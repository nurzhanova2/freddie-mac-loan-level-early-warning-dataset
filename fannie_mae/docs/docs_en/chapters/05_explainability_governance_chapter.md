# Chapter 5. Explainability, stability and model-risk governance

## 5.1. Explainability

For the nonlinear model, the analysis will produce SHAP global importance, dependence plots and local explanations for individual loans. LIME may serve as an additional local check. Model explanations will not be interpreted as causal effects.

## 5.2. Stability

The study will test whether SHAP rankings and directions remain stable across periods, segments and class-imbalance strategies. Unstable or economically implausible explanations will be subject to audit.

## 5.3. Governance

The manifest, dictionary, outcome/censoring register, leakage register, temporal split, configurations and calibration results will form a reproducible audit trail. If leakage is found, the model and its explanations are invalid until retrained on eligible features.

## 5.4. Status

The audit framework is ready. SHAP/LIME figures and stability measurements will be added after model training.
