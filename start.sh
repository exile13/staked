#!/bin/bash

daemon_stopped () {
  while [[ -f $HOME/.komodo/$1/komodod.pid ]]; do
    sleep 2
  done
}

if [ -z $1 ]; then
  echo -e "\033[1;31m ABORTING!!! Please specify a chain name \033[0m"
  exit
fi

if [ -z $2 ] || [[ $2 = "config" ]]; then
  config=1
  pubkey=$(./printkey.py pub)
  Radd=$(./printkey.py Radd)
  privkey=$(./printkey.py wif)
elif [[ $2 == "noconfig" ]]; then
  config=0
fi

if [ -z $3 ] || [[ $3 = "fetchac" ]]; then
  fetchac=1
elif [[ $3 == "skipfetchac" ]]; then
  fetchac=0
fi

chain=$1

if [[ ${#pubkey} != 66 ]] && [[ $config == 1 ]]; then
  echo -e "\033[1;31m ABORTING!!! pubkey invalid: Please check your config.ini \033[0m"
  exit
fi

if [[ ${#Radd} != 34 ]] && [[ $config == 1 ]]; then
  echo -e "\033[1;31m [$1] ABORTING!!! R-address invalid: Please check your config.ini \033[0m"
  exit
fi

if [[ ${#privkey} != 52 ]] && [[ $config == 1 ]]; then
  echo -e "\033[1;31m [$1] ABORTING!!! WIF-key invalid: Please check your config.ini \033[0m"
  exit
fi

if [[ $fetchac == 1 ]]; then
  ac_json=$(curl https://raw.githubusercontent.com/KMDLabs/StakedNotary/master/assetchains.json 2>/dev/null)
  echo $ac_json | jq .[] > /dev/null 2>&1
  outcome=$(echo $?)
  if [[ $outcome != 0 ]]; then
    echo -e "\033[1;31m ABORTING!!! assetchains.json is invalid, Help Human! \033[0m"
    exit
  fi
  echo $ac_json > assetchains.json
elif [[ $fetchac == 0 ]]; then
  ac_json=$(cat assetchains.json)
fi

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
  staked-cli -ac_name=$chain stop > /dev/null 2>&1
  daemon_stopped "$chain"
elif [[ $result = "update_failed" ]]; then
  echo -e "\033[1;31m [$chain] ABORTING!!! failed to update, Help Human! \033[0m"
  exit
else
  echo "[$chain] No update required"
fi

if [[ $config == 1 ]]; then
  echo "Starting $chain and importing: $Radd ..."
  ./assetchains $chain "config" &
  ./validateaddress.sh $chain &
elif [[ $config == 0 ]]; then
  ./assetchains $chain "noconfig" &
fi
