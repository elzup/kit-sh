
# cron_check_status 関数を定義
# 引数1: CRON_LINE - 確認する cron ジョブの内容
# 引数2: CRON_ID - ジョブを一意に識別する ID
# 返り値: "none" (変更不要), "insert" (新規追加), "update" (更新必要)
cron_check_status() {
    local CRON_LINE="$1"
    local CRON_ID="$2"
    local TMP_FILE=$(mktemp)

    crontab -l > "$TMP_FILE"
    local EXISTING_JOB=$(grep "# $CRON_ID" "$TMP_FILE" || true)

    if [[ -z "$EXISTING_JOB" ]]; then
        # ジョブが存在しない場合
        rm "$TMP_FILE"
        echo "insert"
    else
        if [[ "$EXISTING_JOB" == *"$CRON_LINE"* ]]; then
            # 既存のジョブが更新される必要がない場合
            rm "$TMP_FILE"
            echo "none"
        else
            # 既存のジョブが更新される必要がある場合
            rm "$TMP_FILE"
            echo "update"
        fi
    fi
}

cron_upsert() {
    local CRON_LINE="$1"
    local CRON_ID="$2"
    local STATUS=$(cron_check_status "$CRON_LINE" "$CRON_ID")

    if [[ "$STATUS" == "insert" ]]; then
        # ジョブが存在しない場合は追加
        (crontab -l 2>/dev/null; echo "$CRON_LINE  # $CRON_ID") | crontab -
        echo "Cron job added."
    elif [[ "$STATUS" == "update" ]]; then
        # ジョブが更新が必要な場合は更新
        local TMP_FILE=$(mktemp)
        crontab -l > "$TMP_FILE"
        grep -v "# $CRON_ID" "$TMP_FILE" > "$TMP_FILE.tmp" && mv "$TMP_FILE.tmp" "$TMP_FILE"
        echo "$CRON_LINE  # $CRON_ID" >> "$TMP_FILE"
        crontab "$TMP_FILE"
        rm "$TMP_FILE"
        echo "Cron job updated."
    else
        # 更新の必要がない場合
        echo "No update needed."
    fi
}

