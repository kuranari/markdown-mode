#!/bin/zsh

# 監視するファイルのパス
FILES=("tests/markdown-test.el" "markdown-mode.el")


# ファイル変更を監視し、変更があった場合に `make test` を実行
fswatch -o "${FILES[@]}" | while read num; do
    make test SELECTOR='"test-markdown-movement/beginning-of-line"'
    # make test SELECTOR='"test-markdown-movement/end-of-line"'

    # 直前の終了ステータスに基づいて通知を表示
    if [ $? -eq 0 ]; then
        MESSAGE="make test succeeded"
    else
        MESSAGE="make test failed"
    fi

    # 通知を表示
    osascript -e "display notification \"$MESSAGE\" with title \"Test Notification\""
done
