# bubble
cycles a ledger and then bubbles up a payment on threshold

# cycle
cycles through ledger payments with limited liquidty

# prerequisites

setup `basic` ledger

uses `cycle` workflow

# description

bubble is an extension of cycle where an inter ledger transaction is made after the threshold is reached

in a typcial scenario you have two actors, say, workbot and webid

workbot pays the webid periodically based on work performed

a post insert hook will check that the webid balance is not above a certain threshold, if it is, a transaction is made from webid to workbot for amount transaction

after the threshold is reached an inter ledger payment for the same amount is made

# implementation


    export SMALL="https://localhost/wallet/test/small#this"
    export MEDIUM="https://localhost/wallet/test/medium#this"
    THRESHOLD=25
    AMOUNT=5
    credit insert $WORKBOT $AMOUNT '' $WEBID work -d small -w $SMALL
    BALANCE=$(credit balance $WEBID -d small -d $SMALL)
    if [[ $BALANCE -gt $THRESHOLD ]]
    then
      credit insert $WORKBOT $THRESHOLD '' $WEBID -d small -w $SMALL
      credit insert $WEBID $THRESHOLD '' $WORKBOT -d medium -w $MEDIUM
    fi

The rebalancing doesnt need to run on an insert, it can run periodically or on demand

# example

You may wish to log your bash commands, with 5 bits awarded for each command.  Every 25 points accumulated, you send the bits back to the points issuer so that you can keep a record of your work

However you may also want a larger summary table that is not filled with lots of entries.  This larger table will give you less spammy summary data.  In this way we create a web of ledgers where liquidity naturally flows between high trusted actors.
