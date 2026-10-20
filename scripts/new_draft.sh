#!/bin/bash
# Create a draft on Hatena Blog via the "create draft" workflow and check out its pull request.
set -euo pipefail

title="${1:?usage: scripts/new_draft.sh <title>}"

gh workflow run create-draft.yaml --ref main -f title="$title"
sleep 5
run_id=$(gh run list --workflow create-draft.yaml --limit 1 --json databaseId --jq '.[0].databaseId')
gh run watch "$run_id" --exit-status

pr=$(gh pr list --state open --json number,title --jq "map(select(.title == \"$title\")) | .[0].number")
gh pr checkout "$pr"
echo "Checked out PR #$pr: $(gh pr view "$pr" --json url --jq .url)"
