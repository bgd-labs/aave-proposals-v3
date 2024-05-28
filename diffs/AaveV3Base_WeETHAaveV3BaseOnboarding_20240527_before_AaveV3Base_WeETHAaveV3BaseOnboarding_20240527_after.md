## Reserve changes

### Reserves added

#### weETH ([0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A](https://basescan.org/address/0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 150 weETH |
| borrowCap | 30 weETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0xFc4d1d7a8FD1E6719e361e16044b460737F12C44](https://basescan.org/address/0xFc4d1d7a8FD1E6719e361e16044b460737F12C44) |
| oracleDecimals | 8 |
| oracleDescription | Capped weETH / eETH(ETH) / USD |
| oracleLatestAnswer | 4080.41872448 |
| usageAsCollateralEnabled | true |
| ltv | 72.5 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 45 % |
| aToken | [0x7C307e128efA31F540F2E2d976C995E0B65F51F6](https://basescan.org/address/0x7C307e128efA31F540F2E2d976C995E0B65F51F6) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0x8D2e3F1f4b38AA9f1ceD22ac06019c7561B03901](https://basescan.org/address/0x8D2e3F1f4b38AA9f1ceD22ac06019c7561B03901) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| stableDebtToken | [0xCBEdA45432D5325585ACAD29244f113C237B6Cf0](https://basescan.org/address/0xCBEdA45432D5325585ACAD29244f113C237B6Cf0) |
| stableDebtTokenImpl | [0xe0b9B4f959fa8B52B7228c8D78875482b8813349](https://basescan.org/address/0xe0b9B4f959fa8B52B7228c8D78875482b8813349) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xA31AcCd744EBdbF1b36E4556Ea09C8b34CD65bb2](https://basescan.org/address/0xA31AcCd744EBdbF1b36E4556Ea09C8b34CD65bb2) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Base weETH |
| aTokenSymbol | aBasweETH |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Base Stable Debt weETH |
| stableDebtTokenSymbol | stableDebtBasweETH |
| variableDebtTokenName | Aave Base Variable Debt weETH |
| variableDebtTokenSymbol | variableDebtBasweETH |
| optimalUsageRatio | 35 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 65 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 7 % |
| stableRateSlope1 | 7 % |
| stableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/54e10a13590d5a2968c8308e367ee942724c8f5a.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 90 % |
| eMode.liquidationThreshold | 93 % |
| eMode.liquidationBonus | 2 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A": {
      "from": null,
      "to": {
        "aToken": "0x7C307e128efA31F540F2E2d976C995E0B65F51F6",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base weETH",
        "aTokenSymbol": "aBasweETH",
        "borrowCap": 30,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 1,
        "interestRateStrategy": "0xA31AcCd744EBdbF1b36E4556Ea09C8b34CD65bb2",
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
        "oracle": "0xFc4d1d7a8FD1E6719e361e16044b460737F12C44",
        "oracleDecimals": 8,
        "oracleDescription": "Capped weETH / eETH(ETH) / USD",
        "oracleLatestAnswer": 408041872448,
        "reserveFactor": 4500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xCBEdA45432D5325585ACAD29244f113C237B6Cf0",
        "stableDebtTokenImpl": "0xe0b9B4f959fa8B52B7228c8D78875482b8813349",
        "stableDebtTokenName": "Aave Base Stable Debt weETH",
        "stableDebtTokenSymbol": "stableDebtBasweETH",
        "supplyCap": 150,
        "symbol": "weETH",
        "underlying": "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x8D2e3F1f4b38AA9f1ceD22ac06019c7561B03901",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt weETH",
        "variableDebtTokenSymbol": "variableDebtBasweETH"
      }
    }
  },
  "strategies": {
    "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A": {
      "from": null,
      "to": {
        "address": "0xA31AcCd744EBdbF1b36E4556Ea09C8b34CD65bb2",
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "650000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "350000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```