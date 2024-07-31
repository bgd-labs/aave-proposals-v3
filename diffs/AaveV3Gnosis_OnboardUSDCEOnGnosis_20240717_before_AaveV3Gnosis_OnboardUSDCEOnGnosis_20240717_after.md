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
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2](https://gnosisscan.io/address/0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDC/USD |
| oracleLatestAnswer | 1.00001543 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0xC0333cb85B59a788d8C7CAe5e1Fd6E229A3E5a65](https://gnosisscan.io/address/0xC0333cb85B59a788d8C7CAe5e1Fd6E229A3E5a65) |
| aTokenImpl | [0x589750BA8aF186cE5B55391B0b7148cAD43a1619](https://gnosisscan.io/address/0x589750BA8aF186cE5B55391B0b7148cAD43a1619) |
| variableDebtToken | [0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431](https://gnosisscan.io/address/0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431) |
| variableDebtTokenImpl | [0xBeC519531F0E78BcDdB295242fA4EC5251B38574](https://gnosisscan.io/address/0xBeC519531F0E78BcDdB295242fA4EC5251B38574) |
| stableDebtToken | [0x135A7bA96fBe20949cf2D8E46c7F5ca3bB1EE222](https://gnosisscan.io/address/0x135A7bA96fBe20949cf2D8E46c7F5ca3bB1EE222) |
| stableDebtTokenImpl | [0x06C35Cfd3FC61eC2aC437f0d08840d5776b945af](https://gnosisscan.io/address/0x06C35Cfd3FC61eC2aC437f0d08840d5776b945af) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | true |
| interestRateStrategy | [0x98619395148C348e9A09C7D34290B1E9e7715A3E](https://gnosisscan.io/address/0x98619395148C348e9A09C7D34290B1E9e7715A3E) |
| aTokenName | Aave Gnosis USDCe |
| aTokenSymbol | aGnoUSDCe |
| aTokenUnderlyingBalance | 1 USDC.e [1000000] |
| isPaused | false |
| stableDebtTokenName | Aave Gnosis Stable Debt USDCe |
| stableDebtTokenSymbol | stableDebtGnoUSDCe |
| variableDebtTokenName | Aave Gnosis Variable Debt USDCe |
| variableDebtTokenSymbol | variableDebtGnoUSDCe |
| virtualAccountingActive | true |
| virtualBalance | 1 USDC.e [1000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 84 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9 % |
| variableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/efb1d5f0320ec48c3f00eae412ff5bf1dbe5f0a3.svg) |


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
        "aTokenUnderlyingBalance": 1000000,
        "borrowCap": 1400000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 0,
        "interestRateStrategy": "0x98619395148C348e9A09C7D34290B1E9e7715A3E",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7500,
        "oracle": "0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDC/USD",
        "oracleLatestAnswer": 100001543,
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
        "variableDebtToken": "0x37B9Ad6b5DC8Ad977AD716e92F49e9D200e58431",
        "variableDebtTokenImpl": "0xBeC519531F0E78BcDdB295242fA4EC5251B38574",
        "variableDebtTokenName": "Aave Gnosis Variable Debt USDCe",
        "variableDebtTokenSymbol": "variableDebtGnoUSDCe",
        "virtualAccountingActive": true,
        "virtualBalance": 1000000
      }
    }
  },
  "strategies": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "from": null,
      "to": {
        "address": "0x98619395148C348e9A09C7D34290B1E9e7715A3E",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "840000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "90000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```