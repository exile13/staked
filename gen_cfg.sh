!#/bin/bash
Radd=$(komodo-cli getnewaddress)
pubkey=$(komodo-cli validateaddress $Radd | jq -r '.pubkey')
privkey=$(komodo-cli dumpprivkey $Radd)

configtemplate="example_config.ini"
cat "$configtemplate" | sed "s/btcpubkey =/btcpubkey = ${pubkey}/" | sed "s/wifkey = /wifkey = ${privkey}/"  | sed "s/Radd  =/Radd  = ${Radd}/" > config.ini
echo "New address generated"
echo "R-address: $Radd"
echo "WIF: $privkey"
echo "Pubkey: $pubkey"
