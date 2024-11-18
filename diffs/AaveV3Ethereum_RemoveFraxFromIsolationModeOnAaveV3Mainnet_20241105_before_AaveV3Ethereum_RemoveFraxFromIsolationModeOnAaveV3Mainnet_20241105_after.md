## Reserve changes

### Reserves altered

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 10,000,000 $ [1000000000] | 0 $ [0] |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx |


## Raw diff

```json
{
  "reserves": {
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "debtCeiling": {
        "from": 1000000000,
        "to": 0
      }
    }
  }
}
```