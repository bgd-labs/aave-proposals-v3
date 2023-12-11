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
| oracleLatestAnswer | 0.99994367 |
| usageAsCollateralEnabled | true |
| ltv | 77 % |
| liquidationThreshold | 80 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D](https://basescan.org/address/0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1](https://basescan.org/address/0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| stableDebtToken | [0xfe742Fa2a84294E8316F05b17c05090Fc68B5105](https://basescan.org/address/0xfe742Fa2a84294E8316F05b17c05090Fc68B5105) |
| stableDebtTokenImpl | [0xe0b9B4f959fa8B52B7228c8D78875482b8813349](https://basescan.org/address/0xe0b9B4f959fa8B52B7228c8D78875482b8813349) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9](https://basescan.org/address/0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9) |
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
| interestRateStrategy | [0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3](https://basescan.org/address/0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3) | [0x50eC656Ba67885D0937b5f549f3104ea15E75588](https://basescan.org/address/0x50eC656Ba67885D0937b5f549f3104ea15E75588) |
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
        "to": "0x50eC656Ba67885D0937b5f549f3104ea15E75588"
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
        "aToken": "0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base USDC",
        "aTokenSymbol": "aBasUSDC",
        "borrowCap": 9000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 0,
        "interestRateStrategy": "0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9",
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
        "oracleLatestAnswer": 99994367,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xfe742Fa2a84294E8316F05b17c05090Fc68B5105",
        "stableDebtTokenImpl": "0xe0b9B4f959fa8B52B7228c8D78875482b8813349",
        "stableDebtTokenName": "Aave Base Stable Debt USDC",
        "stableDebtTokenSymbol": "stableDebtBasUSDC",
        "supplyCap": 10000000,
        "symbol": "USDC",
        "underlying": "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt USDC",
        "variableDebtTokenSymbol": "variableDebtBasUSDC"
      }
    }
  },
  "strategies": {
    "0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9": {
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
    "0x50eC656Ba67885D0937b5f549f3104ea15E75588": {
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