# freddie-mac-loan-level-early-warning-dataset

The repository keeps provider-specific work fully separated:

- `freddie_mac/` — the original Freddie Mac work, sources, pipeline and bilingual documentation.
- `fannie_mae/` — the active Fannie Mae Primary Dataset work, sources, pipeline and bilingual documentation.

The datasets must never be combined into one training table. The active dataset
is Fannie Mae; Freddie Mac remains preserved as a separate implementation.
