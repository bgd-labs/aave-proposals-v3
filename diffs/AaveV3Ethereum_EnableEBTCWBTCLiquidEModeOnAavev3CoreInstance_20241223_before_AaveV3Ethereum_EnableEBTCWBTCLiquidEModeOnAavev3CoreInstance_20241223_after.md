## Reserve changes

### Reserves added

#### eBTC ([0x657e8C867D8B37dCC18fA4Caead9C45EB088C642](https://etherscan.io/address/0x657e8C867D8B37dCC18fA4Caead9C45EB088C642))

| description | value |
| --- | --- |
| decimals | 8 |
| isActive | true |
| isFrozen | false |
| supplyCap | 80 eBTC |
| borrowCap | 8 eBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 102127.88158314 |
| usageAsCollateralEnabled | true |
| ltv | 67 % [6700] |
| liquidationThreshold | 72 % [7200] |
| liquidationBonus | 10 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 50 % [5000] |
| aToken | [0x65906988ADEe75306021C417a1A3458040239602](https://etherscan.io/address/0x65906988ADEe75306021C417a1A3458040239602) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD](https://etherscan.io/address/0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum eBTC |
| aTokenSymbol | aEtheBTC |
| aTokenUnderlyingBalance | 0.001 eBTC [100000] |
| id | 37 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt eBTC |
| variableDebtTokenSymbol | variableDebtEtheBTC |
| virtualAccountingActive | true |
| virtualBalance | 0.001 eBTC [100000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: eBTC / WBTC(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | eBTC / WBTC |
| eMode.ltv | - | 83 % |
| eMode.liquidationThreshold | - | 85 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | WBTC |
| eMode.collateralBitmap | - | eBTC |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "137438953472",
        "eModeCategory": 5,
        "label": "eBTC / WBTC",
        "liquidationBonus": 10300,
        "liquidationThreshold": 8500,
        "ltv": 8300
      }
    }
  },
  "reserves": {
    "0x657e8C867D8B37dCC18fA4Caead9C45EB088C642": {
      "from": null,
      "to": {
        "aToken": "0x65906988ADEe75306021C417a1A3458040239602",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum eBTC",
        "aTokenSymbol": "aEtheBTC",
        "aTokenUnderlyingBalance": "100000",
        "borrowCap": 8,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 8,
        "id": 37,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7200,
        "ltv": 6700,
        "oracle": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": "10212788158314",
        "reserveFactor": 5000,
        "supplyCap": 80,
        "symbol": "eBTC",
        "underlying": "0x657e8C867D8B37dCC18fA4Caead9C45EB088C642",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt eBTC",
        "variableDebtTokenSymbol": "variableDebtEtheBTC",
        "virtualAccountingActive": true,
        "virtualBalance": "100000"
      }
    }
  },
  "strategies": {
    "0x657e8C867D8B37dCC18fA4Caead9C45EB088C642": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
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