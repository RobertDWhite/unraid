#!/bin/bash

# Replace Slack.sh in /boot/config/plugins/dynamix/notifications/agents
# Set to your Discord webhook token.
# DO NOT append "/slack"
WEBHOOK="https://discord.com/api/webhooks/793189983640616973/khF6pAi9HEeM1E4ztZ0S-M13BNxGspGVLfN-PzyuHKEYBc_wA3u_S4n0SFP7hLsclv47"

curl "$WEBHOOK" \
-X "POST" \
-H 'Content-Type: application/json' \
--data @<(cat <<EOF
{
  "embeds": [
    {
      "title": "$EVENT",
      "description": "$SUBJECT",
      "footer": {
        "text": "$(date) on $(hostname)"
      },
      "thumbnail": {
        "url": "https://i.imgur.com/tlooVc1.png",
        "height": 16,
        "width": 16
      },
      "fields": [
        {
          "name": "Priority",
          "value": "${IMPORTANCE^}"
        },
        {
          "name": "Description",
          "value": "$DESCRIPTION\n\n$CONTENT"
        }
      ]
    }
  ]
}
EOF
)