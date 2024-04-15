## Reserve changes

### Reserves added

#### weETH ([0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee](https://etherscan.io/address/0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 8,000 weETH |
| borrowCap | 800 weETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3](https://etherscan.io/address/0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3) |
| oracleDecimals | 8 |
| oracleDescription | Capped weETH / eETH(ETH) / USD |
| oracleLatestAnswer | 3393.88566254 |
| usageAsCollateralEnabled | true |
| ltv | 72.5 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0xBdfa7b7893081B35Fb54027489e2Bc7A38275129](https://etherscan.io/address/0xBdfa7b7893081B35Fb54027489e2Bc7A38275129) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x77ad9BF13a52517AD698D65913e8D381300c8Bf3](https://etherscan.io/address/0x77ad9BF13a52517AD698D65913e8D381300c8Bf3) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0xBad6eF8e76E26F39e985474aD0974FDcabF85d37](https://etherscan.io/address/0xBad6eF8e76E26F39e985474aD0974FDcabF85d37) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xd56eE97960b1b2953e751151Fd84888cF3F3b521](https://etherscan.io/address/0xd56eE97960b1b2953e751151Fd84888cF3F3b521) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Ethereum weETH |
| aTokenSymbol | aEthweETH |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt weETH |
| stableDebtTokenSymbol | stableDebtEthweETH |
| variableDebtTokenName | Aave Ethereum Variable Debt weETH |
| variableDebtTokenSymbol | variableDebtEthweETH |
| optimalUsageRatio | 45 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 55 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 7 % |
| stableRateSlope1 | 0 % |
| stableRateSlope2 | 0 % |
| interestRate | ![ir](/.assets/975331647bbe35dbd37070cd8e0f29f3fd3250c9.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 93 % |
| eMode.liquidationThreshold | 95 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
      "from": null,
      "to": {
        "aToken": "0xBdfa7b7893081B35Fb54027489e2Bc7A38275129",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum weETH",
        "aTokenSymbol": "aEthweETH",
        "borrowCap": 800,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 1,
        "interestRateStrategy": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7250,
        "oracle": "0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3",
        "oracleDecimals": 8,
        "oracleDescription": "Capped weETH / eETH(ETH) / USD",
        "oracleLatestAnswer": 339388566254,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xBad6eF8e76E26F39e985474aD0974FDcabF85d37",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt weETH",
        "stableDebtTokenSymbol": "stableDebtEthweETH",
        "supplyCap": 8000,
        "symbol": "weETH",
        "underlying": "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x77ad9BF13a52517AD698D65913e8D381300c8Bf3",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt weETH",
        "variableDebtTokenSymbol": "variableDebtEthweETH"
      }
    }
  },
  "strategies": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
      "from": null,
      "to": {
        "address": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521",
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```