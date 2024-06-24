## Reserve changes

### Reserves added

#### GHO ([0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33](https://arbiscan.io/address/0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,000,000 GHO |
| borrowCap | 900,000 GHO |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xB05984aD83C20b3ADE7bf97a9a0Cb539DDE28DBb](https://arbiscan.io/address/0xB05984aD83C20b3ADE7bf97a9a0Cb539DDE28DBb) |
| oracleDecimals | 8 |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | false |
| ltv | 0 % |
| liquidationThreshold | 0 % |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % |
| reserveFactor | 10 % |
| aToken | [0xeBe517846d0F36eCEd99C735cbF6131e1fEB775D](https://arbiscan.io/address/0xeBe517846d0F36eCEd99C735cbF6131e1fEB775D) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0x18248226C16BF76c032817854E7C83a2113B4f06](https://arbiscan.io/address/0x18248226C16BF76c032817854E7C83a2113B4f06) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtToken | [0x687871030477bf974725232F764aa04318A8b9c8](https://arbiscan.io/address/0x687871030477bf974725232F764aa04318A8b9c8) |
| stableDebtTokenImpl | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x36d32fD7a72AD600be60Ccb71D3718E455025CaA](https://arbiscan.io/address/0x36d32fD7a72AD600be60Ccb71D3718E455025CaA) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Arbitrum GHO |
| aTokenSymbol | aArbGHO |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt GHO |
| stableDebtTokenSymbol | stableDebtArbGHO |
| variableDebtTokenName | Aave Arbitrum Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtArbGHO |
| optimalUsageRatio | 90 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 10 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 12 % |
| variableRateSlope2 | 65 % |
| baseStableBorrowRate | 12 % |
| stableRateSlope1 | 0 % |
| stableRateSlope2 | 0 % |
| interestRate | ![ir](/.assets/014904fabcaa28d579bed688e1e3c35928c86f7c.svg) |


## Raw diff

```json
{
  "reserves": {
    "0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33": {
      "from": null,
      "to": {
        "aToken": "0xeBe517846d0F36eCEd99C735cbF6131e1fEB775D",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum GHO",
        "aTokenSymbol": "aArbGHO",
        "borrowCap": 900000,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x36d32fD7a72AD600be60Ccb71D3718E455025CaA",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 0,
        "oracle": "0xB05984aD83C20b3ADE7bf97a9a0Cb539DDE28DBb",
        "oracleDecimals": 8,
        "oracleLatestAnswer": 100000000,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x687871030477bf974725232F764aa04318A8b9c8",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt GHO",
        "stableDebtTokenSymbol": "stableDebtArbGHO",
        "supplyCap": 1000000,
        "symbol": "GHO",
        "underlying": "0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33",
        "usageAsCollateralEnabled": false,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x18248226C16BF76c032817854E7C83a2113B4f06",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtArbGHO"
      }
    }
  },
  "strategies": {
    "0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33": {
      "from": null,
      "to": {
        "address": "0x36d32fD7a72AD600be60Ccb71D3718E455025CaA",
        "baseStableBorrowRate": "120000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": "120000000000000000000000000",
        "variableRateSlope2": "650000000000000000000000000"
      }
    }
  }
}
```