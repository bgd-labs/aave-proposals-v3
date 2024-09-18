## Reserve changes

### Reserves added

#### sUSDS ([0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD](https://etherscan.io/address/0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 35,000,000 sUSDS |
| borrowCap | 0 sUSDS |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x408e905577653430Bb80d91e0ca433b338CEA7C6](https://etherscan.io/address/0x408e905577653430Bb80d91e0ca433b338CEA7C6) |
| oracleDecimals | 8 |
| oracleDescription | Capped sUSDS / USDS <-> DAI / USD |
| oracleLatestAnswer | 1.00006144 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 25 % [2500] |
| aToken | [0x10Ac93971cdb1F5c778144084242374473c350Da](https://etherscan.io/address/0x10Ac93971cdb1F5c778144084242374473c350Da) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960](https://etherscan.io/address/0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca](https://etherscan.io/address/0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | false |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x847A3364Cc5fE389283bD821cfC8A477288D9e82](https://etherscan.io/address/0x847A3364Cc5fE389283bD821cfC8A477288D9e82) |
| aTokenName | Aave Ethereum sUSDS |
| aTokenSymbol | aEthsUSDS |
| aTokenUnderlyingBalance | 100 sUSDS [100000000000000000000] |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt sUSDS |
| stableDebtTokenSymbol | stableDebtEthsUSDS |
| variableDebtTokenName | Aave Ethereum Variable Debt sUSDS |
| variableDebtTokenSymbol | variableDebtEthsUSDS |
| virtualAccountingActive | true |
| virtualBalance | 100 sUSDS [100000000000000000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 80.5 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5.5 % |
| variableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/a05225d2527d0291dbe4574aa3ce9f1f7d877630.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD": {
      "from": null,
      "to": {
        "aToken": "0x10Ac93971cdb1F5c778144084242374473c350Da",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum sUSDS",
        "aTokenSymbol": "aEthsUSDS",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x847A3364Cc5fE389283bD821cfC8A477288D9e82",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7500,
        "oracle": "0x408e905577653430Bb80d91e0ca433b338CEA7C6",
        "oracleDecimals": 8,
        "oracleDescription": "Capped sUSDS / USDS <-> DAI / USD",
        "oracleLatestAnswer": 100006144,
        "reserveFactor": 2500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt sUSDS",
        "stableDebtTokenSymbol": "stableDebtEthsUSDS",
        "supplyCap": 35000000,
        "symbol": "sUSDS",
        "underlying": "0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt sUSDS",
        "variableDebtTokenSymbol": "variableDebtEthsUSDS",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0xa3931d71877C0E7a3148CB7Eb4463524FEc27fbD": {
      "from": null,
      "to": {
        "address": "0x847A3364Cc5fE389283bD821cfC8A477288D9e82",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "805000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "55000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```