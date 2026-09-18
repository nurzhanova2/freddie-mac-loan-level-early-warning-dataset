# Разделы диссертации — Fannie Mae, русский язык

Здесь находятся материалы, относящиеся только к Fannie Mae Primary Dataset.
Они не применяются к реализации Freddie Mac.

## Текст диссертации

- [Аннотация и официальная тема](chapters/00_annotation.md)
- [Глава 1. Концепция и дизайн исследования](chapters/01_research_design_chapter.md)
- [Глава 2. Формирование и подготовка набора данных Fannie Mae](chapters/02_fannie_mae_data_preparation_chapter.md) — текст, который можно использовать как основу главы диссертации.
- [Глава 3. Целевые переменные, признаки и контроль утечки](chapters/03_outcomes_features_leakage_chapter.md)
- [Глава 4. Моделирование и временная валидация](chapters/04_models_validation_chapter.md)
- [Глава 5. Интерпретируемость и model governance](chapters/05_explainability_governance_chapter.md)
- [Глава 6. Результаты, обсуждение и выводы](chapters/06_results_discussion_chapter.md)

## Диссертационные приложения

- [Приложение А. Методологический аудит данных и моделей](appendices/appendix_a_methodological_audit.md)
- [Перечень таблиц и рисунков](appendices/list_of_tables_and_figures.md)

## Технические приложения

- [Этапы 1–3](01_03_execution_report.md) — журнал проектирования и структуры данных.
- [Этапы 4–6](04_06_execution_report.md) — воспроизводимый журнал загрузки, контроля качества и построения панели.
- [Этапы 7–9](07_09_execution_report.md) — импорт глоссария, leakage register и построение labels.
- [Этап 10](10_cohort_extension_execution_report.md) — расширение выборки по acquisition cohorts.
- [Этап 11](11_exploratory_data_analysis_report.md) — первичный анализ данных, таблицы, графики и решения для признаков.
- [Этап 12](12_temporal_split_execution_report.md) — хронологическое train/validation/out-of-time разделение.
- [Этап 13](13_initial_models_execution_report.md) — первые логистические baseline-модели.
- [Этап 14](14_threshold_policy_execution_report.md) — калибровка ведущей модели и политика порогов.
- [Этап 15](15_explainability_execution_report.md) — SHAP-аудит и устойчивость объяснений.
- [Этап 16](16_final_results_execution_report.md) — итоговые результаты и выводы.
- [Этап 17](17_q3_archive_audit_execution_report.md) — аудит исходных архивов Q3-когорт для проверки устойчивости к кварталу выдачи.
- [Этап 18](18_q3_panel_and_outcome_construction_execution_report.md) — построение панелей и исходов Q3-когорт.
- [Этап 19](19_q1_q3_comparative_analysis_execution_report.md) — сравнительный анализ Q1/Q3-когорт.
- [Этап 23](23_q3_explainability_governance_execution_report.md) — Q1/Q3 SHAP-аудит и governance.

Технические отчёты подтверждают результаты главы, но не заменяют её.
