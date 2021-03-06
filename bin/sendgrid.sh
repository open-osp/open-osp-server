#!/bin/bash

source $HOME/.env

EMAIL_TO="$1"
FROM_EMAIL="root@aws.openosp.ca"
FROM_NAME="Open OSP"
SUBJECT="$2"

read rawHTML

bodyHTML="${rawHTML//$'\n'/<br />}"

echo $bodyHTML

maildata='{"personalizations": [{"to": [{"email": "'${EMAIL_TO}'"}]}],"from": {"email": "'${FROM_EMAIL}'", 
	"name": "'${FROM_NAME}'"},"subject": "'${SUBJECT}'","content": [{"type": "text/html", "value": "'${bodyHTML}'"}]}'

#curl --request POST \
#  --url https://api.sendgrid.com/v3/mail/send \
#  --header 'Authorization: Bearer '$SENDGRID_API_KEY \
#  --header 'Content-Type: application/json' \
#  --data "'$maildata'"

echo $bodyHTML
curl --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header "Authorization: Bearer ${SENDGRID_API_KEY}" \
  --header 'Content-Type: application/json' \
  --data "{\"personalizations\": [{\"to\": [{\"email\": \"clark@countable.ca\"}]}],\"from\": {\"email\": \"root@openosp.ca\"},\"subject\": \"disk usage high on $HOSTNAME\",\"content\": [{\"type\": \"text/plain\", \"value\": \"${bodyHTML}\"}]}" 
