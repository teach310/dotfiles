.PHONY: help
#: ヘルプコマンド
help:
	@grep -A1 -E "^#:" Makefile \
	| grep -v -- -- \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| column -t  -s '###'

.PHONY: install
#: シンボリックリンク作る
install:
	ruby scripts/install.rb

.PHONY: dry-install
#: シンボリックリンク作る(dry-run)
dry-install:
	ruby scripts/install.rb --dry-run

.PHONY: build-oneshot
#: build-oneshot
build-oneshot:
	code --list-extensions > oneshot/vscode_list_extensions.txt

.PHONY: install-vscode-ext
#: vscodeの拡張機能をインストール
install-vscode-ext:
	for f in `cat oneshot/vscode_list_extensions.txt`; do code --install-extension $$f; done

.PHONY: install-oneshot
#: ghのaliasをインストール
install-oneshot:
	gh alias set prc "pr create -w"
