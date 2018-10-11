#Install Deps
mkdir -p $HOME/staked/komodo/master
sudo apt-get update
sudo apt-get -y install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-openssl-dev bsdmainutils automake curl tmux htop slurm bc jq
#Install Komodo
cd $HOME/staked
git clone https://github.com/stakedchain/komodo.git StakedModo
cd StakedModo
./zcutil/fetch-params.sh
./zcutil/build.sh -j$(nproc)
localrev=$(git rev-parse HEAD)
echo $localrev > $HOME/staked/komodo/master/lastbuildcommit
mv src/komodod $HOME/staked/komodo/master
mv src/komodo-cli $HOME/staked/komodo/master
cd ~
mkdir .komodo
cd .komodo
touch komodo.conf
echo "rpcuser=user`head -c 32 /dev/urandom | base64`" > komodo.conf
echo "rpcpassword=password`head -c 32 /dev/urandom | base64`" >> komodo.conf
echo "daemon=1" >> komodo.conf
echo "server=1" >> komodo.conf
echo "txindex=1" >> komodo.conf
chmod 0600 komodo.conf
sudo ln -sf $HOME/staked/asset-cli /usr/local/bin/asset-cli
sudo ln -sf $HOME/staked/komodo/master/komodo-cli /usr/local/bin/staked-cli
