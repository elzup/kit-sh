#!/bin/bash

# スクリプトの使用方法を表示する関数
usage() {
  echo "Usage: $0 REMOTE_USER REMOTE_DIR ZIP_FILE_BASE"
  echo "  REMOTE_USER: SSH設定で指定されたユーザー名またはエイリアス"
  echo "  REMOTE_DIR:  リモートディレクトリのパス"
  echo "  ZIP_FILE_BASE: ZIPファイル名のベース部分（yyyymmddが自動的に追加されます）"
  exit 1
}

# 引数の数を確認
if [ "$#" -ne 3 ]; then
  usage
fi

# 引数を取得
REMOTE_USER=$1
REMOTE_DIR=$2
ZIP_FILE_BASE=$3
DATE=$(date +%Y%m%d)  # 現在の日付を取得
ZIP_FILE="${ZIP_FILE_BASE}_${DATE}.zip"
LOCAL_DEST="./" # ローカルの保存先ディレクトリ

# リモートで圧縮
echo "Compressing the remote directory..."
echo "Executing: ssh $REMOTE_USER \"zip -r ~/$ZIP_FILE $REMOTE_DIR\""
ssh "$REMOTE_USER" "zip -r ~/$ZIP_FILE $REMOTE_DIR"

# 圧縮ファイルをダウンロード
echo "Downloading the zip file..."
echo "Executing: scp $REMOTE_USER:~/$ZIP_FILE $LOCAL_DEST"
scp "$REMOTE_USER:~/$ZIP_FILE" "$LOCAL_DEST"

# リモートの圧縮ファイルを削除
echo "Cleaning up the remote zip file..."
echo "Executing: ssh $REMOTE_USER \"rm -f ~/$ZIP_FILE\""
ssh "$REMOTE_USER" "rm -f ~/$ZIP_FILE"

echo "Download completed. The zip file is saved to $LOCAL_DEST$ZIP_FILE"
