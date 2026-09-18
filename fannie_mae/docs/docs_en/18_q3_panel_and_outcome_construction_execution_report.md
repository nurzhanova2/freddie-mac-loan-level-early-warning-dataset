# Stage 18. Construction of Q3 panels and outcomes

All nine Q3 cohorts were prepared under the same specification as the principal
Q1 sample. Each cohort has an analytical loan-month panel, event metadata, and
the six-month `formal_adverse_6m` and `early_deterioration_6m` outcomes. To
conserve disk capacity, a full cleaned copy of all 113 fields was not retained;
the compact panel preserves the admissible analytical fields while applying the
same cleaning rules, dictionary, and leakage control.

Global loan-month key uniqueness is assessed on standardised panels in
subsequent analytical queries. Q3 panels are not used to train the v01 models;
their purpose is independent robustness assessment of the fixed Q1 models.
