## Reserve changes

### Reserves added

#### ETHx ([0xA35b1B31Ce002FBF2058D22F30f95D405200A15b](https://etherscan.io/address/0xA35b1B31Ce002FBF2058D22F30f95D405200A15b))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 3,200 ETHx |
| borrowCap | 320 ETHx |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0xD6270dAabFe4862306190298C2B48fed9e15C847](https://etherscan.io/address/0xD6270dAabFe4862306190298C2B48fed9e15C847) |
| oracleDecimals | 8 |
| oracleDescription | Capped ethX / ETH / USD |
| oracleLatestAnswer | 3913.42547237 |
| usageAsCollateralEnabled | true |
| ltv | 74.5 % |
| liquidationThreshold | 77 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x4F5923Fc5FD4a93352581b38B7cD26943012DECF](https://etherscan.io/address/0x4F5923Fc5FD4a93352581b38B7cD26943012DECF) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x015396E1F286289aE23a762088E863b3ec465145](https://etherscan.io/address/0x015396E1F286289aE23a762088E863b3ec465145) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38](https://etherscan.io/address/0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x48AF11111764E710fcDcE2750db848C63edab57B](https://etherscan.io/address/0x48AF11111764E710fcDcE2750db848C63edab57B) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Ethereum ETHx |
| aTokenSymbol | aEthETHx |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt ETHx |
| stableDebtTokenSymbol | stableDebtEthETHx |
| variableDebtTokenName | Aave Ethereum Variable Debt ETHx |
| variableDebtTokenSymbol | variableDebtEthETHx |
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
    "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b": {
      "from": null,
      "to": {
        "aToken": "0x4F5923Fc5FD4a93352581b38B7cD26943012DECF",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum ETHx",
        "aTokenSymbol": "aEthETHx",
        "borrowCap": 320,
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
        "liquidationThreshold": 7700,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7450,
        "oracle": "0xD6270dAabFe4862306190298C2B48fed9e15C847",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ethX / ETH / USD",
        "oracleLatestAnswer": 391342547237,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt ETHx",
        "stableDebtTokenSymbol": "stableDebtEthETHx",
        "supplyCap": 3200,
        "symbol": "ETHx",
        "underlying": "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x015396E1F286289aE23a762088E863b3ec465145",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt ETHx",
        "variableDebtTokenSymbol": "variableDebtEthETHx"
      }
    }
  },
  "strategies": {
    "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b": {
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