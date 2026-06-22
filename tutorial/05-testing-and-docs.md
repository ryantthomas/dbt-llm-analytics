# 5. Testing and documentation

Clean data is not enough. You have to prove it is clean, and describe what it means. This chapter is what makes the data safe for an LLM to use.

## Tests

dbt tests are assertions about your data. They live in the `_staging.yml` and `_marts.yml` files next to the models.

Two kinds are used here:

- **not_null** — this column must never be empty.
- **unique** — no duplicate values in this column.

For example, `scientific_name` in `stg_species` is tested for `unique`. This is exactly the test that caught the duplicate-species problem from chapter 3 — before the dedupe, it failed with 283 duplicates. After the dedupe, it passes.

Run the tests:

```bash
dbt test --profiles-dir .
```

All 18 tests should pass. If one fails, dbt tells you which model and how many bad rows.

## Documentation

Open `_marts.yml`. Every column has a one-line `description`. This is not decoration.

```yaml
- name: total_observations
  description: "Total species observations recorded across all categories in this park."
```

These descriptions get baked into the database catalog when you run:

```bash
dbt docs generate --profiles-dir .
```

That produces `target/catalog.json` — a full map of every table and column.

## Why this matters next

In the final chapter, Claude queries this database. It does not guess what the columns mean. It reads the schema and the descriptions, then writes correct SQL. Good documentation is what makes natural-language analytics actually work.

## One command for all of it

`dbt build` runs seed, run, and test together, in order:

```bash
dbt build --profiles-dir .
```

Next: [06-llm-analytics.md](06-llm-analytics.md)
