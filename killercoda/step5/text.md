# Step 5: Test the data

dbt tests are assertions about your data. Run them:

```
cd /root/lab/dbt_project && dbt test --profiles-dir .
```

All 18 should pass. Two kinds are used here:

- **not_null** — required columns must never be empty
- **unique** — no duplicate values (e.g., one row per park in `wildlife_by_park`)

These tests caught a real problem during development: the raw NPS data had 283 duplicate scientific names. The staging model's `GROUP BY scientific_name` was added specifically to fix that. Without it, `unique_stg_species_scientific_name` would fail with 283 errors.

Now generate the schema documentation:

```
dbt docs generate --profiles-dir .
```

This writes `target/catalog.json` — a map of every table and column with their descriptions. In the next step, Claude reads this to understand your schema before writing SQL.

Click **Check** when all 18 tests pass.
