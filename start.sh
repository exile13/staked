#!/bin/bash
pubkey=$(./printkey.py pub)
Radd=$(./printkey.py Radd)
privkey=$(./printkey.py wif)

if [ -z $1 ]; then
  echo -e "\033[1;31m ABORTING!!! Please specify a chain name \033[0m"
  exit
fi

chain=$1

if [[ ${#pubkey} != 66 ]]; then
  echo -e "\033[1;31m ABORTING!!! pubkey invalid: Please check your config.ini \033[0m"
  exit
fi

if [[ ${#Radd} != 34 ]]; then
  echo -e "\033[1;31m [$1] ABORTING!!! R-address invalid: Please check your config.ini \033[0m"
  exit
fi

if [[ ${#privkey} != 52 ]]; then
  echo -e "\033[1;31m [$1] ABORTING!!! WIF-key invalid: Please check your config.ini \033[0m"
  exit
fi

ac_json=$(curl https://raw.githubusercontent.com/StakedChain/StakedNotary/master/assetchains.json 2>/dev/null)
echo $ac_json | jq .[] > /dev/null 2>&1
outcome=$(echo $?)
if [[ $outcome != 0 ]]; then
  echo -e "\033[1;31m ABORTING!!! assetchains.json is invalid, Help Human! \033[0m"
  exit
fi
echo $ac_json > assetchains.json

for row in $(echo "${ac_json}" | jq  -r '.[].ac_name'); do
  if [[ $row = $chain ]]; then
    chainexists=1
  fi
done

if [[ $chainexists != 1 ]]; then
  echo -e "\033[1;31m ABORTING!!! the specified chain does not exist in the staked network, Help Human! \033[0m"
  exit
fi

echo "[$chain] Checking for update and compiling if needed could take a while..."
result=$(./update_komodo.sh $chain)
if [[ $result = "updated" ]]; then
  echo "[$chain] Updated to latest"
  master_updated=1
  komodo-cli stop > /dev/null 2>&1
  daemon_stopped "komodod.*\-notary"
elif [[ $result = "update_failed" ]]; then
  echo "\033[1;31m [$chain] ABORTING!!! failed to update, Help Human! \033[0m"
  exit
else
  echo "[$chain] No update required"
fi

echo "Starting $chain and importing: $Radd ..."
./assetchains $chain &
./validateaddress $chain
