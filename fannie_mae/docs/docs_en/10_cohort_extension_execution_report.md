# Stage 10. Fannie Mae acquisition-cohort expansion

**Status: completed for the fixed stage-10 sample.** The 2008Q1 pilot has been extended with
2006Q1, 2012Q1, 2016Q1, 2020Q1, 2022Q1 and 2024Q1. Each archive underwent independent
validation, cleaning, panel construction and v01 outcome creation. Raw archives
were neither pooled nor changed.

| Cohort | Loan-month rows | Observation period | 6m formal adverse rate | 6m early deterioration rate |
|---|---:|---|---:|---:|
| 2006Q1 | 18,198,237 | Jan 2006–Mar 2026 | 1.997% | 6.205% |
| 2008Q1 | 22,415,219 | Jan 2008–Mar 2026 | 2.651% | 7.033% |
| 2012Q1 | 50,416,530 | Jan 2012–Mar 2026 | 0.231% | 1.353% |
| 2016Q1 | 26,176,557 | Jan 2016–Mar 2026 | 0.601% | 2.494% |
| 2020Q1 | 27,521,067 | Jan 2020–Mar 2026 | 1.011% | 2.648% |
| 2022Q1 | 36,774,217 | Jan 2022–Mar 2026 | 0.530% | 2.535% |
| 2024Q1 | 4,430,015 | Jan 2024–Mar 2026 | 0.541% | 2.413% |

The result is 185,931,842 loan-month observations and 3,343,420 distinct loans
(summed across cohorts; a loan cannot move between acquisition cohorts). Rates are calculated only
among labelled, uncensored observations in the relevant v01 risk set; they are
not rates over all raw records.

Machine-readable summary: [CSV](../../reports/fannie_cohort_summary_v01.csv)
and [JSON](../../reports/fannie_cohort_summary_v01.json).

Final pooling will occur only at processed level with a mandatory
acquisition-cohort variable and without mixing Freddie Mac data. Further
extension to the full annual Q1 sample will use the same pipeline, but it is
not a prerequisite for feature engineering or modelling.
