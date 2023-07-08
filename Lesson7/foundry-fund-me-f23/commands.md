`To view logs in terminal`
```
forge test -vv
```

`To run a single test`
```
forge test --match-test <testFunctionName>
```

`Anvil`
```
forge test
```

`Sepolia RPC`
```
forge test --rpc-url $SEPOLIA_RPC_URL
```

`Ethereum Mainnet RPC`
```
forge test --rpc-url $MAINNET_RPC_URL 
```


`To see how many lines of our code is tested`
```
forge coverage --rpc-url $SEPOLIA_RPC_URL
```

`Chisel: To test small solidity codes like`
```
chisel
uint256 x = 3;
x
uint256 xPlus2 = x+2;
xPlus2
```
`To view how much gas a function costs <forge snapshot>`
```
forge snapshot --mt testWithdrawWithMultipleFunders
```
### Constant and immutable variables aren't stored in storage they're part of the contracts bytecode
`To view storage layout`
```
forge inspect FundMe storageLayout
```
`Another way to view storage`
```
forge script script/FundMeScript.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
```
`Copy the cotract address then run the following command:`
```
cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 <slot>
```
`slot 0 and 1 is empty because they're array and mapping`