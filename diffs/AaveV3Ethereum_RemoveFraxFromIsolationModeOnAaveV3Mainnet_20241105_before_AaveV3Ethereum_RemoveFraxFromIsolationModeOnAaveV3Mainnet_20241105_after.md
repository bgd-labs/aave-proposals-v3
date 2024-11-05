## Reserve changes

### Reserves altered

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 15,000,000 FRAX | 10,000,000 FRAX |
| borrowCap | 12,000,000 FRAX | 10,000,000 FRAX |
| debtCeiling | 10,000,000 $ [1000000000] | 0 $ [0] |
| liquidationThreshold | 72 % [7200] | 75 % [7500] |
| liquidationProtocolFee | 10 % [1000] | 20 % [2000] |
| reserveFactor | 20 % [2000] | 10 % [1000] |


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
      "borrowCap": {
        "from": 12000000,
        "to": 10000000
      },
      "debtCeiling": {
        "from": 1000000000,
        "to": 0
      },
      "liquidationProtocolFee": {
        "from": 1000,
        "to": 2000
      },
      "liquidationThreshold": {
        "from": 7200,
        "to": 7500
      },
      "reserveFactor": {
        "from": 2000,
        "to": 1000
      },
      "supplyCap": {
        "from": 15000000,
        "to": 10000000
      }
    }
  }
}
```