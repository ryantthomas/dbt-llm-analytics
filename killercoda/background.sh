#!/bin/bash
set -e
apt-get update -qq
apt-get install -y -qq python3-pip git
pip3 install -q dbt-duckdb "mcp[cli]" duckdb
git clone https://github.com/ryantthomas/dbt-llm-analytics /root/lab
echo "ready" > /tmp/lab-ready
