# 2. Setup

You have two options. Codespaces is easiest — nothing to install.

## Option A: GitHub Codespaces (recommended)

1. On the repo page, click **Code > Codespaces > Create codespace**.
2. Wait for it to build. Dependencies install automatically.
3. You get a full VS Code in your browser. Done.

## Option B: Local

You need Python 3.11+.

```bash
pip install -r llm_query/requirements.txt
```

## Build the database

dbt reads its profile from the `dbt_project` folder, so run commands from there:

```bash
cd dbt_project
dbt seed --profiles-dir .
```

`dbt seed` loads the four CSV files into a local DuckDB database (`analytics.duckdb`). DuckDB runs inside the process — no server, no password.

You should see four seeds load, the largest being 23,296 observation rows.

Next: [03-staging-models.md](03-staging-models.md)
