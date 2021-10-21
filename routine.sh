#!/usr/bin/env bash

[ -d 'config' ] || {
    echo "没有找到配置文件, 请执行应用注册 Action."
    exit 1
}

poetry run python crypto.py d || exit 1

start=$(date +%s)
output="$(timeout 5m poetry run python task.py)"
end=$(date +%s)

echo "$output"
[ $((end - start)) -lt 44 ] && exit 1
echo "$output" | grep '调用成功' 1>/dev/null || exit 1
echo "$output" | grep -iE 'error|except' 1>/dev/null && exit 1

poetry run python crypto.py e || exit 1
