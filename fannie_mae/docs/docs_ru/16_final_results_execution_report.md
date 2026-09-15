# Этап 16. Итоговые результаты и выводы

**Статус: выполнено для текущей фиксированной выборки Fannie Mae.**
Исследование сформировало воспроизводимый SupTech-oriented прототип раннего
предупреждения ухудшения ипотечного кредитного качества.

| Компонент | Итог |
|---|---|
| Ведущая модель | XGBoost v01 |
| Formal adverse, 6m | ROC-AUC 0,8943; PR-AUC 0,2866 |
| Early deterioration, 6m | ROC-AUC 0,7310; PR-AUC 0,0663 |
| Formal adverse trigger | Top 1%; precision 24,29%; recall 50,09%; lead time 2,467 мес. |
| Early deterioration trigger | Top 5%; precision 8,69%; recall 18,59%; lead time 2,993 мес. |
| Explanation stability | Spearman 0,994615 и 0,984609 для двух outcomes |

Сводные показатели приведены в **таблице 16.1** —
[final_dissertation_summary_v01.csv](../../reports/models/final_dissertation_summary_v01.csv),
а итоговое сопоставление модели и triggers — на **рисунке 16.1** —
[final_model_and_trigger_summary_v01.png](../../reports/figures/final_v01/final_model_and_trigger_summary_v01.png).

Научный результат состоит в объединении temporal validation, контроля leakage,
калибровки, explainability и policy thresholds в единую систему раннего
предупреждения. Практический результат — приоритизация экспертной проверки, а
не автономное принятие решений. Ограничения и направления robustness check
зафиксированы в главе 6.
