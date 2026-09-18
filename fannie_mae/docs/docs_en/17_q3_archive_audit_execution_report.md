# Stage 17. Audit of Q3 raw archives

## Objective

This stage establishes whether the available Fannie Mae Q3 cohorts are suitable
for a subsequent robustness assessment by origination quarter. They are not
added to the completed v01 development sample until they have undergone the
same preparation, outcome construction, and independent evaluation procedures.

## Audit scope

Nine archives were examined: `2006Q3`, `2008Q3`, `2012Q3`, `2014Q3`, `2016Q3`,
`2018Q3`, `2020Q3`, `2022Q3`, and `2024Q3`. No `2020Q2` archive was found in
`data/raw`; the available pandemic-period cohort used in this extension is
therefore `2020Q3`.

Each ZIP archive was inspected as a stream for readability, field count, blank
loan-month keys, adjacent duplicate keys, date coverage, and its SHA-256 digest.
The archives were not extracted into `raw`, preserving the source files without
modification.

## Result

All nine archives passed validation. Together they contain 281,706,562 rows;
every observed row has 113 fields, and no malformed rows, blank keys, or
adjacent duplicate keys were found. Reporting periods run from July of the
origination year through March 2026. The full evidence, including file sizes
and SHA-256 values, is in the [Q3 audit table](../../reports/q3_archive_audit_v01.csv);
the machine-readable aggregate is in the [JSON summary](../../reports/q3_archive_audit_v01_summary.json).

## Boundary of inference

Because the source files are not globally ordered by loan-month key, the absence
of adjacent duplicates does not prove global key uniqueness. An exact global
uniqueness audit will be performed after standardised panels are constructed in
Stage 18.

## Next stage

Stage 18 will apply the established cleaning, date transformation, panel
construction, and six-month outcome rules to the validated archives.
