# Stages 4–6: Fannie Mae acquisition, cleaning and monthly panel

**Status: completed on 14 September 2026.** The results apply only to the
Fannie Mae Primary Dataset, acquisition cohort `2008Q1`.

## 4. Data acquisition and initial validation

The official Fannie Mae Data Dynamics archive `2008Q1.zip` was downloaded. It
contains one headerless member, `2008Q1.csv`. The compressed archive is
377,024,698 bytes and its uncompressed member is 6,060,016,939 bytes. Its
SHA-256 checksum is:

```text
6d9d3df9737fc321e70cc76bcbdf03a8bfe9ec190e472a1e1f2f9b9bd8460ae9
```

The file has 22,415,219 rows and 113 fields. Monthly reporting covers January
2008 through March 2026 and includes 380,832 unique loans. Every row has the
expected 113 fields and non-null `loan_identifier` and reporting-period values.
An exact external-sort audit of every `loan_identifier × monthly_reporting_period`
key found no duplicate-key groups or duplicate key rows.

The raw file is not globally ordered by the key. This is not an error, but it
means uniqueness cannot be assessed by comparing adjacent rows only; a complete
external-sort audit was therefore used.

The detailed report and manifest are available at [QA report](../../reports/2008Q1_raw_validation.json)
and [data manifest](../../data/manifests/data_manifest.csv).

## 5. Cleaning and standardisation

Cleaning was performed as a streaming process directly from the ZIP archive,
without extracting the 6 GB CSV into `raw/`. Blanks and whitespace-only values
were converted to `null`; key `MMYYYY` date fields were parsed as dates; and
identified numeric fields were converted to numeric form.

No invalid values were found in transformed date or numeric fields. The official
**SF Glossary & File Layout (Excel)** has been imported; positions 1–113 now
have exact names and types, and the dictionary is stored in
[`fannie_2008q1_field_dictionary.csv`](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).
Glossary position 114 is absent from the `2008Q1` raw archive. Special codes
are deliberately not recoded yet: their treatment will be determined only by
outcome and leakage-register rules.

The complete cleaned table with all 113 positions is stored as
[`2008Q1_cleaned.parquet`](../../data/interim/2008Q1_cleaned.parquet).

## 6. Construction of the monthly panel

In the current Fannie Mae format, acquisition characteristics and monthly
performance data already occur in a single file. No two-file join is required:
after key validation, the source was transformed into a
`loan_identifier × monthly_reporting_period` panel.

The base panel retains 35 fields: the identifier, observation date, key
origination characteristics, current balance/rate/loan-age measures, current
delinquency status, payment history and modification flag. The output has
22,415,219 rows and 35 fields:

[`2008Q1_monthly_panel_base.parquet`](../../data/processed/2008Q1_monthly_panel_base.parquet).

Zero Balance Code and Zero Balance Effective Date are retained separately in
[`2008Q1_event_metadata.parquet`](../../data/interim/2008Q1_event_metadata.parquet).
They are not model features and will only be used later to construct outcomes,
termination rules and competing risks.

The next stage is fixing the leakage register and constructing three- and
six-month labels without future information.
