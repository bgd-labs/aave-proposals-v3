## Reserve changes

### Reserves added

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://arbiscan.io/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,750 ezETH |
| borrowCap | 1 ezETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x8Ed37B72300683c0482A595bfa80fFb793874b15](https://arbiscan.io/address/0x8Ed37B72300683c0482A595bfa80fFb793874b15) |
| oracleDecimals | 8 |
| oracleDescription | Capped ezETH / ETH / USD |
| oracleLatestAnswer | 3787.98660028 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0xEA1132120ddcDDA2F119e99Fa7A27a0d036F7Ac9](https://arbiscan.io/address/0xEA1132120ddcDDA2F119e99Fa7A27a0d036F7Ac9) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0x1fFD28689DA7d0148ff0fCB669e9f9f0Fc13a219](https://arbiscan.io/address/0x1fFD28689DA7d0148ff0fCB669e9f9f0Fc13a219) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F](https://arbiscan.io/address/0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F) |
| aTokenName | Aave Arbitrum ezETH |
| aTokenSymbol | aArbezETH |
| aTokenUnderlyingBalance | 0.03 ezETH [30000000000000000] |
| id | 17 |
| isPaused | false |
| variableDebtTokenName | Aave Arbitrum Variable Debt ezETH |
| variableDebtTokenSymbol | variableDebtArbezETH |
| virtualAccountingActive | true |
| virtualBalance | 0.03 ezETH [30000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH wstETH(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH wstETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | ezETH |


### EMode: ezETH Stablecoins(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH Stablecoins |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDT, USDC |
| eMode.collateralBitmap | - | ezETH |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "256",
        "collateralBitmap": "131072",
        "eModeCategory": 3,
        "label": "ezETH wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "4128",
        "collateralBitmap": "131072",
        "eModeCategory": 4,
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
        "aToken": "0xEA1132120ddcDDA2F119e99Fa7A27a0d036F7Ac9",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum ezETH",
        "aTokenSymbol": "aArbezETH",
        "aTokenUnderlyingBalance": "30000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 17,
        "interestRateStrategy": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
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
        "oracle": "0x8Ed37B72300683c0482A595bfa80fFb793874b15",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ezETH / ETH / USD",
        "oracleLatestAnswer": "378798660028",
        "reserveFactor": 1500,
        "supplyCap": 1750,
        "symbol": "ezETH",
        "underlying": "0x2416092f143378750bb29b79eD961ab195CcEea5",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x1fFD28689DA7d0148ff0fCB669e9f9f0Fc13a219",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt ezETH",
        "variableDebtTokenSymbol": "variableDebtArbezETH",
        "virtualAccountingActive": true,
        "virtualBalance": "30000000000000000"
      }
    }
  },
  "strategies": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "from": null,
      "to": {
        "address": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
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