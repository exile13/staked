# staked
repo for using staked chains, for testing and production use

## Installing Staked
I suggest a clean ubuntu 16.04/debian 9 VM, but this is NOT required. Everything will be stored in the $HOME/staked folder.

```shell
cd ~
git clone https://github.com/KMDLabs/staked.git
cd staked/install
./buildkomodo.sh
```


## Using Staked
To start a single chain we simply need to do `./start.sh <chain name>`

For example to use the CFEKED chain: `./start.sh CFEKED`

Now if you did this, you will notice that it got very mad at you and didn't work printing something in RED.

This is because Crypto Conditions require us to start the komodo daemon with the -pubkey parameter. To get a new key the commands` are as follows:

```shell
komodo-cli getnewaddress
komodo-cli dumpprivkey <the address returned in the first command>
komodo-cli validateaddress <the address returned in the first command>
```

Validate address returns this:
```
{
  "isvalid": true,
  "address": "RBHAc9C5XDPr5fhDZSkrfMMSC6EK7uovVv",
  "scriptPubKey": "76a91415ef05d8569caf36e3a5aebabe353f92620c567888ac",
  "segid": 19,
  "ismine": true,
  "iswatchonly": false,
  "isscript": false,
  "pubkey": "036ffa3329dadf88d30ef0a9d3d6aa0a2f04804d9dcd95a14ba663e586f9c2cefc",
  "iscompressed": true,
  "account": ""
}
```
You need the pubkey value *without* quotes `"` or the `,` third from the bottom.

Now we need to take these values and input them to a config.ini file that staked uses to import the private key to each chain, and start the daemons with the correct -pubkey parameter.


### Using config.ini

To do this we need to do the following command: `cp config_example.ini config.ini`

Open this in your fav text editor example: `nano config.ini`

Enter the 3 keys you got in the order you retreived them above. For example the first value `Radd` takes the output of `getnewaddress`.

You can now start the chain you want with `./start.sh <chain>` (or all chains with `./startall.sh`), using the config.ini, it will import the wif for you and start the daemon with -pubkey set. However yo uno longer need to do this if you follow the instructions below.


### Starting a single chain or all chains without using config.ini

To not use config.ini we can just issue the following command to start all chains: `./startall.sh noconfig`

To start a single chain without config.ini: `./start.sh <chain> noconfig`

To set your -pubkey in runtime use `./asset-cli <chain> setpubkey <pubkey>`
