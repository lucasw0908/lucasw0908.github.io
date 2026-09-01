#!/usr/bin/env bash

files=$(git diff --name-only HEAD^ HEAD | grep -E 'p/**/.*\.html$' | sed 's|/index\.html$||')

if [ -z "$files" ]; then
    echo "No changes found"
    exit 0
fi

while IFS= read -r file; do
    curl -X POST \
    "$DISCORD_WEBHOOK?thread_id=$THREAD_ID" \
    -H "Content-Type: application/json" \
    -d '{
        "content": "",
        "username": "New Post Bot",
        "embeds": [
            {
            "title": "New Post",
            "color": 0x00ff00,
            "description": "A new post has been published!",
            "url": "$URL/$file"
            }
        ]
    }'
done <<< "$files"
