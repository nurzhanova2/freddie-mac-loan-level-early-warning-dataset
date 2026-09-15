-- Fannie Mae model-input contract v01.
-- Bind :target to either formal_adverse_6m or early_deterioration_6m.
-- Apply feature transformations in a fitted train-only pipeline, not in SQL.
-- The lists of panel and outcome Parquet paths are deliberately explicit to
-- preserve provenance and prevent accidental inclusion of Freddie Mac data.

WITH panel AS (
  SELECT *, regexp_extract(filename, '([0-9]{4}Q[1-4])_', 1) AS acquisition_cohort
  FROM read_parquet([
    'fannie_mae/data/processed/2006Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2008Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2012Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2016Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2020Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2022Q1_monthly_panel_base.parquet',
    'fannie_mae/data/processed/2024Q1_monthly_panel_base.parquet'
  ], filename=true)
), outcomes AS (
  SELECT *, regexp_extract(filename, '([0-9]{4}Q[1-4])_', 1) AS acquisition_cohort
  FROM read_parquet([
    'fannie_mae/data/processed/2006Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2008Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2012Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2016Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2020Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2022Q1_outcomes_v01.parquet',
    'fannie_mae/data/processed/2024Q1_outcomes_v01.parquet'
  ], filename=true)
), labelled AS (
  SELECT
    p.loan_identifier,
    p.monthly_reporting_period,
    p.acquisition_cohort,
    CASE
      WHEN p.monthly_reporting_period < DATE '2017-01-01' THEN 'train'
      WHEN p.monthly_reporting_period < DATE '2021-01-01' THEN 'validation'
      WHEN p.monthly_reporting_period <= DATE '2025-09-01' THEN 'out_of_time_test'
      ELSE 'excluded_incomplete_six_month_window'
    END AS split,
    o.formal_adverse_6m,
    o.early_deterioration_6m,
    p.original_interest_rate, p.original_upb, p.original_loan_term,
    p.original_loan_to_value_ratio_ltv, p.original_combined_loan_to_value_ratio_cltv,
    p.number_of_borrowers, p.debt_to_income_dti, p.borrower_credit_score_at_origination,
    p.co_borrower_credit_score_at_origination, p.mortgage_insurance_percentage,
    p.current_interest_rate, p.current_actual_upb, p.loan_age,
    p.remaining_months_to_legal_maturity, p.remaining_months_to_maturity,
    p.channel, p.first_time_home_buyer_indicator, p.loan_purpose, p.property_type,
    p.number_of_units, p.occupancy_status, p.property_state, p.amortization_type,
    p.current_loan_delinquency_status, p.modification_flag
  FROM panel p
  INNER JOIN outcomes o
    ON p.acquisition_cohort = o.acquisition_cohort
   AND p.loan_identifier = o.loan_identifier
   AND p.monthly_reporting_period = o.monthly_reporting_period
)
SELECT *
FROM labelled
WHERE split <> 'excluded_incomplete_six_month_window'
  AND (:target = 'formal_adverse_6m' AND formal_adverse_6m IS NOT NULL
       OR :target = 'early_deterioration_6m' AND early_deterioration_6m IS NOT NULL);
