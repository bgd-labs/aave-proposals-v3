## Reserve changes

### Reserves added

#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 19,000 rsETH |
| borrowCap | 1,900 rsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x47F52B2e43D0386cF161e001835b03Ad49889e3b](https://etherscan.io/address/0x47F52B2e43D0386cF161e001835b03Ad49889e3b) |
| oracleDecimals | 8 |
| oracleDescription | Capped rsETH / ETH / USD |
| oracleLatestAnswer | 2892.03476952 |
| usageAsCollateralEnabled | true |
| ltv | 72 % [7200] |
| liquidationThreshold | 75 % [7500] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0x2D62109243b87C4bA3EE7bA1D91B0dD0A074d7b1](https://etherscan.io/address/0x2D62109243b87C4bA3EE7bA1D91B0dD0A074d7b1) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x6De3E52A1B7294A34e271a508082b1Ff4a37E30e](https://etherscan.io/address/0x6De3E52A1B7294A34e271a508082b1Ff4a37E30e) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum rsETH |
| aTokenSymbol | aEthrsETH |
| aTokenUnderlyingBalance | 0.04 rsETH [40000000000000000] |
| id | 36 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt rsETH |
| variableDebtTokenSymbol | variableDebtEthrsETH |
| virtualAccountingActive | true |
| virtualBalance | 0.04 rsETH [40000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 48,000 wstETH | 60,000 wstETH |


#### ETHx ([0xA35b1B31Ce002FBF2058D22F30f95D405200A15b](https://etherscan.io/address/0xA35b1B31Ce002FBF2058D22F30f95D405200A15b))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 320 ETHx | 5,000 ETHx |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: rsETH LST main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH LST main |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH, ETHx |
| eMode.collateralBitmap | - | rsETH |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "2147483650",
        "collateralBitmap": "68719476736",
        "eModeCategory": 3,
        "label": "rsETH LST main",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowCap": {
        "from": 48000,
        "to": 60000
      }
    },
    "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b": {
      "borrowCap": {
        "from": 320,
        "to": 5000
      }
    },
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "from": null,
      "to": {
        "aToken": "0x2D62109243b87C4bA3EE7bA1D91B0dD0A074d7b1",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum rsETH",
        "aTokenSymbol": "aEthrsETH",
        "aTokenUnderlyingBalance": "40000000000000000",
        "borrowCap": 1900,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 36,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "ltv": 7200,
        "oracle": "0x47F52B2e43D0386cF161e001835b03Ad49889e3b",
        "oracleDecimals": 8,
        "oracleDescription": "Capped rsETH / ETH / USD",
        "oracleLatestAnswer": "289203476952",
        "reserveFactor": 1500,
        "supplyCap": 19000,
        "symbol": "rsETH",
        "underlying": "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x6De3E52A1B7294A34e271a508082b1Ff4a37E30e",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt rsETH",
        "variableDebtTokenSymbol": "variableDebtEthrsETH",
        "virtualAccountingActive": true,
        "virtualBalance": "40000000000000000"
      }
    }
  },
  "strategies": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
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