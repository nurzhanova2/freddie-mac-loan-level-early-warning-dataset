# Этап 14. Калибровка и политика порогов

**Статус: выполнено.** Ведущей моделью выбрана XGBoost v01, поскольку на
out-of-time test она превосходит логистический baseline по ROC-AUC и PR-AUC для
обеих целей. Изотоническая калибровка оценивается исключительно на validation,
а проверяется на out-of-time test.

Для XGBoost Brier score после калибровки равен 0,004065 для formal adverse и
0,022468 для early deterioration. Диаграммы надёжности: **рисунок 14.1** —
[formal adverse](../../reports/figures/models/formal_adverse_6m_xgboost_calibration_v01.png),
**рисунок 14.2** — [early deterioration](../../reports/figures/models/early_deterioration_6m_xgboost_calibration_v01.png).

Следующий подэтап — выбрать пороги не произвольно, а по заданной capacity
alerts (например, верхние 1%, 5% и 10% прогнозов), после чего рассчитать
precision, recall и число ложных тревог на out-of-time test.

## Capacity-based policy

Пусть \(TP\), \(FP\) и \(FN\) обозначают соответственно истинные тревоги,
ложные тревоги и пропущенные события. Для фиксированной capacity используются
метрики $\operatorname{Precision}=TP/(TP+FP)$ и
$\operatorname{Recall}=TP/(TP+FN)$. Порог определяется не произвольно: в
alert направляются ровно верхние 1%, 5% или 10% score независимой out-of-time
выборки. При одинаковых score используется детерминированный порядок ключей.

| Target | Capacity | Precision | Recall | False alerts per true positive |
|---|---:|---:|---:|---:|
| Formal adverse | Top 1% | 24,29% | 50,09% | 3,12 |
| Formal adverse | Top 5% | 6,18% | 63,75% | 15,17 |
| Formal adverse | Top 10% | 3,41% | 70,39% | 28,30 |
| Early deterioration | Top 1% | 12,47% | 5,33% | 7,02 |
| Early deterioration | Top 5% | 8,69% | 18,59% | 10,51 |
| Early deterioration | Top 10% | 7,30% | 31,20% | 12,71 |

Подробные результаты — **таблица 14.1**:
[formal adverse policy](../../reports/models/formal_adverse_6m_xgboost_alert_policy_v01.csv)
и [early deterioration policy](../../reports/models/early_deterioration_6m_xgboost_alert_policy_v01.csv).
Графики trade-off: **рисунок 14.3** —
[formal adverse](../../reports/figures/models/formal_adverse_6m_xgboost_alert_policy_v01.png),
**рисунок 14.4** — [early deterioration](../../reports/figures/models/early_deterioration_6m_xgboost_alert_policy_v01.png).

Для formal adverse top-1% policy является сильным кандидатом: она захватывает
половину будущих 90+ DPD событий при 24,29% precision. Для early deterioration
ни один из этих порогов пока не является окончательной operational policy:
30+ DPD шире по смыслу, и требуется отдельно определить допустимую нагрузку
на команду и стоимость пропущенного сигнала. Все значения относятся к
loan-month alert observations, а не к числу уникальных заёмщиков.

## Последовательность формирования риск-сигнала

Политика v01 переводит model score в объяснимый рабочий сигнал:

`данные → score → deterioration detection → explanation → risk trigger → human supervisory decision`.

Для formal adverse выбран red trigger top 1%; для early deterioration — amber
monitoring trigger top 5%. Эти уровни являются исследовательской policy и не
означают автоматического действия в отношении кредита или заёмщика. Полная
конфигурация, включая запрещённые применения, приведена в
[fannie_suptech_trigger_policy_v01.yml](../../config/fannie_suptech_trigger_policy_v01.yml).

## Lead time

Для утверждённых triggers рассчитано время от alert до первого наблюдаемого
события в последующие шесть месяцев. Red trigger formal adverse top 1% даёт
1 599 захваченных событий, средний lead time 2,467 месяца и медиану 2 месяца.
Amber trigger early deterioration top 5% даёт 2 833 захваченных события,
средний lead time 2,993 месяца и медиану 3 месяца. Детали приведены в
**таблице 14.2** — [formal adverse lead time](../../reports/models/formal_adverse_6m_trigger_lead_time_v01.csv)
и [early deterioration lead time](../../reports/models/early_deterioration_6m_trigger_lead_time_v01.csv).

Следовательно, этап 14 закрыт: ведущая модель выбрана, вероятности
откалиброваны, пороговые policies и ожидаемое время предупреждения определены.
