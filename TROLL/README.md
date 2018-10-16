# THIS IS OLD .. PLEASE AWAIT NEW INSTRUCTIONS FOR THE ORACLES BASED CHAT ROOM


# STKDTROLL
A decentralised chat that runs on the blockchain secured by dPoW to KMD and therefore secured by bitcoins hash rate. This is a specical type of blockchain developed just for this role, it uses a fork of komodo daemon to work that is NOT backwards compatible with any komodo assetchain or KMD itself. Dont worry though the `start.sh` script takes care of all this stuff for you. All you need to do is run `./start.sh STKDTROLL` from the directory above this one to start and sync the chain to start trolling people :P.


## Features of the STKDTROLL chain
The STKDTROLL chain is not in the STAKED cluster, its is not fungible with the other chains. The only way to get STKDTROLL coins is via the faucet crypto condition.

There is no mining block reward for STKDTROLL, and it is NOT compatible with stratum pools at least at this time. Someone is encouraged to create a pool that works with this chain if they so desire. However there is and never will be ANY Block reward to mine.

STKDTROLL is mined on demand blocks by all staked notary nodes. Once a transaction is seen in the mempool all notaries instantly compete to mine that transaction into a block. This gives STKDTROLL a very fast block time, of seconds. The difficulty is also static at a value of 1, so if lots of transactions are happening it will not slow down at all, and may even continute to create blocks at a faster and faster speed.  We honestly don't really know what will happen as no chain has ever used this mechanisim before, it is brand new and unique.


## Building the TROLLBOX
Now the fun part where hopefully you get to use your newly mined STKDTROLL coins to troll people. This is still a very basic system and will be able to be built on top of with GUI's etc in the future if it proves a viable solution to decentralised immutable chat. I always figure there will be people working in terminals testing STAKED chains, so why not build the first chat dApp in TMUX and BASH. This requires a little manual setup to get started but it is not hard. When you ran `buildkomodo.sh` everything you need was installed already.

In a terminal window *without* STKDTROLL chain running type : `tmux`

This will launch you into another terminal. To split the terminal into two panes:

`ctrl + b` then `shift + %`

To change between these town panes:

`ctrl + b` then press arrow key in the direction you want to move. here with just 2 panes we can go left and right only.

In the pane of your choice we will start the STKDTROLL chain, this is where everyones CHAT messages will be output to:
```shell
cd ..
./start.sh STKDTROLL
```
Then change to the other pane using the `ctrl + b arrow` you learn't above.

Now we need to wait for the TROLLBOX to load/blockchain to sync. This may or may not take a long time, depending on many factors.

You will see chat messages scroll by as the chain syncs. Each message has a timeout of 1 day, but due to on demand bocks, this is not accurate at all and is acutally 1440 blocks. They may expire much faster or much slower depending on how may people use the chain.


## Getting some STKDTROLL coins
STKDTROLL coins are kind of free, and kind of not. The only way to get them is to mine a special transaction called a faucetget. This is a special kind of transaction where the transaction ID begins and ends with `00`. The faucet was funded with 77,662,794,614 coins on chain createion. Effectivly making the supply unlimited.

To mine your faucet get transaction you need to run the `./getfunds` command in this (TROLL) folder. This will take a little time from a few seconds up to a minute or even more on a slow system. Once completed you will see a message in the chat box telling you how long your faucetget took to mine and how many iterations it took. It will take a few seconds after this to confirm and the balance to show in your wallet.


## Using the TROLLBOX

You can try to send a message now. To do so simply make sure you are in this (TROLL) folder and enter:

`./send your message here`

You cannot use any quotes, this is a current limiation by how the data is passed to the daemon. Maybe if we don't use bash here, any data can be used, I need to test it still. The above command will send `[yourusername] : your message here` to the chat box in the other pane. The time it takes to arrive can vary but in testing I have seen nothing over a 5-6s delay and is usally much faster. However if you were chating from a very bad location such as flying in a plane or Antarctica it would probably be much slower but so would any chat system :P.

Thats is it. Your now trolling people on the blockchain secured by bitcoins hash rate. Eat that Discord!
