## Reserve changes

### Reserves added

#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,000 weETH |
| borrowCap | 100 weETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 2 |
| oracle | [0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3](https://arbiscan.io/address/0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3) |
| oracleDecimals | 8 |
| oracleDescription | Capped weETH / eETH(ETH) / USD |
| oracleLatestAnswer | 3342.70251943 |
| usageAsCollateralEnabled | true |
| ltv | 72.5 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77](https://arbiscan.io/address/0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0x3ca5FA07689F266e907439aFd1fBB59c44fe12f6](https://arbiscan.io/address/0x3ca5FA07689F266e907439aFd1fBB59c44fe12f6) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtToken | [0x40B4BAEcc69B882e8804f9286b12228C27F8c9BF](https://arbiscan.io/address/0x40B4BAEcc69B882e8804f9286b12228C27F8c9BF) |
| stableDebtTokenImpl | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f](https://arbiscan.io/address/0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Arbitrum weETH |
| aTokenSymbol | aArbweETH |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt weETH |
| stableDebtTokenSymbol | stableDebtArbweETH |
| variableDebtTokenName | Aave Arbitrum Variable Debt weETH |
| variableDebtTokenSymbol | variableDebtArbweETH |
| optimalUsageRatio | 45 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| maxExcessUsageRatio | 55 % |
| optimalStableToTotalDebtRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 9 % |
| stableRateSlope1 | 7 % |
| stableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/859e8f346e62fa5dc8eed4d223ca2a8d1c9fc80c.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 93 % |
| eMode.liquidationThreshold | 95 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "from": null,
      "to": {
        "aToken": "0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum weETH",
        "aTokenSymbol": "aArbweETH",
        "borrowCap": 100,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 2,
        "interestRateStrategy": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f",
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
        "oracle": "0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3",
        "oracleDecimals": 8,
        "oracleDescription": "Capped weETH / eETH(ETH) / USD",
        "oracleLatestAnswer": 334270251943,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x40B4BAEcc69B882e8804f9286b12228C27F8c9BF",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt weETH",
        "stableDebtTokenSymbol": "stableDebtArbweETH",
        "supplyCap": 1000,
        "symbol": "weETH",
        "underlying": "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x3ca5FA07689F266e907439aFd1fBB59c44fe12f6",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt weETH",
        "variableDebtTokenSymbol": "variableDebtArbweETH"
      }
    }
  },
  "strategies": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "from": null,
      "to": {
        "address": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f",
        "baseStableBorrowRate": "90000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```