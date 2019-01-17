#!/bin/sh

#Grab geth account[0]
ACCOUNT="$(geth --datadir="usr/local/bin/build/master" account list | awk '$2=="#0:" {print $3}' | tr -d "{}")" 


#Start up local geth 
echo Firing up engines
geth --datadir="usr/local/bin/build/master" init usr/local/bin/genesisBlock.json
geth --datadir="usr/local/bin/build/master" --etherbase "0x$ACCOUNT" --port 30302 --ipcdisable  --ws --wsport 8546 --wsorigins "*" --rpcport 8101 --mine --syncmode "full"  --networkid 1370 --unlock "0x$ACCOUNT" --password usr/local/bin/passkey.txt --bootnodes "enode://b6f4ac632599a0257c88e9422e64cbed76b4abac4428c792e38443e843487ac2f07faf2826b556b5a765a4ed988c529748e40f8284aae3dbd8586140c3e7a3d8@127.0.0.1:30301" console

