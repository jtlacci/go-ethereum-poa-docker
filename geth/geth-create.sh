#!/bin/sh

echo Creating Accounts
'test' > passkey.txt
MASTER="$(geth --datadir usr/local/bin/build/master account new --password passkey.txt | sed 's/^[^{]*{\([^{}]*\)}.*/\1/')"

#Add masteraccount as Block Seeler (default local IP) and seeds with eth
echo '{"config": {
	"chainId": 15,
	"homesteadBlock": 1,
  "eip150Block": 2,
  "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "eip155Block": 3,
  "eip158Block": 3,
  "byzantiumBlock": 4,
  "clique": {
    "period": 4,
    "epoch": 30000
  }
  },
  "nonce": "0x0",
  "timestamp": "0x5c213a83",
  "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000'$MASTER'0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "gasLimit": "0x47b760",
  "difficulty": "0x1",
  "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0x0000000000000000000000000000000000000000",
	"alloc": {
    "0x'$MASTER'": {"balance": "0x1337000000000000000000"}
  }}' >> usr/local/bin/genesisBlock.json
