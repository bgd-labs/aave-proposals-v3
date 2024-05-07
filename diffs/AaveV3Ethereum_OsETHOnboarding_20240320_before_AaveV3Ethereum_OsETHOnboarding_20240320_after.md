## Reserve changes

### Reserves added

#### osETH ([0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38](https://etherscan.io/address/0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 10,000 osETH |
| borrowCap | 1,000 osETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0x0A2AF898cEc35197e6944D9E0F525C2626393442](https://etherscan.io/address/0x0A2AF898cEc35197e6944D9E0F525C2626393442) |
| oracleDecimals | 8 |
| oracleDescription | Capped osETH / ETH / USD |
| oracleLatestAnswer | 3132.90207426 |
| usageAsCollateralEnabled | true |
| ltv | 72.5 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x927709711794F3De5DdBF1D176bEE2D55Ba13c21](https://etherscan.io/address/0x927709711794F3De5DdBF1D176bEE2D55Ba13c21) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x8838eefF2af391863E1Bb8b1dF563F86743a8470](https://etherscan.io/address/0x8838eefF2af391863E1Bb8b1dF563F86743a8470) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x48Fa27f511F40d16f9E7C913e9388d52d95bC6d2](https://etherscan.io/address/0x48Fa27f511F40d16f9E7C913e9388d52d95bC6d2) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x48AF11111764E710fcDcE2750db848C63edab57B](https://etherscan.io/address/0x48AF11111764E710fcDcE2750db848C63edab57B) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Ethereum osETH |
| aTokenSymbol | aEthosETH |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt osETH |
| stableDebtTokenSymbol | stableDebtEthosETH |
| variableDebtTokenName | Aave Ethereum Variable Debt osETH |
| variableDebtTokenSymbol | variableDebtEthosETH |
| optimalUsageRatio | 45 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 55 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 7 % |
| stableRateSlope1 | 0 % |
| stableRateSlope2 | 0 % |
| interestRate | ![ir](/.assets/aa2e8a5322392ad3d4ae80453f4e281a8da627cc.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 93 % |
| eMode.liquidationThreshold | 95 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38": {
      "from": null,
      "to": {
        "aToken": "0x927709711794F3De5DdBF1D176bEE2D55Ba13c21",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum osETH",
        "aTokenSymbol": "aEthosETH",
        "borrowCap": 1000,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 1,
        "interestRateStrategy": "0x48AF11111764E710fcDcE2750db848C63edab57B",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7250,
        "oracle": "0x0A2AF898cEc35197e6944D9E0F525C2626393442",
        "oracleDecimals": 8,
        "oracleDescription": "Capped osETH / ETH / USD",
        "oracleLatestAnswer": 313290207426,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x48Fa27f511F40d16f9E7C913e9388d52d95bC6d2",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt osETH",
        "stableDebtTokenSymbol": "stableDebtEthosETH",
        "supplyCap": 10000,
        "symbol": "osETH",
        "underlying": "0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x8838eefF2af391863E1Bb8b1dF563F86743a8470",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt osETH",
        "variableDebtTokenSymbol": "variableDebtEthosETH"
      }
    }
  },
  "strategies": {
    "0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38": {
      "from": null,
      "to": {
        "address": "0x48AF11111764E710fcDcE2750db848C63edab57B",
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```