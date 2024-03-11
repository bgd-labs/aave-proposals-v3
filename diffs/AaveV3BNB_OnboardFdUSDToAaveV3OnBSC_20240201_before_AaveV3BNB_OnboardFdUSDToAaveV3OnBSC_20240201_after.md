## Reserve changes

### Reserves added

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 8,000,000 FDUSD |
| borrowCap | 7,500,000 FDUSD |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x390180e80058A8499930F0c13963AD3E0d86Bfc9](https://bscscan.com/address/0x390180e80058A8499930F0c13963AD3E0d86Bfc9) |
| oracleDecimals | 8 |
| oracleDescription | FDUSD / USD |
| oracleLatestAnswer | 0.99897852 |
| usageAsCollateralEnabled | true |
| ltv | 70 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x75bd1A659bdC62e4C313950d44A2416faB43E785](https://bscscan.com/address/0x75bd1A659bdC62e4C313950d44A2416faB43E785) |
| aTokenImpl | [0x6c23bAF050ec192afc0B967a93b83e6c5405df43](https://bscscan.com/address/0x6c23bAF050ec192afc0B967a93b83e6c5405df43) |
| variableDebtToken | [0xE628B8a123e6037f1542e662B9F55141a16945C8](https://bscscan.com/address/0xE628B8a123e6037f1542e662B9F55141a16945C8) |
| variableDebtTokenImpl | [0x777fBA024bA1228fDa76149A4ff8B23475ed057D](https://bscscan.com/address/0x777fBA024bA1228fDa76149A4ff8B23475ed057D) |
| stableDebtToken | [0x5543d347bfae77A5FF913e589aB6D6ad520f1C73](https://bscscan.com/address/0x5543d347bfae77A5FF913e589aB6D6ad520f1C73) |
| stableDebtTokenImpl | [0xb172a90A7C238969CE9B27cc19D13b60A91e7F00](https://bscscan.com/address/0xb172a90A7C238969CE9B27cc19D13b60A91e7F00) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | true |
| interestRateStrategy | [0xDFFD9CDd2eC42099D7086Ff76938C111022014D0](https://bscscan.com/address/0xDFFD9CDd2eC42099D7086Ff76938C111022014D0) |
| aTokenName | Aave BNB Smart Chain FDUSD |
| aTokenSymbol | aBnbFDUSD |
| isPaused | false |
| stableDebtTokenName | Aave BNB Smart Chain Stable Debt FDUSD |
| stableDebtTokenSymbol | stableDebtBnbFDUSD |
| variableDebtTokenName | Aave BNB Smart Chain Variable Debt FDUSD |
| variableDebtTokenSymbol | variableDebtBnbFDUSD |
| optimalUsageRatio | 90 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| maxExcessUsageRatio | 10 % |
| optimalStableToTotalDebtRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 6 % |
| variableRateSlope2 | 75 % |
| baseStableBorrowRate | 9 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/911a3480b9f792f655a3ba52d4db6447055ff426.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "from": null,
      "to": {
        "aToken": "0x75bd1A659bdC62e4C313950d44A2416faB43E785",
        "aTokenImpl": "0x6c23bAF050ec192afc0B967a93b83e6c5405df43",
        "aTokenName": "Aave BNB Smart Chain FDUSD",
        "aTokenSymbol": "aBnbFDUSD",
        "borrowCap": 7500000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xDFFD9CDd2eC42099D7086Ff76938C111022014D0",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "ltv": 7000,
        "oracle": "0x390180e80058A8499930F0c13963AD3E0d86Bfc9",
        "oracleDecimals": 8,
        "oracleDescription": "FDUSD / USD",
        "oracleLatestAnswer": 99897852,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x5543d347bfae77A5FF913e589aB6D6ad520f1C73",
        "stableDebtTokenImpl": "0xb172a90A7C238969CE9B27cc19D13b60A91e7F00",
        "stableDebtTokenName": "Aave BNB Smart Chain Stable Debt FDUSD",
        "stableDebtTokenSymbol": "stableDebtBnbFDUSD",
        "supplyCap": 8000000,
        "symbol": "FDUSD",
        "underlying": "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xE628B8a123e6037f1542e662B9F55141a16945C8",
        "variableDebtTokenImpl": "0x777fBA024bA1228fDa76149A4ff8B23475ed057D",
        "variableDebtTokenName": "Aave BNB Smart Chain Variable Debt FDUSD",
        "variableDebtTokenSymbol": "variableDebtBnbFDUSD"
      }
    }
  },
  "strategies": {
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "from": null,
      "to": {
        "address": "0xDFFD9CDd2eC42099D7086Ff76938C111022014D0",
        "baseStableBorrowRate": "90000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "130000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```