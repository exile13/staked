# STAKEDTROLL
A decentralised chat that runs on the blockchain secured by dPoW to KMD and therefore secured by bitcoins hash rate. This is a specical type of blockchain developed just for this role, it uses a fork of komodo daemon to work that is NOT backwards compatible with any komodo assetchain or KMD itself. Dont worry though the `start.sh` script takes care of all this stuff for you. All you need to do is run `./start.sh STAKEDTROLL` from the directory above this one to start and sync the chain to start trolling people :P.


## Features of the STAKEDTROLL chain
The STAKEDTROLL chain is not in the STAKED cluster, its is not fungible with the other chains. The only way to get STAKEDTROLL coins is via the faucet crypto condition.

There is no mining block reward for STAKEDTROLL, and it is NOT compatible with stratum pools at least at this time. Someone is encouraged to create a pool that works with this chain if they so desire. However there is and never will be ANY Block reward to mine.

STAKEDTROLL is mined on demand blocks by all staked notary nodes. Once a transaction is seen in the mempool all notaries instantly compete to mine that transaction into a block. This gives STAKEDTROLL a very fast block time, of seconds. The difficulty is also static at a value of 1, so if lots of transactions are happening it will not slow down at all, and may even continute to create blocks at a faster and faster speed.  We honestly don't really know what will happen as no chain has ever used this mechanisim before, it is brand new and unique.


## Getting some STAKEDTROLL coins
STAKEDTROLL coins are kind of free, and kind of not. The only way to get them is to mine a special transaction called a faucetget. This is a special kind of transaction where the transaction ID begins and ends with `00`. These transactions are only avalible to new addresses with no previous transactions on them, however you can claim 3 faucetgets of 100 coins each in a row with a new address.  Meaning each new address can get 300 coins, bear in mind that 100 coins is enough STAKEDTROLL to send 100,000 chat messages. The faucet was funded with 1,000,000,000 coins on chain createion. Effectivly making the supply unlimited.

To mine your faucet get transaction you need to have the chain running with a valid address/pubkey/wif in your config.ini and run the ./`getfunds` command in this folder. Remeber this address must be empty to claim your STAKEDTROLL a used address will not work no matter how many times you try it.


## Using the TROLLBOX
Now the fun part where hopefully you get to use your newly mined STAKEDTROLL coins to troll people. This is still a very basic system and will be able to be built on top of with GUI's etc in the future if it proves a viable solution to decentralised immutable chat. I always figure there will be people working in terminals testing STAKED chains, so why not build the first chat dApp in TMUX and BASH. This requires a little manual setup to get started but it is not hard. When you ran `buildkomodo.sh` everything you need was installed already.

In a terminal window *without* STAKEDTROLL chain running type : `tmux`

This will launch you into another terminal. To split the terminal into two panes:

`ctrl + b` then `shift + %`

To change between these town panes:

`ctrl + b` then press arrow key in the direction you want to move. here with just 2 panes we can go left and right only.

In the pane of your choice we will start the STAKEDTROLL chain, this is where everyones CHAT messages will be output to:
```shell
cd ..
./start.sh STAKEDTROLL
```
Then change to the other pane using the `ctrl + b arrow` you learn't above.

Now we need to wait for the TROLLBOX to load/blockchain to sync. This may or may not take a long time, depending on many factors.

You will see chat messages scroll by as the chain syncs. Each message has a timeout of 1 day, but due to on demand bocks, this is not accurate at all and is acutally 1440 blocks. They may expire much faster or much slower depending on how may people use the chain.

You can try to send a message at any time during sync or when sync is finshed. However is the chain is not synced, your message will not dispay until the chain is synced. To do so simply make sure you are in this (TROLL) folder and enter:

`./send your message here`

There is no need for quotes or anything, the above command will send `[yourusername] : your message here` to the chat box in the other pane. The time it takes to arrive can vary but in testing I have seen nothing over a 5-6s delay and is usally much faster. However if you were chating from a very bad location such as flying in a plane or Antarctica it would probably be much slower but so would any chat system :P. 

Thats is it. Your now trolling people on the blockchain secured by bitcoins hash rate. Eat that Discord!
