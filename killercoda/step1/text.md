# Step 1: Explore the project

The repo is cloned at `/root/lab`. Let's see what we're working with.

```
ls /root/lab
```

You'll see three main folders:
- `dbt_project/` — the dbt project: seeds, models, tests, docs
- `llm_query/` — the MCP server that connects Claude to the database
- `tutorial/` — written chapters if you want to read deeper

Look at the dbt project structure:

```
ls /root/lab/dbt_project/models/
```

Two folders: `staging/` and `marts/`. This is the standard dbt pattern — staging cleans raw data, marts answer business questions.

Look at one staging model:

```
cat /root/lab/dbt_project/models/staging/stg_species.sql
```

Notice the `GROUP BY scientific_name` — the raw NPS data has duplicate species rows with different spellings of common names. The staging model deduplicates them. That's a real data quality problem this pipeline solves.

Click **Check** when you've run all three commands.
