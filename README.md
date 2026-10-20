# daily-blog

[hellooooooo.hatenablog.com](https://hellooooooo.hatenablog.com/) の記事を GitHub で管理するリポジトリ。
はてな公式の [Hatena-Blog-Workflows-Boilerplate](https://github.com/hatena/Hatena-Blog-Workflows-Boilerplate) から作成し、
同期処理は [hatena/hatenablog-workflows](https://github.com/hatena/hatenablog-workflows) の Reusable workflows が行う。

## 記事を書いて公開する

1. `make new TITLE="記事タイトル"` を実行する
   - `create draft` ワークフローがはてなブログに下書きを作り、`draft_entries/<記事ID>.md` を含む Draft PR を作る
   - 完了するとその PR のブランチが checkout される
2. `draft_entries/<記事ID>.md` に本文を書いて push する
   - push のたびにはてなブログの下書きが更新される。見た目は PR 本文のプレビュー URL で確認する
   - PR では textlint が変更した下書きをチェックする。手元では `make lint`（初回のみ `npm ci`）
3. frontmatter の `Draft: true` 行を消し、PR を Ready for review にして main にマージする
   - 記事が公開され、ファイルは `entries/` に移る

はてなブログの編集画面で書き始めた下書きは、Actions の `pull draft from hatenablog` にタイトルを入れて実行すると PR になる。

## 公開済みの記事を直す

- `entries/` 以下を直した PR を main にマージすると反映される
- はてなブログの画面で直接編集したときは、Actions の `pull from hatenablog` を実行してできた PR をマージし、リポジトリ側に取り込む

## 注意

- 予約投稿はこのリポジトリからはできない。はてなブログの編集画面で設定する。設定後にこのリポジトリ経由で記事を変更すると予約が解除される
- 下書き PR のテンプレートは `.github/PULL_REQUEST_TEMPLATE/draft.md`

## 設定

| 項目 | 場所 |
| --- | --- |
| ブログのドメインとオーナー | `blogsync.yaml` |
| `BLOG_DOMAIN`（`hellooooooo.hatenablog.com`） | Settings > Secrets and variables > Actions > Variables |
| `OWNER_API_KEY`（はてなの [アカウント設定](https://blog.hatena.ne.jp/-/config) の API キー） | Settings > Secrets and variables > Actions > Secrets |

ワークフローが失敗し始めたら、まず `OWNER_API_KEY` が有効かを確認する。

## 更新

- Reusable workflows の参照と textlint は Dependabot が更新 PR を出す
- Boilerplate に新しいワークフローが追加されたときは `bash scripts/download_boilerplate_workflows.sh` で取り込む
- `make new` には github.com にログインした `gh` が必要（`gh auth login --hostname github.com`）
