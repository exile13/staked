#!/bin/bash
cd $HOME/staked

if [ -z $1 ] || [[ $1 = "config" ]]; then
  config=1
elif [[ $1 == "noconfig" ]]; then
  config=0
fi

ac_json=$(curl https://raw.githubusercontent.com/KMDLabs/StakedNotary/master/assetchains.json 2>/dev/null)
echo $ac_json | jq .[] > /dev/null 2>&1
outcome=$(echo $?)
if [[ $outcome != 0 ]]; then
  echo -e "\033[1;31m ABORTING!!! assetchains.json is invalid, Help Human! \033[0m"
  exit
fi
echo $ac_json > assetchains.json

./listassetchains.py | while read chain; do
  if [[ $config == 1 ]]; then
    ./start.sh "$chain" "config" "skipfetchac"
  elif [[ $config == 0 ]]; then
    ./start.sh "$chain" "noconfig" "skipfetchac"
  fi
done
