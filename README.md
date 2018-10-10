# staked
repo for using staked chains, for testing and production use

## Installing Staked
I suggest a clean ubuntu 16.04/debian 9 VM, but this is NOT required. Everything will be stored in the $HOME/staked folder. Keep in mind the folling install script will symlink `komodo-cli` to the master branch of StakedChain/komodo in `/usr/local/bin`, however this is fully backwards compatible with komodo-cli used with the official komodo. It also symlink's `asset-cli` which is used to issue commands to staked chains. Keep this in mind, if you are not using a clean testing VM/VPS.

```shell
cd ~
git clone https://github.com/StakedChain/staked.git
cd staked/install
./buildkomodo.sh
```


## Using Staked
To start a single chain we simply need to do `./start.sh <chain name>`

For example to use the TROLL chain: `./start.sh STAKEDTROLL`

Now if you did this, you will notice that it got very mad at you and didn't work printing something in RED.

This is because Crypto Conditions require us to start the komodo daemon with the -pubkey parameter. This is a bit of a chicken and egg problem as we need retreive the pubkey from a komodo daemon first. For now you will need another `komodo` installation somewhere else, or a known key. To get a new key the commands for `komdoo-cli` are as follows:

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

To do this we need to do the following command: `cp config_example.ini config.ini`

Open this in your fav text editor example: `nano config.ini`

Enter the 3 keys you got in the order you retreived them above. For example the first value `Radd` takes the output of `getnewaddress`.

Under [CHAT] you will also see `username` and `password` in the file. These are for the TROLLBOX, username is the name you wish to use. You can't know if someone else has used the name you choose until you try and use it, so put what you want and a password to protect that name. If you lose the password for the name you chose, you wont be able to use that name again. It is a bit like your private key to the TROLLBOX, which is why we store it in config.ini with your private key. Keep this file safe. You may want to take a backup of it, depending on what you will be using it for.

To learn how to use the TROLLBOX see `README.md` inside the TROLL sub folder of this repo.
