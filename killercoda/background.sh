#!/bin/bash
apt-get update -qq
apt-get install -y -qq python3-pip git > /dev/null 2>&1
pip3 install -q dbt-duckdb "mcp[cli]" duckdb
git clone -q https://github.com/ryantthomas/dbt-llm-analytics /root/lab
echo "ready" > /tmp/lab-ready
