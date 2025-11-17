#!/bin/bash

set -e

# Check if test.jpg exists
if [[ ! -f "test.jpg" ]]; then
    echo "Error: test.jpg not found in current directory"
    exit 1
fi

# Ollama endpoint (default: remote server, override with OLLAMA_HOST env var)
OLLAMA_HOST="${OLLAMA_HOST:-35.75.78.39:11434}"
echo "Using Ollama host: $OLLAMA_HOST"

# 1. 画像をbase64化
echo "Encoding image to base64..."
IMG=$(base64 < ./test.jpg | tr -d '\n')

# 2. Ollamaの /api/chat に投げる（画像クイズ生成）
echo "Sending request to Ollama vision API for quiz generation..."
curl -X POST http://$OLLAMA_HOST/api/chat \
    -H "Content-Type: application/json" \
    -d "{
\"model\": \"llama3.2-vision:11b\",
\"format\": \"json\",
\"messages\": [
{
\"role\": \"system\",
\"content\": \"あなたは画像クイズを作成するAIです。画像から以下のJSONだけを出力してください。\\n\\n{ \\\"answer\\\": \\\"正解の短い日本語名\\\", \\\"hints\\\": [\\\"ヒント1\\\", \\\"ヒント2\\\", \\\"ヒント3\\\"] }\\n\\nルール:\\n- answer は10〜30文字の自然な日本語。\\n- hints は順番に具体的にする（1→あいまい、3→かなり具体的）。\\n- 各ヒントは40文字以内。\\n- JSON以外の文字は禁止。\\n- ヒントは日本語名を含まないこと。\\n\"
},
{
\"role\": \"user\",
\"content\": \"この画像についてクイズを作ってください。画像は以下です。\",
\"images\": [\"$IMG\"]
}
],
\"stream\": false
}"

echo -e "\n\nDone!"
