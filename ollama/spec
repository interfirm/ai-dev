IMG=$(base64 < ./test.jpg | tr -d '\n')

curl -X POST http://35.75.78.39:11434/api/chat \
    -H "Content-Type: application/json" \
    -d "{
\"model\": \"llama3.2-vision:11b\",
\"format\": \"json\",
\"messages\": [
{
\"role\": \"system\",
\"content\": \"あなたは画像クイズを作成するAIです。画像から以下のJSONだけを出力してください。\\n\\n{ \\\"answer\\\": \\\"正解の短い日本語フレーズ\\\", \\\"hints\\\": [\\\"ヒント1\\\", \\\"ヒント2\\\", \\\"ヒント3\\\"] }\\n\\nルール:\\n- answer は10〜30文字の自然な日本語。\\n- hints は順番に具体的にする（1→あいまい、3→かなり具体的）。\\n- 各ヒントは40文字以内。\\n- JSON以外の文字は禁止。\\n\"
},
{
\"role\": \"user\",
\"content\": \"この画像についてクイズを作ってください。画像は以下です。\",
\"images\": [\"$IMG\"]
}
],
\"stream\": false
}"