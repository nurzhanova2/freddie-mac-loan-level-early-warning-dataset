# Chapter 6. Results, discussion and conclusions

## 6.1. Purpose of the chapter

The sample contains 3,343,420 loans and 185,931,842 loan-month observations.
On the independent out-of-time period, XGBoost exceeds logistic regression:
formal adverse has ROC-AUC 0.8943 and PR-AUC 0.2866; early deterioration has
0.7310 and 0.0663. The comparison is reported in
[Table 6.1](../../../reports/models/final_model_comparison_v01.csv).

For formal adverse, the top-1% policy captures 50.09% of events at 24.29%
precision and mean lead time 2.467 months. For early deterioration, the top-5%
policy has 8.69% precision, 18.59% recall, and mean lead time 2.993 months.

## 6.2. Limitations

Conclusions are limited to the Fannie Mae Primary Dataset and seven Q1
acquisition cohorts. External application to Freddie Mac requires separate
field and outcome harmonisation. Observational associations and SHAP values do
not prove causation; the prototype supports expert review rather than autonomous
decision-making.

## 6.3. Status

Core results, temporal validation, calibration, trigger policy, and explainability
analysis have been completed. Robustness checks on additional acquisition
cohorts or origination quarters remain a valuable extension.

## 6.4. Overall conclusion

The working hypothesis is supported within the study sample: an explainable
loan-month model, validated on future periods, produces useful early risk
signals. The final representation is in **Figure 6.1** —
[“Model and trigger summary”](../../../reports/figures/final_v01/final_model_and_trigger_summary_v01.png)
and **Table 6.2** — [“Final study metrics”](../../../reports/models/final_dissertation_summary_v01.csv).
