#!/bin/bash

export WEBID="http://melvincarvalho.com/#me"
export WORKBOT="https://workbot.databox.me/profile/card#me"
export SMALL="https://localhost/wallet/test/small#this"
export MEDIUM="https://localhost/wallet/test/medium#this"
THRESHOLD=25
AMOUNT=5
credit insert $WORKBOT $AMOUNT '' $WEBID work -d small -w $SMALL
BALANCE=$(credit balance $WEBID -d small -w $SMALL)
if [[ $BALANCE -gt $THRESHOLD ]]
then
  credit insert $WORKBOT $THRESHOLD '' $WEBID -d small -w $SMALL
  credit insert $WEBID $THRESHOLD '' $WORKBOT -d medium -w $MEDIUM
fi
