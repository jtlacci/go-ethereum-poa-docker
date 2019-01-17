#!/bin/sh

#Grab geth account[0]
ACCOUNT="$(geth --datadir="usr/local/bin/build/master" account list | awk '$2=="#0:" {print $3}' | tr -d "{}")" 


#Start up local geth 
echo Firing up engines
geth --datadir="usr/local/bin/build/master" init usr/local/bin/genesisBlock.json
geth --datadir="usr/local/bin/build/master" --etherbase "0x$ACCOUNT" --port 30302 --ipcdisable  --ws --wsport 8545 --wsorigins "*" --rpcport 8101 --mine --syncmode "full"  --networkid 1370 --unlock "0x$ACCOUNT" --password usr/local/bin/passkey.txt console

