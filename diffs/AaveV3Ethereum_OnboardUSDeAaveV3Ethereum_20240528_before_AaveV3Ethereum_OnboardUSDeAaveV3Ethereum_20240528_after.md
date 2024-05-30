## Reserve changes

### Reserves added

#### USDe ([0x4c9EDD5852cd905f086C759E8383e09bff1E68B3](https://etherscan.io/address/0x4c9EDD5852cd905f086C759E8383e09bff1E68B3))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 80,000,000 USDe |
| borrowCap | 72,000,000 USDe |
| debtCeiling | 40,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17](https://etherscan.io/address/0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDe / USD |
| oracleLatestAnswer | 1.00079999 |
| usageAsCollateralEnabled | true |
| ltv | 72 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 8.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 25 % |
| aToken | [0x4F5923Fc5FD4a93352581b38B7cD26943012DECF](https://etherscan.io/address/0x4F5923Fc5FD4a93352581b38B7cD26943012DECF) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x015396E1F286289aE23a762088E863b3ec465145](https://etherscan.io/address/0x015396E1F286289aE23a762088E863b3ec465145) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38](https://etherscan.io/address/0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | true |
| interestRateStrategy | [0x4011fcd421b9E90f131B164EC1d162DBE269621C](https://etherscan.io/address/0x4011fcd421b9E90f131B164EC1d162DBE269621C) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Ethereum USDe |
| aTokenSymbol | aEthUSDe |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt USDe |
| stableDebtTokenSymbol | stableDebtEthUSDe |
| variableDebtTokenName | Aave Ethereum Variable Debt USDe |
| variableDebtTokenSymbol | variableDebtEthUSDe |
| optimalUsageRatio | 80 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 20 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9 % |
| variableRateSlope2 | 75 % |
| baseStableBorrowRate | 9 % |
| stableRateSlope1 | 9 % |
| stableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/a2ff7054b21a6d938826bbea32b5e589c6a0c8f7.svg) |


## Raw diff

```json
{
  "reserves": {
    "0x4c9EDD5852cd905f086C759E8383e09bff1E68B3": {
      "from": null,
      "to": {
        "aToken": "0x4F5923Fc5FD4a93352581b38B7cD26943012DECF",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum USDe",
        "aTokenSymbol": "aEthUSDe",
        "borrowCap": 72000000,
        "borrowingEnabled": true,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 4000000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x4011fcd421b9E90f131B164EC1d162DBE269621C",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10850,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7200,
        "oracle": "0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDe / USD",
        "oracleLatestAnswer": 100079999,
        "reserveFactor": 2500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x43Cc8AD0c223b38D9c04802bB184A2D97e497D38",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt USDe",
        "stableDebtTokenSymbol": "stableDebtEthUSDe",
        "supplyCap": 80000000,
        "symbol": "USDe",
        "underlying": "0x4c9EDD5852cd905f086C759E8383e09bff1E68B3",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0x015396E1F286289aE23a762088E863b3ec465145",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt USDe",
        "variableDebtTokenSymbol": "variableDebtEthUSDe"
      }
    }
  },
  "strategies": {
    "0x4c9EDD5852cd905f086C759E8383e09bff1E68B3": {
      "from": null,
      "to": {
        "address": "0x4011fcd421b9E90f131B164EC1d162DBE269621C",
        "baseStableBorrowRate": "90000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "90000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "90000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```