#!/usr/bin/env bash

# model: gpt-4 is in private beta

function hey_gpt() {
  prompt="$1"
  source ~/.config/openai/key
  gpt="$( \
    curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_KEY" \
    -d "{ \
        \"model\": \"gpt-3.5-turbo\", \
        \"messages\": [{\"role\": \"user\", \"content\": \"$prompt\"}], \
        \"temperature\": 0.7 \
    }" \
  )"
  echo "$gpt" | jq -r '.choices[0].message.content'
}

function data_gpt() {
  prompt="$1:\n\n$(sed -e 's/"/\\"/g' "$2" | tr '\n' ' ')"
  source ~/.config/openai/key
  gpt="$( \
    curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_KEY" \
    -d "{ \
        \"model\": \"gpt-3.5-turbo\", \
        \"messages\": [{\"role\": \"user\", \"content\": \"$prompt\"}], \
        \"temperature\": 0.7 \
    }" \
  )"
  echo "$gpt" | jq -r '.choices[0].message.content'
}
