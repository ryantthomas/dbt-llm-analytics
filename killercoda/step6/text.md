# Step 6: Connect Claude

The MCP server gives Claude three tools for talking to your database:

- `list_tables()` — what tables exist
- `describe_table(name)` — columns and sample rows
- `run_query(sql)` — run a SELECT, get results back

Test that it loads correctly:

```
python3 -c "from llm_query.mcp_server import mcp; print('MCP server ready:', mcp.name)" 2>/dev/null || python3 -c "
import sys; sys.path.insert(0, '/root/lab')
from llm_query.mcp_server import mcp
print('MCP server ready:', mcp.name)
"
```

Test the SELECT-only guardrail:

```
python3 -c "
import sys; sys.path.insert(0, '/root/lab')
from llm_query.mcp_server import run_query
print(run_query('DELETE FROM wildlife_by_park'))
print(run_query('SELECT park_name FROM wildlife_by_park LIMIT 2'))
"
```

The DELETE is rejected. The SELECT runs.

**To use it with Claude:**

Open this repo in **Claude Code** — the `.claude/settings.json` file wires the MCP server automatically. Then ask:

> Which park has the most endangered species sightings?

Claude lists tables, reads the schema, writes the SQL, runs it, and answers. You built the pipeline that makes that possible.

Click **Check** to finish the lab.
