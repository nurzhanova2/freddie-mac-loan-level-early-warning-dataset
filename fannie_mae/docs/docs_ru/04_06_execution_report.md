# Этапы 4–6: загрузка, очистка и monthly panel Fannie Mae

**Статус: выполнено 14 сентября 2026 года.** Результаты относятся только к
Fannie Mae Primary Dataset, acquisition cohort `2008Q1`.

## 4. Загрузка и первичная проверка

Загружен официальный архив Fannie Mae Data Dynamics
`2008Q1.zip`. Архив содержит единственный headerless файл `2008Q1.csv`,
сжатый размер которого составляет 377 024 698 байт, а размер после распаковки
— 6 060 016 939 байт. SHA-256 архива:

```text
6d9d3df9737fc321e70cc76bcbdf03a8bfe9ec190e472a1e1f2f9b9bd8460ae9
```

Файл содержит 22 415 219 строк по 113 полей. Период monthly reporting
охватывает январь 2008 — март 2026. Обнаружено 380 832 уникальных кредита.
Все строки имеют ожидаемые 113 полей и непустые `loan_identifier` и reporting
period. Точная проверка всех ключей `loan_identifier × monthly_reporting_period`
внешней сортировкой не выявила групп дубликатов или лишних повторов ключа.

Строки в raw-файле не упорядочены глобально по ключу. Это не является ошибкой,
но запрещает проверять уникальность только сравнением соседних строк; поэтому
была выполнена полная external-sort проверка.

Полный отчёт и manifest: [QA report](../../reports/2008Q1_raw_validation.json),
[data manifest](../../data/manifests/data_manifest.csv).

## 5. Очистка и стандартизация

Очистка выполнена streaming-процессом непосредственно из ZIP-архива, без
распаковки 6 GB CSV в `raw/`. Пустые значения и пробельные строки преобразованы
в `null`; ключевые даты формата `MMYYYY` преобразованы в даты; определённые
числовые поля преобразованы в числовой тип.

Во всех преобразованных полях дат и числовых полях не найдено невалидных
значений. Официальный **SF Glossary & File Layout (Excel)** импортирован;
позиции 1–113 получили точные имена и типы, а словарь сохранён в
[`fannie_2008q1_field_dictionary.csv`](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).
Позиция 114 глоссария отсутствует в raw-архиве `2008Q1`. Специальные коды
пока намеренно не рекодируются: их обработка будет задана только правилами
outcome и leakage register.

Очищенная таблица со всеми 113 позициями сохранена как
[`2008Q1_cleaned.parquet`](../../data/interim/2008Q1_cleaned.parquet).

## 6. Построение monthly panel

В текущем Fannie Mae формате acquisition-характеристики и ежемесячная
performance-динамика уже находятся в одном файле. Поэтому объединение двух
файлов не требуется: после проверки ключа исходный файл преобразован в monthly
panel уровня `loan_identifier × monthly_reporting_period`.

В базовую panel включены 35 полей: идентификатор, дата наблюдения, ключевые
origination-признаки, текущие balance/rate/loan-age характеристики, current
delinquency status, payment history и modification flag. Итоговый файл содержит
22 415 219 строк и 35 полей:

[`2008Q1_monthly_panel_base.parquet`](../../data/processed/2008Q1_monthly_panel_base.parquet).

Zero Balance Code и Zero Balance Effective Date сохранены отдельно в
[`2008Q1_event_metadata.parquet`](../../data/interim/2008Q1_event_metadata.parquet).
Они не включены в набор model features и будут использоваться только при
последующем формировании outcomes, termination rules и competing risks.

Следующий этап — фиксация leakage register и построение 3- и 6-месячных labels
без использования будущей информации.
