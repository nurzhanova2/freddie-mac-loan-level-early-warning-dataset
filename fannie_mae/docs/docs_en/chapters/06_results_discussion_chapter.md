# Chapter 6. Results, discussion and conclusions

## 6.1. Interpretation of predictive results

The empirical sample comprises 3,343,420 loans and 185,931,842 loan-month
observations. In the independent out-of-time period, XGBoost achieves ROC-AUC
of 0.8943 and PR-AUC of 0.2866 for formal adverse status, compared with 0.8794
and 0.1879 for logistic regression. For early deterioration, the corresponding
XGBoost values are 0.7310 and 0.0663, compared with 0.7254 and 0.0596 for the
benchmark. The complete comparison is reported in [Table 6.1](../../../reports/models/final_model_comparison_v01.csv).

The observed improvement supports the use of nonlinear modelling in this
sample, particularly for the rarer formal-adverse outcome. It does not imply
that the estimated relationships will reproduce unchanged in other mortgage
populations or future economic conditions.

## 6.2. Interpretation of alert policies

At a top-1% review capacity, the formal-adverse policy identifies 50.09% of
events with precision of 24.29% and mean lead time of 2.467 months. At a top-5%
capacity, the early-deterioration policy has precision of 8.69%, recall of
18.59%, and mean lead time of 2.993 months. These figures quantify a trade-off:
the former tier is suitable for a concentrated priority queue, whereas the
latter provides a broader monitoring signal that requires expert assessment.
They do not establish the economic benefit of a particular intervention.

The model and trigger results are summarised in **Figure 6.1** —
[“Model and trigger summary”](../../../reports/figures/final_v01/final_model_and_trigger_summary_v01.png)
and **Table 6.2** — [“Final study metrics”](../../../reports/models/final_dissertation_summary_v01.csv).

## 6.3. Limitations

The conclusions are restricted to the Fannie Mae Primary Dataset and seven Q1
acquisition cohorts. Application to Freddie Mac requires an independent
harmonisation of fields and outcomes. The models were trained on deterministic
case-control samples, with calibration and final evaluation conducted on
natural-rate validation and out-of-time samples. Observed associations and SHAP
values are not causal estimates. Additional cohorts, including non-Q1
originations, are required to assess robustness to acquisition-season effects.

## 6.4. Conclusion

Within the stated empirical scope, the working hypothesis is supported: an
explainable loan-month model evaluated on future periods can generate early
risk signals with measurable discrimination, calibrated probabilities, and
limited lead time. The principal contribution is the reproducible integration
of temporal validation, leakage control, probability calibration, threshold
policy, and explanation into one analytical procedure for expert review.
