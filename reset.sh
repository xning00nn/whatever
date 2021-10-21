#!/usr/bin/env bash

git=git
command -v git.exe 1>/dev/null && git=git.exe

$git config user.name "github-actions[bot]"
$git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

$git checkout --orphan latest_branch
$git rm -rf --cached .
$git add -A
$git commit -m "$1"
$git branch -D master
$git branch -m master
$git push -f origin master
