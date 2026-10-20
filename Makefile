.PHONY: new lint

new:
	@test -n "$(TITLE)" || (echo 'usage: make new TITLE="記事タイトル"' && exit 1)
	bash scripts/new_draft.sh "$(TITLE)"

lint:
	@files=$$(ls draft_entries/*.md 2>/dev/null); \
	if [ -n "$$files" ]; then npx textlint $$files; else echo "No drafts."; fi
