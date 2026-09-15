# Stages 1–3: Fannie Mae Primary Dataset

**Status: completed for the first `fannie_v01` iteration.** Freddie Mac has
been retained independently in `freddie_mac/`; its files, documentation and
results have not been altered.

## 1. Dataset design

The first implementation uses the Fannie Mae Single-Family Loan Performance
**Primary Dataset**, acquisition cohort `2008Q1`. The object of analysis is an
individual Fannie Mae mortgage loan, and the unit of observation is
`loan_identifier × monthly_reporting_period`.

The selected Primary Dataset is a disclosed subset of conventional,
fully-amortizing, full-documentation, fixed-rate single-family mortgages with
terms of 30 years or less. The HARP dataset, multifamily loans and Freddie Mac
records are excluded. Three- and six-month prediction horizons are specified.
Event labels have not yet been created; their definitions will be approved after
the outcome/censoring register and actual file coverage have been fixed.

The machine-readable scope is stored in
[`study_scope_fannie_v01.yml`](../../config/study_scope_fannie_v01.yml).

## 2. Documentation and field structure

The `2008Q1.zip` archive contains one headerless CSV member, `2008Q1.csv`,
with 113 pipe-delimited fields. Actual records and the official Fannie Mae
layout identify key positions: `loan_identifier` is position 2,
`monthly_reporting_period` position 3, original FICO 24, original DTI 23,
original LTV/CLTV 20/21, current delinquency status 40, modification flag 42,
and Zero Balance Code/effective date 44/45.

The current **SF Glossary & File Layout (Excel)** has been imported from
`docs/sources/`. All 113 raw positions have official names, types and
descriptions in [`fannie_2008q1_field_dictionary.csv`](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).
The glossary also contains position 114, which is absent from this 113-column
archive; this is a format-version difference. A field name does not make a
field an eligible model feature: leakage review is separate.

## 3. Storage and reproducibility

The repository is divided into two isolated workstreams:

```text
freddie_mac/   # prior independent Freddie Mac implementation
fannie_mae/    # active Fannie Mae implementation
```

Within `fannie_mae/`, the project uses `data/raw/`, `data/interim/`,
`data/processed/`, `data/manifests/`, `docs/`, `reports/`, `src/` and `tests/`.
The raw ZIP is immutable. The validation script creates a manifest containing
file size, SHA-256, archive-member name and row count. Source files are ignored
by Git.

## Next step

The full data dictionary has been created. The next work is an outcome/censoring
register and leakage register, followed by construction of three- and six-month
labels.
