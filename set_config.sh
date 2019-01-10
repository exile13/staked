#!/bin/bash
Radd=$(komodo-cli getnewaddress)
pubkey=$(komodo-cli validateaddress $Radd | jq -r '.pubkey')
privkey=$(komodo-cli dumpprivkey $Radd)

configtemplate="config_example.ini"
cat "$configtemplate" | sed "s/ = pubkey/ = ${pubkey}/" | sed "s/ = wifkey/ = ${privkey}/"  | sed "s/ = Raddres/ = ${Radd}/" > config.ini
echo "New address generated"
echo "R-address: ${Radd}"
echo "WIF: ${privkey}"
echo "Pubkey: ${pubkey}"



