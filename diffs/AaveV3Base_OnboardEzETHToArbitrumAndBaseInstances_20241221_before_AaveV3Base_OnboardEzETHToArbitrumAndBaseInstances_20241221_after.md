## Reserve changes

### Reserves added

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://basescan.org/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,200 ezETH |
| borrowCap | 1 ezETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x438e24f5FCDC1A66ecb25D19B5543e0Cb91A44D4](https://basescan.org/address/0x438e24f5FCDC1A66ecb25D19B5543e0Cb91A44D4) |
| oracleDecimals | 8 |
| oracleDescription | Capped ezETH / ETH / USD |
| oracleLatestAnswer | 3785.26748692 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0xDD5745756C2de109183c6B5bB886F9207bEF114D](https://basescan.org/address/0xDD5745756C2de109183c6B5bB886F9207bEF114D) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd](https://basescan.org/address/0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base ezETH |
| aTokenSymbol | aBasezETH |
| aTokenUnderlyingBalance | 0.03 ezETH [30000000000000000] |
| id | 7 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt ezETH |
| variableDebtTokenSymbol | variableDebtBasezETH |
| virtualAccountingActive | true |
| virtualBalance | 0.03 ezETH [30000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH wstETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | ezETH |


### EMode: ezETH Stablecoins(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH Stablecoins |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDC |
| eMode.collateralBitmap | - | ezETH |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "from": null,
      "to": {
        "borrowableBitmap": "8",
        "collateralBitmap": "128",
        "eModeCategory": 2,
        "label": "ezETH wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "128",
        "eModeCategory": 3,
        "label": "ezETH Stablecoins",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
      }
    }
  },
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "from": null,
      "to": {
        "aToken": "0xDD5745756C2de109183c6B5bB886F9207bEF114D",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base ezETH",
        "aTokenSymbol": "aBasezETH",
        "aTokenUnderlyingBalance": "30000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
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
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0x438e24f5FCDC1A66ecb25D19B5543e0Cb91A44D4",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ezETH / ETH / USD",
        "oracleLatestAnswer": "378526748692",
        "reserveFactor": 1500,
        "supplyCap": 1200,
        "symbol": "ezETH",
        "underlying": "0x2416092f143378750bb29b79eD961ab195CcEea5",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xbc4f5631f2843488792e4F1660d0A51Ba489bdBd",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt ezETH",
        "variableDebtTokenSymbol": "variableDebtBasezETH",
        "virtualAccountingActive": true,
        "virtualBalance": "30000000000000000"
      }
    }
  },
  "strategies": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
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