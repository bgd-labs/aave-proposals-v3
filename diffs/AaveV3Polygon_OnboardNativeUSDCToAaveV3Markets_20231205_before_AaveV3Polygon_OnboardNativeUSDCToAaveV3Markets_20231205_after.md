## Reserve changes

### Reserves added

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 USDC |
| borrowCap | 45,000,000 USDC |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7](https://polygonscan.com/address/0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7) |
| oracleDecimals | 8 |
| oracleDescription | USDC / USD |
| oracleLatestAnswer | 1.0003053 |
| usageAsCollateralEnabled | true |
| ltv | 77 % |
| liquidationThreshold | 80 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0xA4D94019934D8333Ef880ABFFbF2FDd611C762BD](https://polygonscan.com/address/0xA4D94019934D8333Ef880ABFFbF2FDd611C762BD) |
| aTokenImpl | [0xCf85FF1c37c594a10195F7A9Ab85CBb0a03f69dE](https://polygonscan.com/address/0xCf85FF1c37c594a10195F7A9Ab85CBb0a03f69dE) |
| variableDebtToken | [0xE701126012EC0290822eEA17B794454d1AF8b030](https://polygonscan.com/address/0xE701126012EC0290822eEA17B794454d1AF8b030) |
| variableDebtTokenImpl | [0x79b5e91037AE441dE0d9e6fd3Fd85b96B83d4E93](https://polygonscan.com/address/0x79b5e91037AE441dE0d9e6fd3Fd85b96B83d4E93) |
| stableDebtToken | [0xc889e9f8370D14A428a9857205d99BFdB400b757](https://polygonscan.com/address/0xc889e9f8370D14A428a9857205d99BFdB400b757) |
| stableDebtTokenImpl | [0x50ddd0Cd4266299527d25De9CBb55fE0EB8dAc30](https://polygonscan.com/address/0x50ddd0Cd4266299527d25De9CBb55fE0EB8dAc30) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://polygonscan.com/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) |
| aTokenName | Aave Polygon USDCn |
| aTokenSymbol | aPolUSDCn |
| isPaused | false |
| stableDebtTokenName | Aave Polygon Stable Debt USDCn |
| stableDebtTokenSymbol | stableDebtPolUSDCn |
| variableDebtTokenName | Aave Polygon Variable Debt USDCn |
| variableDebtTokenSymbol | variableDebtPolUSDCn |
| optimalUsageRatio | 90 % |
| maxExcessUsageRatio | 10 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5 % |
| variableRateSlope2 | 60 % |
| baseStableBorrowRate | 5 % |
| stableRateSlope1 | 5 % |
| stableRateSlope2 | 60 % |
| optimalStableToTotalDebtRatio | 0 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| interestRate | ![ir](/.assets/84c6523d74f61d0ba00e446918a767fdc26e571b.svg) |
| eMode.label | Stablecoins |
| eMode.ltv | 93 % |
| eMode.liquidationThreshold | 95 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


### Reserves altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 150,000,000 USDC | 40,000,000 USDC |
| borrowCap | 100,000,000 USDC | 36,000,000 USDC |
| ltv | 82.5 % | 77 % |
| liquidationThreshold | 85 % | 80 % |
| liquidationBonus | 4 % | 5 % |
| reserveFactor | 10 % | 20 % |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://polygonscan.com/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0x588b62C84533232E3A881e096E5D639Fa754F093](https://polygonscan.com/address/0x588b62C84533232E3A881e096E5D639Fa754F093) |
| variableRateSlope1 | 5 % | 7 % |
| variableRateSlope2 | 60 % | 80 % |
| baseStableBorrowRate | 6 % | 8 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/08d9252b4f8f8c9e59638a9a35a34e736f126166.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "borrowCap": {
        "from": 100000000,
        "to": 36000000
      },
      "interestRateStrategy": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0x588b62C84533232E3A881e096E5D639Fa754F093"
      },
      "liquidationBonus": {
        "from": 10400,
        "to": 10500
      },
      "liquidationThreshold": {
        "from": 8500,
        "to": 8000
      },
      "ltv": {
        "from": 8250,
        "to": 7700
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      },
      "supplyCap": {
        "from": 150000000,
        "to": 40000000
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "from": null,
      "to": {
        "aToken": "0xA4D94019934D8333Ef880ABFFbF2FDd611C762BD",
        "aTokenImpl": "0xCf85FF1c37c594a10195F7A9Ab85CBb0a03f69dE",
        "aTokenName": "Aave Polygon USDCn",
        "aTokenSymbol": "aPolUSDCn",
        "borrowCap": 45000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 1,
        "interestRateStrategy": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
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
        "oracle": "0xfE4A8cc5b5B2366C1B58Bea3858e81843581b2F7",
        "oracleDecimals": 8,
        "oracleDescription": "USDC / USD",
        "oracleLatestAnswer": 100030530,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xc889e9f8370D14A428a9857205d99BFdB400b757",
        "stableDebtTokenImpl": "0x50ddd0Cd4266299527d25De9CBb55fE0EB8dAc30",
        "stableDebtTokenName": "Aave Polygon Stable Debt USDCn",
        "stableDebtTokenSymbol": "stableDebtPolUSDCn",
        "supplyCap": 50000000,
        "symbol": "USDC",
        "underlying": "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xE701126012EC0290822eEA17B794454d1AF8b030",
        "variableDebtTokenImpl": "0x79b5e91037AE441dE0d9e6fd3Fd85b96B83d4E93",
        "variableDebtTokenName": "Aave Polygon Variable Debt USDCn",
        "variableDebtTokenSymbol": "variableDebtPolUSDCn"
      }
    }
  },
  "strategies": {
    "0x53b13a6D43F647D788411Abfd28D229C274AfBF9": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    },
    "0x588b62C84533232E3A881e096E5D639Fa754F093": {
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