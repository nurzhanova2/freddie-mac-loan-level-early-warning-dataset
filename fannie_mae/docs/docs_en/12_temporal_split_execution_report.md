# Stage 12. Temporal sample split

**Status: complete for the primary six-month horizon.** The split is fixed in
`config/fannie_temporal_split_v01.yml` and is applied as a rule to processed
panels, without making a duplicate copy of hundreds of millions of rows.

| Split | Prediction-date period *t* | Formal adverse: eligible / event rate | Early deterioration: eligible / event rate |
|---|---|---:|---:|
| Train | 2006-01–2016-12 | 62,310,424 / 1.2201% | 61,008,721 / 3.7387% |
| Validation | 2017-01–2020-12 | 33,716,498 / 1.1234% | 33,237,970 / 3.0178% |
| Out-of-time test | 2021-01–2025-09 | 65,970,573 / 0.4933% | 65,331,004 / 2.3412% |

The full machine-readable output is **Table 12.1**:
[fannie_temporal_split_v01_summary.csv](../../reports/splits/fannie_temporal_split_v01_summary.csv).
Composition by acquisition cohort is **Table 12.2**:
[fannie_temporal_split_v01_by_cohort.csv](../../reports/splits/fannie_temporal_split_v01_by_cohort.csv).
The temporal boundaries are in **Figure 12.1**:
[fannie_temporal_split_timeline_v01.png](../../reports/figures/splits/fannie_temporal_split_timeline_v01.png).
The automated boundary audit is **Table 12.3**:
[fannie_temporal_split_v01_boundary_audit.csv](../../reports/splits/fannie_temporal_split_v01_boundary_audit.csv).

## Leakage control

Random row shuffling is prohibited. Imputation statistics, categorical encoding,
feature selection, class weighting, and calibration will be fitted on train
only. Prediction dates after September 2025 are excluded from the strict
six-month evaluation because their full future window is not available by March
2026. Loan identifier is not a feature.

The same loan may occur in several temporal sections, as expected in a dynamic
monitoring task: a prediction is made each month using information available at
that month. This is not leakage because identifier is excluded and future months
never enter training.

## Model-ready data contract

The v01 field specification is in
[`fannie_feature_spec_v01.yml`](../../config/fannie_feature_spec_v01.yml); it
contains 25 permitted model features. All 25 fields were programmatically
verified in every processed panel. The SQL contract joining panels and outcomes,
selecting labels, and assigning a split is
[`fannie_model_input_v01.sql`](../../sql/fannie_model_input_v01.sql). It does
not materialise another persistent copy of the panels, preserving both
provenance and disk space. Stage 12 is fully complete.
