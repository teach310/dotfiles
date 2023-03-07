# teach's dotfiles
Mac用設定ファイル、ツール群  
リポジトリ名はdotfilesだがdotfileじゃないものも入る。

## Reqiremnt

- peco
- Ruby (3.1.1で確認)

## Install

cdrコマンド有効化のためのフォルダを用意 TODO: installにいれちゃう

```
mkdir -p $HOME/.cache/shell/
```

```
ruby scripts/install.rb
```

You can confirm what files will link by

```
ruby scripts/install.rb --dry-run
```

## Contents

- zsh
- vscode
 - settings
 - extentions

## Directory
- home -> $HOME
- other -> locations.tsv

## oneshot
files that don't link.

## Unlink

manual.

```
# confirm link
$ ls -l ~/.zshrc

# unlink
$ unlink ~/.zshrc
```

## 育て方
https://qiita.com/reireias/items/b33b5c824a56dc89e1f7
