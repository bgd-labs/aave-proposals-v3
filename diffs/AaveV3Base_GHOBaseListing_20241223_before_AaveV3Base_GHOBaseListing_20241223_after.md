## Reserve changes

### Reserves added

#### GHO ([0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D](https://basescan.org/address/0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 2,500,000 GHO |
| borrowCap | 2,250,000 GHO |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://basescan.org/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
| oracleDecimals | 8 |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 10 % [1000] |
| aToken | [0xDD5745756C2de109183c6B5bB886F9207bEF114D](https://basescan.org/address/0xDD5745756C2de109183c6B5bB886F9207bEF114D) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd](https://basescan.org/address/0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base GHO |
| aTokenSymbol | aBasGHO |
| aTokenUnderlyingBalance | 1 GHO [1000000000000000000] |
| id | 7 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtBasGHO |
| virtualAccountingActive | true |
| virtualBalance | 1 GHO [1000000000000000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 77 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 12 % |
| variableRateSlope2 | 65 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=650000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=770000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D": {
      "from": null,
      "to": {
        "aToken": "0xDD5745756C2de109183c6B5bB886F9207bEF114D",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base GHO",
        "aTokenSymbol": "aBasGHO",
        "aTokenUnderlyingBalance": "1000000000000000000",
        "borrowCap": 2250000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 7,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73",
        "oracleDecimals": 8,
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 1000,
        "supplyCap": 2500000,
        "symbol": "GHO",
        "underlying": "0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtBasGHO",
        "virtualAccountingActive": true,
        "virtualBalance": "1000000000000000000"
      }
    }
  },
  "strategies": {
    "0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "770000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "120000000000000000000000000",
        "variableRateSlope2": "650000000000000000000000000"
      }
    }
  }
}
```