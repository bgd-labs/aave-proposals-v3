## Reserve changes

### Reserves added

#### cbBTC ([0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf](https://etherscan.io/address/0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf))

| description | value |
| --- | --- |
| decimals | 8 |
| isActive | true |
| isFrozen | false |
| supplyCap | 450 cbBTC |
| borrowCap | 45 cbBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 58704.5716675 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0x10Ac93971cdb1F5c778144084242374473c350Da](https://etherscan.io/address/0x10Ac93971cdb1F5c778144084242374473c350Da) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960](https://etherscan.io/address/0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca](https://etherscan.io/address/0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x847A3364Cc5fE389283bD821cfC8A477288D9e82](https://etherscan.io/address/0x847A3364Cc5fE389283bD821cfC8A477288D9e82) |
| aTokenName | Aave Ethereum cbBTC |
| aTokenSymbol | aEthcbBTC |
| aTokenUnderlyingBalance | 0.002 cbBTC [200000] |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt cbBTC |
| stableDebtTokenSymbol | stableDebtEthcbBTC |
| variableDebtTokenName | Aave Ethereum Variable Debt cbBTC |
| variableDebtTokenSymbol | variableDebtEthcbBTC |
| virtualAccountingActive | true |
| virtualBalance | 0.002 cbBTC [200000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/6554df8148ba17f5ffc961aea7512567c91e2a3d.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "from": null,
      "to": {
        "aToken": "0x10Ac93971cdb1F5c778144084242374473c350Da",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum cbBTC",
        "aTokenSymbol": "aEthcbBTC",
        "aTokenUnderlyingBalance": 200000,
        "borrowCap": 45,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 8,
        "eModeCategory": 0,
        "interestRateStrategy": "0x847A3364Cc5fE389283bD821cfC8A477288D9e82",
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
        "oracleLatestAnswer": 5870457166750,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xCcf8413F9cA3bAE07EEF05E265D238d60abCb8Ca",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt cbBTC",
        "stableDebtTokenSymbol": "stableDebtEthcbBTC",
        "supplyCap": 450,
        "symbol": "cbBTC",
        "underlying": "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xAC50890a80A2731eb1eA2e9B4F29569CeB06D960",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt cbBTC",
        "variableDebtTokenSymbol": "variableDebtEthcbBTC",
        "virtualAccountingActive": true,
        "virtualBalance": 200000
      }
    }
  },
  "strategies": {
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "from": null,
      "to": {
        "address": "0x847A3364Cc5fE389283bD821cfC8A477288D9e82",
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