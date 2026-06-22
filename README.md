# dbt + LLM Analytics

Learn dbt on real data, then give it a natural-language interface with Claude.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/ryantthomas/dbt-llm-analytics)

This is a hands-on tutorial. You build a tested dbt project on real National Park Service biodiversity data (5,824 species, 23,296 observations across 4 national parks), then connect it to Claude so you can ask questions in plain English and get real answers back.

## What you'll build

A clean data pipeline:

```
seeds (raw CSVs)  ->  staging (cleaned)  ->  marts (ready to analyze)
```

Then an MCP server that lets Claude query it safely:

> **You:** Which park has the most endangered species sightings?
>
> **Claude:** *(lists the tables, reads the schema, writes the SQL, runs it)* Yellowstone, with the highest at-risk observation counts of the four parks...

Claude can read everything and change nothing — queries are locked to read-only `SELECT`s.

## Quickstart

### Codespaces (nothing to install)

Click the badge above. Wait for the environment to build, then:

```bash
cd dbt_project
dbt build --profiles-dir .
```

### Local

Requires Python 3.11+.

```bash
pip install -r llm_query/requirements.txt
cd dbt_project
dbt build --profiles-dir .
```

Then open the repo in **Claude Code** (the MCP server connects automatically via `.claude/settings.json`) or wire it into **Claude Desktop** using `llm_query/claude_desktop_config.example.json`.

## The tutorial

Work through these in order:

1. [What is dbt?](tutorial/01-what-is-dbt.md)
2. [Setup](tutorial/02-setup.md)
3. [Staging models](tutorial/03-staging-models.md)
4. [Mart models](tutorial/04-mart-models.md)
5. [Testing and documentation](tutorial/05-testing-and-docs.md)
6. [LLM analytics](tutorial/06-llm-analytics.md)

## How it fits together

| Piece | What it does |
|---|---|
| `dbt_project/seeds/` | Raw NPS biodiversity CSVs |
| `dbt_project/models/staging/` | One cleaned view per source |
| `dbt_project/models/marts/` | Three analysis tables with tests + column docs |
| `llm_query/mcp_server.py` | MCP server: `list_tables`, `describe_table`, `run_query` (SELECT-only) |
| `.claude/settings.json` | Auto-connects the MCP server in Claude Code |

The database is DuckDB — it runs in-process, so there's no server to start and no credentials to manage.

## Watch the walkthrough

YouTube video: _coming soon_

## Support

If this tutorial helped you, you can [buy me a coffee](https://ko-fi.com/) — _(link coming soon)_. Completely optional. The tutorial is free and always will be.

## Data source

[National Park Service biodiversity dataset](https://www.kaggle.com/datasets/nationalparkservice/park-biodiversity), covering Bryce, Great Smoky Mountains, Yellowstone, and Yosemite.
