## Reserve changes

### Reserves added

#### ETHx ([0xA35b1B31Ce002FBF2058D22F30f95D405200A15b](https://etherscan.io/address/0xA35b1B31Ce002FBF2058D22F30f95D405200A15b))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 10,000 ETHx |
| borrowCap | 1,000 ETHx |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xED65C5085a18Fa160Af0313E60dcc7905E944Dc7](https://etherscan.io/address/0xED65C5085a18Fa160Af0313E60dcc7905E944Dc7) |
| oracleName | ETHx/ETH/USD |
| oracleLatestAnswer | 226,378,637,010 |
| usageAsCollateralEnabled | true |
| ltv | 74.5 % |
| liquidationThreshold | 77 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x0C0d01AbF3e6aDfcA0989eBbA9d6e85dD58EaB1E](https://etherscan.io/address/0x0C0d01AbF3e6aDfcA0989eBbA9d6e85dD58EaB1E) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x57B67e4DE077085Fd0AF2174e9c14871BE664546](https://etherscan.io/address/0x57B67e4DE077085Fd0AF2174e9c14871BE664546) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x5B393DB4c72B1Bd82CE2834F6485d61b137Bc7aC](https://etherscan.io/address/0x5B393DB4c72B1Bd82CE2834F6485d61b137Bc7aC) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | false |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://etherscan.io/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| aTokenName | Aave Ethereum ETHx |
| aTokenSymbol | aEthETHx |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt ETHx |
| stableDebtTokenSymbol | stableDebtEthETHx |
| variableDebtTokenName | Aave Ethereum Variable Debt ETHx |
| variableDebtTokenSymbol | variableDebtEthETHx |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 8 % |
| stableRateSlope1 | 7 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/11fa722c8174e6a8b33a6ba1b49f3d0138f692a3.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b": {
      "from": null,
      "to": {
        "aToken": "0x0C0d01AbF3e6aDfcA0989eBbA9d6e85dD58EaB1E",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum ETHx",
        "aTokenSymbol": "aEthETHx",
        "borrowCap": 1000,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7700,
        "ltv": 7450,
        "oracle": "0xED65C5085a18Fa160Af0313E60dcc7905E944Dc7",
        "oracleLatestAnswer": 226378637010,
        "oracleName": "ETHx/ETH/USD",
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x5B393DB4c72B1Bd82CE2834F6485d61b137Bc7aC",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt ETHx",
        "stableDebtTokenSymbol": "stableDebtEthETHx",
        "supplyCap": 10000,
        "symbol": "ETHx",
        "underlying": "0xA35b1B31Ce002FBF2058D22F30f95D405200A15b",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x57B67e4DE077085Fd0AF2174e9c14871BE664546",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt ETHx",
        "variableDebtTokenSymbol": "variableDebtEthETHx"
      }
    }
  },
  "strategies": {
    "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```