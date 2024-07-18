## Reserve changes

### Reserves added

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,500,000 USDC.e |
| borrowCap | 1,400,000 USDC.e |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x26C31ac71010aF62E6B486D1132E266D6298857D](https://gnosisscan.io/address/0x26C31ac71010aF62E6B486D1132E266D6298857D) |
| oracleDecimals | 8 |
| oracleDescription | USDC / USD |
| oracleLatestAnswer | 1.0000457 |
| usageAsCollateralEnabled | true |
| ltv | 75 % |
| liquidationThreshold | 78 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0xC0333cb85B59a788d8C7CAe5e1Fd6E229A3E5a65](https://gnosisscan.io/address/0xC0333cb85B59a788d8C7CAe5e1Fd6E229A3E5a65) |
| aTokenImpl | [0x589750BA8aF186cE5B55391B0b7148cAD43a1619](https://gnosisscan.io/address/0x589750BA8aF186cE5B55391B0b7148cAD43a1619) |
| variableDebtToken | [0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431](https://gnosisscan.io/address/0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431) |
| variableDebtTokenImpl | [0xBeC519531F0E78BcDdB295242fA4EC5251B38574](https://gnosisscan.io/address/0xBeC519531F0E78BcDdB295242fA4EC5251B38574) |
| stableDebtToken | [0x135A7bA96fBe20949cf2D8E46c7F5ca3bB1EE222](https://gnosisscan.io/address/0x135A7bA96fBe20949cf2D8E46c7F5ca3bB1EE222) |
| stableDebtTokenImpl | [0x06C35Cfd3FC61eC2aC437f0d08840d5776b945af](https://gnosisscan.io/address/0x06C35Cfd3FC61eC2aC437f0d08840d5776b945af) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x4F29DA9DA689652827b7192B373B3eE71BC2Df2B](https://gnosisscan.io/address/0x4F29DA9DA689652827b7192B373B3eE71BC2Df2B) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Gnosis USDCe |
| aTokenSymbol | aGnoUSDCe |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Gnosis Stable Debt USDCe |
| stableDebtTokenSymbol | stableDebtGnoUSDCe |
| variableDebtTokenName | Aave Gnosis Variable Debt USDCe |
| variableDebtTokenSymbol | variableDebtGnoUSDCe |
| optimalUsageRatio | 90 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 10 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9 % |
| variableRateSlope2 | 75 % |
| baseStableBorrowRate | 9 % |
| stableRateSlope1 | 9 % |
| stableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/d7b7613b07b73e6e47d0e203c2f438aeef747a01.svg) |


## Raw diff

```json
{
  "reserves": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "from": null,
      "to": {
        "aToken": "0xC0333cb85B59a788d8C7CAe5e1Fd6E229A3E5a65",
        "aTokenImpl": "0x589750BA8aF186cE5B55391B0b7148cAD43a1619",
        "aTokenName": "Aave Gnosis USDCe",
        "aTokenSymbol": "aGnoUSDCe",
        "borrowCap": 1400000,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 0,
        "interestRateStrategy": "0x4F29DA9DA689652827b7192B373B3eE71BC2Df2B",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7500,
        "oracle": "0x26C31ac71010aF62E6B486D1132E266D6298857D",
        "oracleDecimals": 8,
        "oracleDescription": "USDC / USD",
        "oracleLatestAnswer": 100004570,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x135A7bA96fBe20949cf2D8E46c7F5ca3bB1EE222",
        "stableDebtTokenImpl": "0x06C35Cfd3FC61eC2aC437f0d08840d5776b945af",
        "stableDebtTokenName": "Aave Gnosis Stable Debt USDCe",
        "stableDebtTokenSymbol": "stableDebtGnoUSDCe",
        "supplyCap": 1500000,
        "symbol": "USDC.e",
        "underlying": "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431",
        "variableDebtTokenImpl": "0xBeC519531F0E78BcDdB295242fA4EC5251B38574",
        "variableDebtTokenName": "Aave Gnosis Variable Debt USDCe",
        "variableDebtTokenSymbol": "variableDebtGnoUSDCe"
      }
    }
  },
  "strategies": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "from": null,
      "to": {
        "address": "0x4F29DA9DA689652827b7192B373B3eE71BC2Df2B",
        "baseStableBorrowRate": "90000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "90000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "90000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```