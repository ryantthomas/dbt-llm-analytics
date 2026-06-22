#!/bin/bash
# Wait for background setup if still running
timeout 120 bash -c 'until [ -f /tmp/lab-ready ]; do sleep 2; done'
[ -d /root/lab/dbt_project ] && exit 0 || exit 1
