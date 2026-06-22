#!/bin/bash
[ -f /root/lab/dbt_project/target/catalog.json ] && exit 0 || exit 1
