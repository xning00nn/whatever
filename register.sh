#!/usr/bin/env bash

cd register

start=$(date +%s)
output="$(timeout 5m bash register_apps_by_force.sh)"
end=$(date +%s)

echo "$output"
[ $((end - start)) -lt 90 ] && exit 1
echo "$output" | grep '注册成功' 1>/dev/null || exit 1
echo "$output" | grep -iE 'error|except' 1>/dev/null && exit 1

cd ..
poetry run python crypto.py e || exit 1
