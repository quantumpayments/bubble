#!/bin/bash

export WEBID="http://melvincarvalho.com/#me"

export WORKBOT="https://workbot.databox.me/profile/card#me"
export SMALL="https://localhost/wallet/small/wallet#this"
export MEDIUM="https://localhost/wallet/medium/wallet#this"
export SMALL="https://localhost/wallet/gitpay/wallet#this"

export WEBID_SOURCE="$1"
export WEBID_TARGET="$2"


BALANCE=$(credit balance $WEBID_SOURCE -d gitpay -w $3)
if [[ $BALANCE -ge 0 ]]
  then
  credit insert $WEBID_SOURCE $BALANCE '' $WORKBOT transfer -d gitpay -w $3
  credit insert $WORKBOT $BALANCE '' $WEBID_TARGET transfer -d $4 -w $5
fi
