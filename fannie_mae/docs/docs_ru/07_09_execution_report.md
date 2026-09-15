# Этапы 7–9: глоссарий, leakage register и outcomes Fannie Mae

**Статус: выполнено для версии fannie_v01.** Результаты относятся к Fannie Mae
Primary Dataset, cohort 2008Q1, и не переносятся автоматически на Freddie Mac.

## 7. Импорт официального глоссария

Импортирован файл SF Glossary & File Layout (Excel). Raw-архив имеет 113 полей;
в глоссарии есть 114 позиций. Позиции 1–113 однозначно сопоставлены с архивом,
а позиция 114, Origination VantageScore 4.0, отсутствует в данном формате
поставки. Рабочий словарь содержит 113 записей:
[fannie_2008q1_field_dictionary.csv](../../data/dictionaries/fannie_2008q1_field_dictionary.csv).

## 8. Реестр допустимости признаков

Создан [leakage register](../../data/dictionaries/fannie_2008q1_leakage_register_v01.csv)
для всех 113 полей. В версии v01 38 полей отмечены как candidate features,
идентификаторы используются только для ключей, 30 termination/post-event полей
отнесены к label-only или exclude, а workout/resolution поля исключены из
первой модели. Zero Balance Code и Zero Balance Effective Date не являются
features.

## 9. Построение 3- и 6-месячных labels

Formal adverse event v01 — появление в будущем окне статуса просрочки 03–98,
то есть порога 90+ DPD. Early deterioration v01 — для кредита со статусом 00
на дату t появление статуса 01–98, то есть 30+ DPD, в будущем окне. Коды XX и
99 не интерпретируются как события.

Если до конца горизонта произошло termination, будущий статус неизвестен или
не хватает полного числа ежемесячных наблюдений, запись цензурируется при
отсутствии уже наблюдаемого события. Zero Balance Code не приравнивается к
дефолту. Полный набор labels:
[2008Q1_outcomes_v01.parquet](../../data/processed/2008Q1_outcomes_v01.parquet).

| Outcome | Labelled observations | Events | Event rate |
|---|---:|---:|---:|
| Formal adverse, 3 months | 20,007,896 | 264,892 | 1.3239% |
| Formal adverse, 6 months | 18,986,874 | 503,395 | 2.6513% |
| Early deterioration, 3 months | 19,152,309 | 758,624 | 3.9610% |
| Early deterioration, 6 months | 18,168,886 | 1,277,828 | 7.0331% |

Техническая проверка подтвердила совпадение 22,415,219 строк с monthly panel,
допустимые значения labels 0/1/null и отсутствие нарушений вложенности:
событие в 3-месячном окне также является событием в 6-месячном окне.

Определения outcomes имеют статус v01: они воспроизводимы и подходят для
первого моделирования, но могут быть уточнены только через новую
версионированную спецификацию, а не задним числом.
