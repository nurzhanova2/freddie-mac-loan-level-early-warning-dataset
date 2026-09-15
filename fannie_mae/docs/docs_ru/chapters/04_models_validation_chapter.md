# Глава 4. Моделирование и временная валидация раннего предупреждения

## 4.1. Сравниваемые модели

Базовой моделью станет логистическая регрессия. Нелинейным конкурентом будет XGBoost или LightGBM. Для времени до adverse event будет оценена Cox proportional hazards model; при ресурсной возможности — survival forest или survival gradient boosting. Лучшая модель не назначается до валидации.

## 4.2. Временное разделение

Выборка разделена только по времени: train охватывает январь 2006 — декабрь
2016 года, validation — январь 2017 — декабрь 2020 года, out-of-time test —
январь 2021 — сентябрь 2025 года. Последняя дата выбрана потому, что исходные
данные заканчиваются мартом 2026 года и для неё ещё доступно полное будущее
окно в шесть месяцев. Схема разделения приведена на **рисунке 4.1** —
[«Хронологическое разделение»](../../../reports/figures/splits/fannie_temporal_split_timeline_v01.png).

Объёмы, eligible наблюдения и частоты двух шестимесячных outcomes приведены в
**таблице 4.1** — [«Сводка temporal split»](../../../reports/splits/fannie_temporal_split_v01_summary.csv).
Preprocessing, feature selection, calibration и class balancing выполняются
исключительно на train-периоде. Идентификатор кредита используется лишь для
соединения и контроля, но никогда не является признаком модели. Один кредит
может появляться в нескольких временных частях панели; это допустимо для
динамического мониторинга, поскольку модель не получает его идентификатор и
не обучается на будущих месяцах.

## 4.3. Оценка

Будут рассчитаны ROC-AUC, PR-AUC, recall, precision, Brier score, calibration curve, calibration slope/intercept, lead time, false-positive rate и cost-sensitive показатели. Для survival-моделей планируются C-index и time-dependent AUC.

Для бинарного исхода $y_i \in \{0,1\}$ Brier score определяется как
$\operatorname{BS} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \hat{p}_i)^2$. Чем меньше
значение, тем точнее прогнозируемые вероятности. После обучения на
case-control train калибрующее отображение оценивается только на validation,
а окончательная проверка выполняется на out-of-time test.

## 4.4. Статус

Этап 12 выполнен для primary six-month evaluation frame. В train имеются
62 310 424 eligible наблюдения для formal adverse и 61 008 721 для early
deterioration; в out-of-time test — 65 970 573 и 65 331 004 соответственно.
Численные результаты качества моделей пока отсутствуют: они появятся только
после обучения на train и настройки на validation.

Первый логистический baseline уже построен как ranking-ориентированный
эксперимент. На out-of-time выборке ROC-AUC равен 0,8794 для formal adverse и
0,7254 для early deterioration. Сравнение PR-AUC, объёмов выборок и ограничение
некалиброванных вероятностей см. в **таблице 4.2** —
[«Логистический baseline v01»](../../../reports/models/logistic_baseline_v01_summary.csv).
Подробный журнал см. в [отчёте этапа 13](../13_initial_models_execution_report.md).
Для логистической модели isotonic calibration уменьшила out-of-time Brier
score с 0,021646 до 0,004320 для formal adverse и с 0,059429 до 0,022507 для
early deterioration; см. **таблицу 4.3** —
[«Сводка калибровки»](../../../reports/models/logistic_isotonic_calibration_v01_summary.csv)
и **рисунок 4.2** — [«Reliability formal adverse»](../../../reports/figures/models/formal_adverse_6m_calibration_v01.png).

Пороговая политика оценена на ведущем XGBoost. При capacity top 1% для formal
adverse precision равен 24,29%, recall — 50,09%; для early deterioration —
12,47% и 5,33%. Полная trade-off таблица приведена в **таблице 4.4** —
[«XGBoost alert policy»](../../../reports/models/formal_adverse_6m_xgboost_alert_policy_v01.csv)
и в [отчёте этапа 14](../14_threshold_policy_execution_report.md).
Для согласованных triggers lead time составляет в среднем 2,467 месяца до
formal adverse и 2,993 месяца до early deterioration; см. **таблицу 4.5** —
[lead time formal adverse](../../../reports/models/formal_adverse_6m_trigger_lead_time_v01.csv).
