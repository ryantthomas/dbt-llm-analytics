#!/bin/bash
python3 -c "
import sys; sys.path.insert(0, '/root/lab')
from llm_query.mcp_server import run_query
result = run_query('SELECT COUNT(*) FROM wildlife_by_park')
assert 'Error' not in result
" 2>/dev/null && exit 0 || exit 1
