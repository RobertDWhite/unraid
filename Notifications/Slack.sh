#!/bin/bash

# Send Unraid notifications to Discord
# Replace Slack.sh in /boot/config/plugins/dynamix/notifications/agents
# Set to your Discord webhook token.
# DO NOT append "/slack"
WEBHOOK="https://discord.com/api/webhooks/ID/URLTOKEN"

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