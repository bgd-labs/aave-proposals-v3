## Reserve changes

### Reserves added

#### FBTC ([0xC96dE26018A54D51c097160568752c4E3BD6C364](https://etherscan.io/address/0xC96dE26018A54D51c097160568752c4E3BD6C364))

| description | value |
| --- | --- |
| decimals | 8 |
| isActive | true |
| isFrozen | false |
| supplyCap | 200 FBTC |
| borrowCap | 100 FBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 100316.18 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 50 % [5000] |
| aToken | [0x65906988ADEe75306021C417a1A3458040239602](https://etherscan.io/address/0x65906988ADEe75306021C417a1A3458040239602) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD](https://etherscan.io/address/0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum FBTC |
| aTokenSymbol | aEthFBTC |
| aTokenUnderlyingBalance | 0 FBTC [0] |
| id | 37 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt FBTC |
| variableDebtTokenSymbol | variableDebtEthFBTC |
| virtualAccountingActive | true |
| virtualBalance | 0 FBTC [0] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0xC96dE26018A54D51c097160568752c4E3BD6C364": {
      "from": null,
      "to": {
        "aToken": "0x65906988ADEe75306021C417a1A3458040239602",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum FBTC",
        "aTokenSymbol": "aEthFBTC",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 100,
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
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7300,
        "oracle": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": "10031618000000",
        "reserveFactor": 5000,
        "supplyCap": 200,
        "symbol": "FBTC",
        "underlying": "0xC96dE26018A54D51c097160568752c4E3BD6C364",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x68aeB290C7727D899B47c56d1c96AEAC475cD0dD",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt FBTC",
        "variableDebtTokenSymbol": "variableDebtEthFBTC",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xC96dE26018A54D51c097160568752c4E3BD6C364": {
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