## Reserve changes

### Reserves added

#### weETH ([0x01f0a31698C4d065659b9bdC21B3610292a1c506](https://scrollscan.com/address/0x01f0a31698C4d065659b9bdC21B3610292a1c506))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 2,000 weETH |
| borrowCap | 400 weETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9](https://scrollscan.com/address/0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9) |
| oracleDecimals | 8 |
| oracleDescription | Capped weETH / eETH(ETH) / USD |
| oracleLatestAnswer | 3370.08625918 |
| usageAsCollateralEnabled | true |
| ltv | 72.5 % [7250] |
| liquidationThreshold | 75 % [7500] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0xd80A5e16DBDC52Bd1C947CEDfA22c562Be9129C8](https://scrollscan.com/address/0xd80A5e16DBDC52Bd1C947CEDfA22c562Be9129C8) |
| aTokenImpl | [0x92EDe4ABd9df4Bfb49b4d723e4c932e35c47C54C](https://scrollscan.com/address/0x92EDe4ABd9df4Bfb49b4d723e4c932e35c47C54C) |
| variableDebtToken | [0x009D88C6a6B4CaA240b71C98BA93732e26F2A55A](https://scrollscan.com/address/0x009D88C6a6B4CaA240b71C98BA93732e26F2A55A) |
| variableDebtTokenImpl | [0x49bA16C08130FF8cFADE263B49387A8555bc057B](https://scrollscan.com/address/0x49bA16C08130FF8cFADE263B49387A8555bc057B) |
| stableDebtToken | [0xF474cC392591E3252996459FCAA3D75dc9F95b09](https://scrollscan.com/address/0xF474cC392591E3252996459FCAA3D75dc9F95b09) |
| stableDebtTokenImpl | [0x8Ff5f08EDB2E5e1A51bd14d0494320bdB436a149](https://scrollscan.com/address/0x8Ff5f08EDB2E5e1A51bd14d0494320bdB436a149) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xEC93d0BBA1b1e635ba0Fff4786dB323db49D99F0](https://scrollscan.com/address/0xEC93d0BBA1b1e635ba0Fff4786dB323db49D99F0) |
| aTokenName | Aave Scroll weETH |
| aTokenSymbol | aScrweETH |
| aTokenUnderlyingBalance | 0.005 weETH [5000000000000000] |
| isPaused | false |
| stableDebtTokenName | Aave Scroll Stable Debt weETH |
| stableDebtTokenSymbol | stableDebtScrweETH |
| variableDebtTokenName | Aave Scroll Variable Debt weETH |
| variableDebtTokenSymbol | variableDebtScrweETH |
| virtualAccountingActive | true |
| virtualBalance | 0.005 weETH [5000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/8fa1be0a18750a60d1bf8c471ee14d962f51656a.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 90 % |
| eMode.liquidationThreshold | 93 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0x01f0a31698C4d065659b9bdC21B3610292a1c506": {
      "from": null,
      "to": {
        "aToken": "0xd80A5e16DBDC52Bd1C947CEDfA22c562Be9129C8",
        "aTokenImpl": "0x92EDe4ABd9df4Bfb49b4d723e4c932e35c47C54C",
        "aTokenName": "Aave Scroll weETH",
        "aTokenSymbol": "aScrweETH",
        "aTokenUnderlyingBalance": "5000000000000000",
        "borrowCap": 400,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 1,
        "interestRateStrategy": "0xEC93d0BBA1b1e635ba0Fff4786dB323db49D99F0",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "ltv": 7250,
        "oracle": "0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9",
        "oracleDecimals": 8,
        "oracleDescription": "Capped weETH / eETH(ETH) / USD",
        "oracleLatestAnswer": 337008625918,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xF474cC392591E3252996459FCAA3D75dc9F95b09",
        "stableDebtTokenImpl": "0x8Ff5f08EDB2E5e1A51bd14d0494320bdB436a149",
        "stableDebtTokenName": "Aave Scroll Stable Debt weETH",
        "stableDebtTokenSymbol": "stableDebtScrweETH",
        "supplyCap": 2000,
        "symbol": "weETH",
        "underlying": "0x01f0a31698C4d065659b9bdC21B3610292a1c506",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x009D88C6a6B4CaA240b71C98BA93732e26F2A55A",
        "variableDebtTokenImpl": "0x49bA16C08130FF8cFADE263B49387A8555bc057B",
        "variableDebtTokenName": "Aave Scroll Variable Debt weETH",
        "variableDebtTokenSymbol": "variableDebtScrweETH",
        "virtualAccountingActive": true,
        "virtualBalance": "5000000000000000"
      }
    }
  },
  "strategies": {
    "0x01f0a31698C4d065659b9bdC21B3610292a1c506": {
      "from": null,
      "to": {
        "address": "0xEC93d0BBA1b1e635ba0Fff4786dB323db49D99F0",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3070000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```