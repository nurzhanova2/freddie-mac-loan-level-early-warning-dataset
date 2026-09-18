# Stage 19. Comparative analysis of Q1 and Q3 cohorts

## Objective

This stage assesses whether first- and third-quarter acquisition cohorts are
comparable enough for a subsequent transportability assessment. It neither
re-trains the models nor changes the v01 development sample; instead, it
provides the descriptive basis for independent Q3 evaluation.

## Method

Seven Fannie Mae Q1 cohorts and nine Q3 cohorts were compared. For matched
acquisition years, the analysis considered origination characteristics, current
30+ and 90+ DPD shares, and the two six-month outcome rates among eligible
observations. All labels use the same censoring and leakage-control rules.

## Results

Q1 and Q3 are not identical samples. In 2020, the formal-adverse rate is
1.0113% for Q1 and 0.2646% for Q3, while the early-deterioration rate is
2.6480% and 1.5580%. In 2022, rates are higher for Q3: 0.8374% versus 0.5304%
for formal adverse and 3.2676% versus 2.5353% for early deterioration. The
magnitude and direction of differences vary by year; they cannot therefore be
attributed solely to the acquisition quarter or to a single macroeconomic
factor.

The full cohort summary is in [Table 19.1](../../reports/q1_q3_robustness_v01/01_q1_q3_cohort_summary.csv),
and matched-year comparison is in [Table 19.2](../../reports/q1_q3_robustness_v01/02_matched_q1_q3_comparison.csv).
Outcome and origination-characteristic comparisons are shown in
[Figure 19.1](../../reports/figures/q1_q3_robustness_v01/01_q1_q3_outcome_comparison.png)
and [Figure 19.2](../../reports/figures/q1_q3_robustness_v01/02_q1_q3_origination_comparison.png).

## Conclusion

The Q3 extension strengthens the research design by separating performance on
the initially selected Q1 vintages from robustness across another origination
quarter and different time regimes. The next step is an independent Q3
evaluation of the fixed models using ROC-AUC, PR-AUC, calibration, and alert
policy metrics. The descriptive differences in this stage are not causal
estimates.
