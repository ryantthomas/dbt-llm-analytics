# Step 1: Explore the project

First, wait for the environment to finish setting up. Run this and wait for "Ready!":

```
until [ -f /tmp/lab-ready ]; do echo "Setting up..."; sleep 3; done && echo "Ready!"
```

Once it's ready, look at the repo:

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

Click **Check** when you've run the wait command and seen the project structure.
