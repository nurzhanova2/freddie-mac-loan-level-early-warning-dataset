# Stages 7–9: Fannie Mae glossary, leakage register and outcomes

**Status: completed for fannie_v01.** Results apply to the Fannie Mae Primary
Dataset, 2008Q1 cohort, and do not automatically transfer to Freddie Mac.

## 7. Official glossary import

The SF Glossary & File Layout (Excel) was imported. The raw archive has 113
fields, while the glossary has 114 positions. Positions 1–113 map unambiguously
to the archive; position 114, Origination VantageScore 4.0, is absent from this
delivery format. The working dictionary has 113 records:
[fannie_2008q1_field_dictionary.csv](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).

## 8. Feature-eligibility register

A [leakage register](../../data/dictionaries/fannie_2008q1_leakage_register_v01.csv)
covers all 113 fields. In v01, 38 fields are candidate features; identifiers
are key fields only; 30 termination/post-event fields are label-only or
excluded; and workout/resolution fields are excluded from the first model. Zero
Balance Code and Zero Balance Effective Date are not features.

## 9. Three- and six-month labels

Formal adverse event v01 is a future delinquency status 03–98, the 90+ DPD
threshold. Early deterioration v01 is, for a loan current at t, a future status
01–98, the 30+ DPD threshold. XX and 99 are not interpreted as events.

A record is censored, in the absence of an already observed event, if a
termination occurs before the horizon ends, future status is unknown, or the
full number of future monthly observations is unavailable. Zero Balance Code is
not treated as default. The complete labels are in
[2008Q1_outcomes_v01.parquet](../../data/processed/2008Q1_outcomes_v01.parquet).

| Outcome | Labelled observations | Events | Event rate |
|---|---:|---:|---:|
| Formal adverse, 3 months | 20,007,896 | 264,892 | 1.3239% |
| Formal adverse, 6 months | 18,986,874 | 503,395 | 2.6513% |
| Early deterioration, 3 months | 19,152,309 | 758,624 | 3.9610% |
| Early deterioration, 6 months | 18,168,886 | 1,277,828 | 7.0331% |

Technical checks confirmed the 22,415,219-row match to the monthly panel, valid
label values of 0/1/null, and no nesting violations: a three-month event is
also a six-month event.

The outcomes are version v01: they are reproducible and suitable for initial
modelling, but any revision must use a new versioned specification rather than
retroactive alteration.
