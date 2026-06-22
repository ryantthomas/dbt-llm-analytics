"""MCP server exposing the NPS analytics DuckDB database to Claude.

Three tools:
  - list_tables()           list the available tables
  - describe_table(name)    show a table's columns and a few sample rows
  - run_query(sql)          run a read-only SELECT and return the results

The DuckDB connection is opened read-only, and run_query rejects anything
that is not a single SELECT statement. That is the guardrail: Claude can
read the data, but it cannot change it.
"""

import pathlib
import duckdb
from mcp.server.fastmcp import FastMCP

DB_PATH = pathlib.Path(__file__).parent.parent / "dbt_project" / "analytics.duckdb"

mcp = FastMCP("nps-analytics")

# Only the mart tables are exposed by default — these are the clean,
# documented models meant for analysis.
MARTS = ["wildlife_by_park", "conservation_summary", "species_spotlight"]


def _connect():
    if not DB_PATH.exists():
        raise FileNotFoundError(
            f"Database not found at {DB_PATH}. "
            "Run `dbt build --profiles-dir .` from the dbt_project folder first."
        )
    return duckdb.connect(str(DB_PATH), read_only=True)


def _format_rows(columns, rows):
    if not rows:
        return "(no rows)"
    header = " | ".join(columns)
    sep = "-" * len(header)
    body = "\n".join(" | ".join(str(v) for v in row) for row in rows)
    return f"{header}\n{sep}\n{body}"


@mcp.tool()
def list_tables() -> str:
    """List the analytics tables available to query."""
    with _connect() as con:
        rows = con.execute(
            "select table_name from information_schema.tables "
            "where table_schema = 'main' order by table_name"
        ).fetchall()
    names = [r[0] for r in rows]
    marts = [n for n in names if n in MARTS]
    other = [n for n in names if n not in MARTS]
    out = "Analytics tables (start here):\n  " + "\n  ".join(marts)
    if other:
        out += "\n\nSupporting tables:\n  " + "\n  ".join(other)
    return out


@mcp.tool()
def describe_table(table_name: str) -> str:
    """Show the columns and 5 sample rows for a table."""
    with _connect() as con:
        schema = con.execute(f"describe {table_name}").fetchall()
        schema_txt = "\n".join(f"  {col[0]} ({col[1]})" for col in schema)
        sample = con.execute(f"select * from {table_name} limit 5")
        cols = [d[0] for d in sample.description]
        rows = sample.fetchall()
    return f"Columns of {table_name}:\n{schema_txt}\n\nSample rows:\n{_format_rows(cols, rows)}"


@mcp.tool()
def run_query(sql: str) -> str:
    """Run a read-only SELECT query and return the results.

    Only a single SELECT statement is allowed. Any attempt to modify
    the data (INSERT, UPDATE, DELETE, CREATE, DROP, etc.) is rejected.
    """
    cleaned = sql.strip().rstrip(";").strip()
    if not cleaned.lower().startswith("select"):
        return "Error: only SELECT queries are allowed."
    if ";" in cleaned:
        return "Error: only a single statement is allowed."
    with _connect() as con:
        result = con.execute(cleaned)
        cols = [d[0] for d in result.description]
        rows = result.fetchall()
    return _format_rows(cols, rows)


if __name__ == "__main__":
    mcp.run(transport="stdio")
