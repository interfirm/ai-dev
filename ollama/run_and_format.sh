#!/bin/bash
# クイズ生成を実行してJSON部分だけを整形表示

echo "=== 画像クイズ生成中... ==="
echo ""

# スクリプト実行して全出力を取得
FULL_OUTPUT=$(./test_ollama_vision.sh 2>&1)

# JSONレスポンス全体を抽出してcontentを取り出す（モデル名に依存しない形式）
QUIZ_JSON=$(echo "$FULL_OUTPUT" | grep -o '{"model":"[^"]*".*}' | jq -r '.message.content')

echo "=== 生成されたクイズ ==="
echo "$QUIZ_JSON" | jq .

echo ""
echo "=== 整形表示 ==="
echo "【正解】"
echo "$QUIZ_JSON" | jq -r '.answer'
echo ""
echo "【ヒント】"
echo "$QUIZ_JSON" | jq -r '.hints[]' | nl
