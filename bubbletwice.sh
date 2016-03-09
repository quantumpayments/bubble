#!/bin/bash

export WEBID="http://melvincarvalho.com/#me"
export WORKBOT="https://workbot.databox.me/profile/card#me"
export SMALL="https://localhost/wallet/small/wallet#this"
export MEDIUM="https://localhost/wallet/medium/wallet#this"
export LARGE="https://localhost/wallet/large/wallet#this"

THRESHOLD1=30
THRESHOLD2=300
AMOUNT=5

DIR=$(dirname $0)
SOUND1="$DIR/assets/sounds/beep.wav"
SOUND2="$DIR/assets/sounds/positive.wav"
SOUND3="$DIR/assets/sounds/positivebeep.wav"

credit insert $WORKBOT $AMOUNT '' $WEBID work -d small -w $SMALL
BALANCE=$(credit balance $WEBID -d small -w $SMALL)

2>/dev/null aplay $SOUND1 &


if [[ $BALANCE -ge $THRESHOLD1 ]]
then
  credit insert $WEBID $THRESHOLD1 '' $WORKBOT bubble -d small -w $SMALL
  if [[ $? == 0 ]]
    then
    credit insert $WORKBOT $THRESHOLD1 '' $WEBID cycle -d medium -w $MEDIUM
  fi

  BALANCE=$(credit balance $WEBID -d medium -w $MEDIUM)
  2>/dev/null aplay $SOUND2 &

  if [[ $BALANCE -ge $THRESHOLD2 ]]
  then
    credit insert $WEBID $THRESHOLD2 '' $WORKBOT bubble -d medium -w $MEDIUM
    if [[ $? == 0 ]]
      then
      credit insert $WORKBOT $THRESHOLD2 '' $WEBID cycle -d large -w $LARGE
      ssh -i ~/s/1404.pem ubuntu@klaranet.com "credit insert $WORKBOT $THRESHOLD2 '' $WEBID cycle -d large -w $LARGE"
    fi

    2>/dev/null aplay $SOUND3 &


  fi

fi
