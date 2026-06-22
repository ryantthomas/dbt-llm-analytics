# Step 2: Seed the raw data

dbt seeds are CSV files that get loaded directly into the database. This project has four:
- `parks.csv` — 4 national parks with coordinates and area
- `species_info.csv` — 5,824 species
- `observations.csv` — 23,296 observation records
- `conservation_categories.csv` — 5 conservation status definitions

Load them:

```
cd /root/lab/dbt_project && dbt seed --profiles-dir .
```

You'll see four `OK` lines. A DuckDB file (`analytics.duckdb`) is created in this directory — that's your database. Everything from here runs against it.

Check what landed:

```
python3 -c "
import duckdb
con = duckdb.connect('analytics.duckdb', read_only=True)
for row in con.execute(\"SELECT table_name, estimated_size FROM duckdb_tables() WHERE schema_name = 'main'\").fetchall():
    print(row)
"
```

Click **Check** when the seed completes.
