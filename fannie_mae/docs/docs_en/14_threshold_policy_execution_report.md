# Stage 14. Calibration and threshold policy

**Status: in progress.** Calibrated XGBoost scores are translated into human
review triggers, not autonomous regulatory or credit decisions.

The policy chain is:

`data → early-warning score → deterioration detection → explanation → risk trigger → human supervisory decision`.

For formal adverse, the top 1% capacity policy yields 24.29% precision and
50.09% recall. For early deterioration, the top 5% monitoring policy yields
8.69% precision and 18.59% recall. The complete safeguards and tiers are in
[fannie_suptech_trigger_policy_v01.yml](../../config/fannie_suptech_trigger_policy_v01.yml).
