# 6. LLM analytics

Now the fun part. You ask questions in plain English. Claude writes the SQL, runs it, and answers.

This works through an **MCP server** — a small Python program that gives Claude three tools for talking to your database.

## The three tools

`llm_query/mcp_server.py` exposes:

- `list_tables()` — what tables exist
- `describe_table(name)` — a table's columns and a few sample rows
- `run_query(sql)` — run a SELECT and return the results

Claude calls these on its own. It lists the tables, describes the ones it needs, then writes a query. No prompt engineering from you.

## The guardrail

`run_query` only allows a single `SELECT`. Anything else — `DELETE`, `DROP`, a second statement after a semicolon — is rejected. The database connection is opened read-only on top of that. Claude can read everything and change nothing.

This is the whole point of building on dbt. The data is clean, tested, and documented, and the access is locked to read-only. That is what makes it safe to hand an LLM a database.

## Connect it

**Claude Code:** open this repo as a folder. The `.claude/settings.json` file wires up the MCP server automatically. Start asking questions.

**Claude Desktop:** copy the snippet from `llm_query/claude_desktop_config.example.json` into your Claude Desktop config, replacing the path with where this repo lives on your machine. Restart Claude Desktop.

## Ask things

Try these:

- Which park has the most endangered species sightings?
- What are the five most-observed animals across all parks?
- How many threatened mammals are there, and where do they live?
- Compare bird observation counts across all four parks.
- Which species are in recovery?

Claude figures out the SQL from the schema and the column descriptions you wrote in chapter 5. That is the payoff: clean data plus good docs plus a safe, read-only door equals analytics anyone can run by typing a sentence.

That's the tutorial. You built a tested dbt project on real data and gave it a natural-language interface.
