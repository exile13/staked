#!/bin/bash
cd $HOME/staked

checkRepo () {
    if [ -z $1 ]; then
      return
    fi
    prevdir=${PWD}
    if [[ ! -f komodo/$1/lastbuildcommit ]]; then
      eval cd "$HOME/staked/StakedModo"
      git pull > /dev/null 2>&1
      git checkout $1 > /dev/null 2>&1
      localrev=$(git rev-parse HEAD)
      mkdir -p $HOME/staked/komodo/$1
      echo $localrev > $HOME/staked/komodo/$1/lastbuildcommit
      cd $prevdir
    fi
    localrev=$(cat komodo/$1/lastbuildcommit)
    eval cd "$HOME/staked/StakedModo"
    git remote update > /dev/null 2>&1
    remoterev=$(git rev-parse origin/$1)
    cd $prevdir
    if [ $localrev != $remoterev ]; then
      return 1
    else
      return 0
    fi
}

buildkomodo () {
  if [ -z $1 ]; then
    return
  fi
  cd $HOME/staked/StakedModo
  git pull > /dev/null 2>&1
  git checkout $1  > /dev/null 2>&1
  git pull  > /dev/null 2>&1
  make clean > /dev/null 2>&1
  #make -j$(nproc) > /dev/null 2>&1
  ./zcutil/build.sh -j$(nproc)
  if [[ ! -f $HOME/staked/StakedModo/src/komodod ]]; then
    return 0
  fi
  if [[ ! -f $HOME/staked/StakedModo/src/komodo-cli ]]; then
    return 0
  fi
  localrev=$(git rev-parse HEAD)
  mkdir -p $HOME/staked/komodo/$1
  echo $localrev > $HOME/staked/komodo/$1/lastbuildcommit
  mv src/komodod $HOME/staked/komodo/$1
  mv src/komodo-cli $HOME/staked/komodo/$1
  return 1
}

if [ -z $1 ]; then
  exit
fi

branch=$(cat assetchains.json | jq -r --arg chain $1 '.[] | select (.ac_name == $chain) | .branch')
if [[ $branch = "null" ]]; then
  branch="master"
fi

checkRepo $branch
outcome=$(echo $?)

if [[ $outcome = 1 ]] || [[ ! -f $HOME/staked/komodo/$branch/komodod ]] || [[ ! -f $HOME/staked/komodo/$branch/komodo-cli ]]; then
  buildkomodo $branch
  outcome=$(echo $?)
  if [[ $outcome = 1 ]]; then
    echo "updated"
  else
    echo "update_failed"
  fi
fi
