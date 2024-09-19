## Reserve changes

### Reserves added

#### cbBTC ([0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf](https://basescan.org/address/0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf))

| description | value |
| --- | --- |
| decimals | 8 |
| isActive | true |
| isFrozen | false |
| supplyCap | 200 cbBTC |
| borrowCap | 20 cbBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F](https://basescan.org/address/0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 58563.14650823 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0xBdb9300b7CDE636d9cD4AFF00f6F009fFBBc8EE6](https://basescan.org/address/0xBdb9300b7CDE636d9cD4AFF00f6F009fFBBc8EE6) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0x05e08702028de6AaD395DC6478b554a56920b9AD](https://basescan.org/address/0x05e08702028de6AaD395DC6478b554a56920b9AD) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| stableDebtToken | [0x839A515eB049237a6D4978F1735a00608a5A857D](https://basescan.org/address/0x839A515eB049237a6D4978F1735a00608a5A857D) |
| stableDebtTokenImpl | [0xe0b9B4f959fa8B52B7228c8D78875482b8813349](https://basescan.org/address/0xe0b9B4f959fa8B52B7228c8D78875482b8813349) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x46Da028a47Ed58026aCbFbE91eeA51CcB062134E](https://basescan.org/address/0x46Da028a47Ed58026aCbFbE91eeA51CcB062134E) |
| aTokenName | Aave Base cbBTC |
| aTokenSymbol | aBascbBTC |
| aTokenUnderlyingBalance | 0.002 cbBTC [200000] |
| isPaused | false |
| stableDebtTokenName | Aave Base Stable Debt cbBTC |
| stableDebtTokenSymbol | stableDebtBascbBTC |
| variableDebtTokenName | Aave Base Variable Debt cbBTC |
| variableDebtTokenSymbol | variableDebtBascbBTC |
| virtualAccountingActive | true |
| virtualBalance | 0.002 cbBTC [200000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/10bfcca87ef9d6ab4ccf97fcb660cfa970edab1f.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "from": null,
      "to": {
        "aToken": "0xBdb9300b7CDE636d9cD4AFF00f6F009fFBBc8EE6",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base cbBTC",
        "aTokenSymbol": "aBascbBTC",
        "aTokenUnderlyingBalance": 200000,
        "borrowCap": 20,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 8,
        "eModeCategory": 0,
        "interestRateStrategy": "0x46Da028a47Ed58026aCbFbE91eeA51CcB062134E",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7300,
        "oracle": "0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": 5856314650823,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x839A515eB049237a6D4978F1735a00608a5A857D",
        "stableDebtTokenImpl": "0xe0b9B4f959fa8B52B7228c8D78875482b8813349",
        "stableDebtTokenName": "Aave Base Stable Debt cbBTC",
        "stableDebtTokenSymbol": "stableDebtBascbBTC",
        "supplyCap": 200,
        "symbol": "cbBTC",
        "underlying": "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x05e08702028de6AaD395DC6478b554a56920b9AD",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt cbBTC",
        "variableDebtTokenSymbol": "variableDebtBascbBTC",
        "virtualAccountingActive": true,
        "virtualBalance": 200000
      }
    }
  },
  "strategies": {
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "from": null,
      "to": {
        "address": "0x46Da028a47Ed58026aCbFbE91eeA51CcB062134E",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3040000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```