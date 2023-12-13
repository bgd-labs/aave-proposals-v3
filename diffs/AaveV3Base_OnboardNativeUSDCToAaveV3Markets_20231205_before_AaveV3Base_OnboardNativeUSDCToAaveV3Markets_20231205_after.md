## Reserve changes

### Reserves added

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 10,000,000 USDC |
| borrowCap | 9,000,000 USDC |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x7e860098F58bBFC8648a4311b374B1D669a2bc6B](https://basescan.org/address/0x7e860098F58bBFC8648a4311b374B1D669a2bc6B) |
| oracleDecimals | 8 |
| oracleDescription | USDC / USD |
| oracleLatestAnswer | 1.00006816 |
| usageAsCollateralEnabled | true |
| ltv | 77 % |
| liquidationThreshold | 80 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0x4e65fE4DbA92790696d040ac24Aa414708F5c0AB](https://basescan.org/address/0x4e65fE4DbA92790696d040ac24Aa414708F5c0AB) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0x59dca05b6c26dbd64b5381374aAaC5CD05644C28](https://basescan.org/address/0x59dca05b6c26dbd64b5381374aAaC5CD05644C28) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| stableDebtToken | [0x03506214379aA86ad1176af71c260278cfa10B38](https://basescan.org/address/0x03506214379aA86ad1176af71c260278cfa10B38) |
| stableDebtTokenImpl | [0xe0b9B4f959fa8B52B7228c8D78875482b8813349](https://basescan.org/address/0xe0b9B4f959fa8B52B7228c8D78875482b8813349) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x50eC656Ba67885D0937b5f549f3104ea15E75588](https://basescan.org/address/0x50eC656Ba67885D0937b5f549f3104ea15E75588) |
| aTokenName | Aave Base USDC |
| aTokenSymbol | aBasUSDC |
| isPaused | false |
| stableDebtTokenName | Aave Base Stable Debt USDC |
| stableDebtTokenSymbol | stableDebtBasUSDC |
| variableDebtTokenName | Aave Base Variable Debt USDC |
| variableDebtTokenSymbol | variableDebtBasUSDC |
| optimalUsageRatio | 90 % |
| maxExcessUsageRatio | 10 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5 % |
| variableRateSlope2 | 60 % |
| baseStableBorrowRate | 5 % |
| stableRateSlope1 | 5 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 0 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| interestRate | ![ir](/.assets/efc214f63e0c80895bc42d351a69ea2281997d59.svg) |


### Reserves altered

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 8,000,000 USDbC | 2,000,000 USDbC |
| borrowCap | 6,500,000 USDbC | 2,000,000 USDbC |
| reserveFactor | 10 % | 20 % |
| interestRateStrategy | [0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3](https://basescan.org/address/0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3) | [0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7](https://basescan.org/address/0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7) |
| variableRateSlope1 | 5 % | 7 % |
| variableRateSlope2 | 60 % | 80 % |
| baseStableBorrowRate | 6 % | 8 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/08d9252b4f8f8c9e59638a9a35a34e736f126166.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "borrowCap": {
        "from": 6500000,
        "to": 2000000
      },
      "interestRateStrategy": {
        "from": "0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3",
        "to": "0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7"
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      },
      "supplyCap": {
        "from": 8000000,
        "to": 2000000
      }
    },
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "from": null,
      "to": {
        "aToken": "0x4e65fE4DbA92790696d040ac24Aa414708F5c0AB",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base USDC",
        "aTokenSymbol": "aBasUSDC",
        "borrowCap": 9000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 0,
        "interestRateStrategy": "0x50eC656Ba67885D0937b5f549f3104ea15E75588",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 8000,
        "ltv": 7700,
        "oracle": "0x7e860098F58bBFC8648a4311b374B1D669a2bc6B",
        "oracleDecimals": 8,
        "oracleDescription": "USDC / USD",
        "oracleLatestAnswer": 100006816,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x03506214379aA86ad1176af71c260278cfa10B38",
        "stableDebtTokenImpl": "0xe0b9B4f959fa8B52B7228c8D78875482b8813349",
        "stableDebtTokenName": "Aave Base Stable Debt USDC",
        "stableDebtTokenSymbol": "stableDebtBasUSDC",
        "supplyCap": 10000000,
        "symbol": "USDC",
        "underlying": "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x59dca05b6c26dbd64b5381374aAaC5CD05644C28",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt USDC",
        "variableDebtTokenSymbol": "variableDebtBasUSDC"
      }
    }
  },
  "strategies": {
    "0x50eC656Ba67885D0937b5f549f3104ea15E75588": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    },
    "0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```