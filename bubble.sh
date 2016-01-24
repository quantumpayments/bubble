#!/bin/bash

export WEBID="http://melvincarvalho.com/#me"
export WORKBOT="https://workbot.databox.me/profile/card#me"
export SMALL="https://localhost/wallet/small/wallet#this"
export MEDIUM="https://localhost/wallet/medium/wallet#this"
THRESHOLD=25
AMOUNT=5
credit insert $WORKBOT $AMOUNT '' $WEBID work -d small -w $SMALL
BALANCE=$(credit balance $WEBID -d small -w $SMALL)
if [[ $BALANCE -gt $THRESHOLD ]]
then
  credit insert $WEBID $THRESHOLD '' $WORKBOT bubble -d small -w $SMALL
  credit insert $WORKBOT $THRESHOLD '' $WEBID cycle -d medium -w $MEDIUM
fi
