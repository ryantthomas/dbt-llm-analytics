# 1. What is dbt?

dbt (data build tool) transforms raw data into clean, tested tables using just SQL.

You write `SELECT` statements. dbt turns them into tables and views in your database, in the right order, with tests.

## The flow

This project moves data through three layers:

```
seeds   ->   staging   ->   marts
(raw)        (cleaned)      (ready to analyze)
```

- **seeds** — raw CSV files loaded straight into the database. Here: real National Park Service biodiversity data (5,824 species, 23,296 observations across 4 parks).
- **staging** — one model per source. Light work only: rename columns, fix types, handle nulls, dedupe.
- **marts** — the useful tables. Business logic lives here: joins, aggregations, the numbers people actually ask for.

## Why bother?

Without dbt, transformation logic hides in scripts, notebooks, and BI tools. Nobody knows which query is right.

With dbt, every transformation is version-controlled SQL. It is tested. It is documented. It runs the same way every time.

That last part matters for the second half of this tutorial: once the data is clean and documented, an LLM can query it safely.

Next: [02-setup.md](02-setup.md)
