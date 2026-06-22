# Step 3: Build staging models

Staging models clean the raw seed data. They run as views — no data is copied, just a transformation layer on top of the seeds.

```
cd /root/lab/dbt_project && dbt run --select staging --profiles-dir .
```

Four views are created: `stg_species`, `stg_observations`, `stg_parks`, `stg_conservation_categories`.

Open `models/staging/stg_species.sql` and find the `is_at_risk` column:

```
grep -A2 "is_at_risk" /root/lab/dbt_project/models/staging/stg_species.sql
```

This derives a boolean from `conservation_status`. That derived column flows into the mart models downstream — dbt's `{{ ref() }}` function wires them together automatically.

Check how many species survived deduplication:

```
python3 -c "
import duckdb
con = duckdb.connect('/root/lab/dbt_project/analytics.duckdb', read_only=True)
print(con.execute('SELECT COUNT(*) FROM stg_species').fetchone()[0], 'unique species')
"
```

Click **Check** when the run completes.
