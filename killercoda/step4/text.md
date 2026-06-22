# Step 4: Build mart models

Marts are materialized as real tables — data is stored, not recomputed on every query. Each mart answers one business question.

```
cd /root/lab/dbt_project && dbt run --select marts --profiles-dir .
```

Three tables are created. Query the most important one:

```
python3 -c "
import duckdb
con = duckdb.connect('/root/lab/dbt_project/analytics.duckdb', read_only=True)
rows = con.execute('SELECT park_name, total_observations FROM wildlife_by_park ORDER BY total_observations DESC').fetchall()
for r in rows:
    print(f'{r[0]:<45} {r[1]:>12,}')
"
```

Real numbers from real data. Yellowstone has over 1.4 million recorded observations.

Now look at conservation status:

```
python3 -c "
import duckdb
con = duckdb.connect('/root/lab/dbt_project/analytics.duckdb', read_only=True)
rows = con.execute('SELECT conservation_status, species_count FROM conservation_summary ORDER BY species_count').fetchall()
for r in rows:
    print(f'{r[0]:<25} {r[1]} species')
"
```

Click **Check** when both queries run.
