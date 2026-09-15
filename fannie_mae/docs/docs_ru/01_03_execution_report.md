# Этапы 1–3: Fannie Mae Primary Dataset

**Статус: выполнено для первой итерации `fannie_v01`.** Freddie Mac сохранён
отдельно в каталоге `freddie_mac/`; его файлы, документация и результаты не
изменялись.

## 1. Дизайн датасета

Основным источником первой реализации выбран Fannie Mae Single-Family Loan
Performance **Primary Dataset**, acquisition cohort `2008Q1`. Объектом анализа
является отдельный ипотечный кредит Fannie Mae, а единицей наблюдения —
`loan_identifier × monthly_reporting_period`.

Выбранный Primary Dataset содержит disclosed subset conventional,
fully-amortizing, full-documentation, fixed-rate single-family mortgages сроком
не более 30 лет. HARP dataset, multifamily loans и Freddie Mac не включаются в
эту выборку. Прогнозные горизонты определены как 3 и 6 месяцев. Метки событий
ещё не формировались; их definitions будут утверждены после фиксации
outcome/censoring register и фактического периода покрытия файла.

Точное машинно-читаемое решение сохранено в
[`study_scope_fannie_v01.yml`](../../config/study_scope_fannie_v01.yml).

## 2. Документация и структура полей

Архив `2008Q1.zip` содержит один headerless CSV-файл `2008Q1.csv` с 113
pipe-delimited полями. По фактическим строкам и официальному Fannie Mae layout
идентифицированы ключевые позиции: `loan_identifier` — 2,
`monthly_reporting_period` — 3, original FICO — 24, original DTI — 23,
original LTV/CLTV — 20/21, current delinquency status — 40, modification flag
— 42, Zero Balance Code — 44 и его effective date — 45.

Актуальный файл **SF Glossary & File Layout (Excel)** импортирован из
`docs/sources/`. Все 113 позиций raw-архива получили официальные имена, типы и
описания в [`fannie_2008q1_field_dictionary.csv`](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).
Глоссарий содержит также позицию 114, которой нет в данном 113-колоночном
архиве; это различие версий формата. Наличие имени поля не означает его
допустимость как model feature: проверка leakage проводится отдельно.

## 3. Хранение и воспроизводимость

Репозиторий разделён на два изолированных контура:

```text
freddie_mac/   # прежняя независимая реализация Freddie Mac
fannie_mae/    # активная реализация Fannie Mae
```

Внутри `fannie_mae/` используются `data/raw/`, `data/interim/`,
`data/processed/`, `data/manifests/`, `docs/`, `reports/`, `src/` и `tests/`.
Raw ZIP является неизменяемым. Скрипт валидации создаёт manifest с размером,
SHA-256, именем члена архива и числом строк. Исходные файлы исключены из Git.

## Следующий шаг

Полный data dictionary сформирован. Далее создаются outcome/censoring register
и leakage register, после чего будут построены 3- и 6-месячные labels.
