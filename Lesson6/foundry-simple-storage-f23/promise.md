## I promise to never use my private key associated with  real money in plain text.

`Format the code in foundry using terminal`
```
forge fmt
```
`Install foundry`
```
curl -L https://foundry.paradigm.xyz | bash
```
```
foundryup
```
`Check forge version`
```
forge --veresion
```
`Create new Foundry project`
```
forge init
```
`Deploying contract with foundry`
```
forge create SimpleStorage --rpc-url http://127.0.0.1:8545 --interactive
```
`Deploying contract using script written in solidty language`
```
forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```
`To load the variables in the .env file`
```
source .env
```
`Deploying contract using script written in solidty language using .env`
```
forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
```
`Convert hexadecimal value to decimal`
```
cast --to-base 0x01 dec
```
`Delete terminal history`
```
history -c
```
## Cast is used for interacting with contracts which have already been deployed.
`Writing (send)`
```
cast send 0xf8e81D47203A594245E36C48e151709F0C19fBe8 "store(uint256)" 999 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```
`Reading (call)`
```
cast call 0xf8e81D47203A594245E36C48e151709F0C19f
Be8 "retrive()"
```
`Alchemy Node as a service`
```
forge script script/DeploySimpleStorage.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $SEPOLIA_PRIVATE_KEY
```