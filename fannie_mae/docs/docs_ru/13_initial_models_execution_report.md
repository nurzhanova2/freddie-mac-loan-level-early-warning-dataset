# Этап 13. Первые baseline-модели

**Статус: логистические baseline-модели выполнены для двух шестимесячных
outcomes.** Модели обучены отдельно для `formal_adverse_6m` (90+ DPD) и
`early_deterioration_6m` (30+ DPD). Использованы только 25 v01 признаков,
зафиксированных до прогнозной даты *t*.

Для CPU-выполнимости train построен как детерминированная case-control
подвыборка: 628 102 строк для formal adverse и 604 627 строк для early
deterioration. Validation и out-of-time test — независимые 1%-ные
детерминированные выборки с естественной частотой событий. Это сохраняет
корректность ranking-метрик ROC-AUC и PR-AUC, но делает сырые вероятности
некалиброванными; калибровка будет выполнена на этапе 14.

| Target | Validation ROC-AUC / PR-AUC | Out-of-time ROC-AUC / PR-AUC |
|---|---:|---:|
| Formal adverse, 6m | 0,8592 / 0,2044 | 0,8794 / 0,1879 |
| Early deterioration, 6m | 0,7450 / 0,0930 | 0,7254 / 0,0596 |

Полная таблица результатов — **таблица 13.1**:
[logistic_baseline_v01_summary.csv](../../reports/models/logistic_baseline_v01_summary.csv).
Манифесты выборок: [formal adverse](../../data/model_samples_v01/formal_adverse_6m_sample_manifest_v01.json)
и [early deterioration](../../data/model_samples_v01/early_deterioration_6m_sample_manifest_v01.json).

## Интерпретация на текущем шаге

Модель для formal adverse хорошо различает будущие 90+ DPD случаи и
несобытия на более позднем out-of-time периоде. Задача early deterioration
сложнее: её ROC-AUC и особенно PR-AUC ниже, что согласуется с более ранним и
менее специфичным характером 30+ DPD. Эти числа не следует трактовать как
готовую вероятность дефолта или окончательное преимущество модели: сравнение
с нелинейной моделью, калибровка, пороговая политика и SHAP ещё не выполнены.

## Нелинейный конкурент и итог этапа 13

XGBoost обучен на тех же фиксированных выборках и превзошёл логистическую
модель на out-of-time test. Для formal adverse получены ROC-AUC 0,8943 и
PR-AUC 0,2866; для early deterioration — 0,7310 и 0,0663. Следовательно,
XGBoost выбран как ведущая ranking-модель для этапа 14, а логистическая
регрессия сохраняется как интерпретируемый baseline.

Этап 13 завершён: построены две baseline-модели для обеих целей, сравнение
выполнено на одинаковом out-of-time периоде. Затем XGBoost откалиброван только
на validation; его out-of-time Brier score составил 0,004065 для formal adverse
и 0,022468 для early deterioration. См. [метрики XGBoost](../../models/xgboost_v01/)
и рисунки калибровки: [formal adverse](../../reports/figures/models/formal_adverse_6m_xgboost_calibration_v01.png),
[early deterioration](../../reports/figures/models/early_deterioration_6m_xgboost_calibration_v01.png).

## Калибровка вероятностей

Поскольку train построен case-control методом, его исходная логистическая
оценка не может трактоваться как вероятность события в естественной популяции.
Логистическая модель ранжирует наблюдения по формуле

$$
\hat{p}_i = \frac{1}{1 + \exp\left[-\left(\beta_0 + \sum_{j=1}^{m}\beta_j x_{ij}\right)\right]}.
$$

На validation-выборке с естественной event rate обучено изотоническое
неубывающее отображение \(g\), поэтому итоговая вероятность равна
\(\tilde p_i = g(\hat p_i)\). Для независимого out-of-time test качество
вероятностного прогноза оценивается Brier score:

$$
\operatorname{BS} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \tilde{p}_i)^2.
$$

| Target | Brier: до калибровки | Brier: isotonic calibration | ROC-AUC после calibration |
|---|---:|---:|---:|
| Formal adverse, 6m | 0,021646 | 0,004320 | 0,8790 |
| Early deterioration, 6m | 0,059429 | 0,022507 | 0,7251 |

Результаты см. в **таблице 13.2** —
[«Калибровка логистических моделей»](../../reports/models/logistic_isotonic_calibration_v01_summary.csv).
Диаграммы надёжности: **рисунок 13.1** —
[formal adverse](../../reports/figures/models/formal_adverse_6m_calibration_v01.png),
**рисунок 13.2** —
[early deterioration](../../reports/figures/models/early_deterioration_6m_calibration_v01.png).

Изотоническая калибровка существенно улучшила Brier score. Небольшое снижение
PR-AUC после неё связано с тем, что монотонное отображение объединяет часть
исходных score в одинаковые калиброванные вероятности; ranking-модель следует
сравнивать по её исходным ROC-AUC и PR-AUC, а калиброванную версию — применять
для вероятностной коммуникации и будущего выбора порогов.
