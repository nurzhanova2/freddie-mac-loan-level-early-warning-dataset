# Execution of stages 1–3: dataset foundation

**Status as of 14 September 2026:** stages 1 and 3 have been completed for the
first project version; stage 2 has been completed for the official Release 47
schema and awaits validation against analytical files downloaded from Clarity.

## 1. Fixed design of the first iteration

The selected source is the Freddie Mac Single-Family Loan-Level Standard
Dataset, Release 47 (July 2026). The unit of observation will be the loan-month
(`loan_id × observation_month`). The study population is limited to individual
US single-family mortgage loans and does not represent a universal person-level
borrower dataset.

The first analytical iteration will use matched `sample_orig_YYYY.txt` and
`sample_perf_YYYY.txt` files downloaded from Clarity Data Intelligence.
Three- and six-month early-warning horizons have been fixed. For six-month
labelling, an observation date cannot be later than September 2025 if the
actual extract has a March 2026 performance cutoff. Each delivered extract will
be checked against its manifest before labels are created.

The decisions are recorded in
[`config/study_scope_v01.yml`](../../config/study_scope_v01.yml).

## 2. Official-schema verification

The official Freddie Mac General User Guide, File Layout and File Headers
effective from July 2026 have been retained in the project. A machine-readable
dictionary was automatically exported from the File Layout to
[`docs/data_dictionary_release_47.csv`](../../data_dictionary_release_47.csv).
It records 31 origination fields and 35 monthly-performance fields, including
their position, technical format and maximum length.

Every monthly field is currently marked `review_required` for predictor use.
The final decision will be recorded in a leakage register after the outcome
rules and the dates in the analytical extract have been checked. In particular,
termination, Zero Balance, subsequent modification and post-event expense
fields will not automatically be considered eligible predictors.

## 3. Storage, manifest and input control

The project structure now contains `data/raw/`, `data/interim/`,
`data/processed/`, `data/manifests/`, `docs/sources/`, `reports/`, `src/` and
`tests/`. Raw files remain unchanged. For each source, the manifest records its
URL, release, size, SHA-256 checksum and row count. Raw files are excluded from
Git using `.gitignore` to avoid redistributing data that may be subject to
Freddie Mac terms of use.

The publicly posted `release-47-sample-files.zip` archive was validated. It is
a valid schema example: its origination file contains 1,000 rows with 31 fields
and its performance file contains 1,011 rows with 35 fields; neither file has
unexpected field counts or duplicate relevant keys. However, there are zero
loan identifiers shared across the two files: 1,000 identifiers occur in the
origination file and 12 in the performance file. Therefore, this archive is not
a matched analytical sample and is not used to construct a loan-month panel or
evaluate models.

The complete QA output is stored in
[`reports/release_47_example_file_validation.json`](../../reports/release_47_example_file_validation.json),
and file provenance is in
[`data/manifests/data_manifest.csv`](../../data/manifests/data_manifest.csv).

## Next action

To continue, place a matched pair for one vintage in `data/raw/`:
`sample_orig_YYYY.txt` with `sample_perf_YYYY.txt`, or full
`orig_YYYYQn.txt` with `perf_YYYYQn.txt`, downloaded from Clarity. The next
steps will then be join validation, cleaning and construction of the monthly
panel.
