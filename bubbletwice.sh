#!/bin/bash

export WEBID="http://melvincarvalho.com/#me"
export WORKBOT="https://workbot.databox.me/profile/card#me"
export SMALL="https://localhost/wallet/small/wallet#this"
export MEDIUM="https://localhost/wallet/medium/wallet#this"
export LARGE="https://localhost/wallet/large/wallet#this"

THRESHOLD1=30
THRESHOLD1=300
AMOUNT=5

credit insert $WORKBOT $AMOUNT '' $WEBID work -d small -w $SMALL
BALANCE=$(credit balance $WEBID -d small -w $SMALL)
if [[ $BALANCE -ge $THRESHOLD1 ]]
then
  credit insert $WEBID $THRESHOLD1 '' $WORKBOT bubble -d small -w $SMALL
  credit insert $WORKBOT $THRESHOLD1 '' $WEBID cycle -d medium -w $MEDIUM

  BALANCE=$(credit balance $WEBID -d medium -w $MEDIUM)

  if [[ $BALANCE -ge $THRESHOLD2 ]]
  then
    credit insert $WEBID $THRESHOLD2 '' $WORKBOT bubble -d medium -w $MEDIUM
    credit insert $WORKBOT $THRESHOLD2 '' $WEBID cycle -d large -w $LARGE
  fi

fi
