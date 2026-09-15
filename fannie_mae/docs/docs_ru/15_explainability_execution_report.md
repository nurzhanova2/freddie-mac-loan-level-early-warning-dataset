# Этап 15. Объяснимость и устойчивость модели

**Статус: выполнено для глобального, локального и temporal SHAP-аудита XGBoost.**
SHAP значения рассчитаны как TreeSHAP contributions модели XGBoost на
независимых выборках; они описывают вклад признаков в score модели и не
интерпретируются как причинные эффекты.

Для formal adverse ключевыми факторами являются исходная процентная ставка,
текущий статус просрочки, FICO, возраст кредита, DTI и LTV/CLTV. Для early
deterioration наиболее важны FICO, исходная процентная ставка, срок до
погашения, возраст кредита и число заёмщиков. Глобальные результаты приведены
на [рисунке 15.1](../../reports/figures/models/formal_adverse_6m_xgboost_shap_global_v01.png)
и [рисунке 15.2](../../reports/figures/models/early_deterioration_6m_xgboost_shap_global_v01.png).

Локальные объяснения сформированы для highest-scored out-of-time alerts; ID
кредита заменён стабильным маскированным идентификатором. См. [formal adverse](../../reports/figures/models/formal_adverse_6m_xgboost_local_alert_shap_v01.png)
и [early deterioration](../../reports/figures/models/early_deterioration_6m_xgboost_local_alert_shap_v01.png).

Устойчивость global importance высока: Spearman correlation рангов между
validation и out-of-time равна 0,994615 для formal adverse и 0,984609 для early
deterioration; пересечение top-10 факторов — 10 и 9 признаков соответственно.
Таблицы стабильности: [formal adverse](../../reports/models/formal_adverse_6m_xgboost_shap_temporal_stability_v01.csv)
и [early deterioration](../../reports/models/early_deterioration_6m_xgboost_shap_temporal_stability_v01.csv).
