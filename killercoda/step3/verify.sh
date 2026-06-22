#!/bin/bash
python3 -c "
import duckdb
con = duckdb.connect('/root/lab/dbt_project/analytics.duckdb', read_only=True)
tables = [r[0] for r in con.execute(\"SELECT table_name FROM duckdb_views() WHERE schema_name='main'\").fetchall()]
assert 'stg_species' in tables
assert 'stg_parks' in tables
" 2>/dev/null && exit 0 || exit 1
