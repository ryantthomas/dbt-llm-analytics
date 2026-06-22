#!/bin/bash
python3 -c "
import duckdb
con = duckdb.connect('/root/lab/dbt_project/analytics.duckdb', read_only=True)
tables = [r[0] for r in con.execute(\"SELECT table_name FROM duckdb_tables() WHERE schema_name='main'\").fetchall()]
assert 'wildlife_by_park' in tables
assert 'conservation_summary' in tables
assert 'species_spotlight' in tables
" 2>/dev/null && exit 0 || exit 1
