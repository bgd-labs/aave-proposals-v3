## Reserve changes

### Reserves added

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 USDS |
| borrowCap | 45,000,000 USDS |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6](https://etherscan.io/address/0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDS <-> DAI / USD |
| oracleLatestAnswer | 1.00018761 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259](https://etherscan.io/address/0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x490E0E6255bF65b43E2e02F7acB783c5e04572Ff](https://etherscan.io/address/0x490E0E6255bF65b43E2e02F7acB783c5e04572Ff) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x21A7BD33410cb836d99efEA1f1bFE72E3094024b](https://etherscan.io/address/0x21A7BD33410cb836d99efEA1f1bFE72E3094024b) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x847A3364Cc5fE389283bD821cfC8A477288D9e82](https://etherscan.io/address/0x847A3364Cc5fE389283bD821cfC8A477288D9e82) |
| aTokenName | Aave Ethereum USDS |
| aTokenSymbol | aEthUSDS |
| aTokenUnderlyingBalance | 100 USDS [100000000000000000000] |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt USDS |
| stableDebtTokenSymbol | stableDebtEthUSDS |
| variableDebtTokenName | Aave Ethereum Variable Debt USDS |
| variableDebtTokenSymbol | variableDebtEthUSDS |
| virtualAccountingActive | true |
| virtualBalance | 100 USDS [100000000000000000000] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 82 % |
| baseVariableBorrowRate | 0.75 % |
| variableRateSlope1 | 6.25 % |
| variableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/c7f91df975a2dc274025eef9f1b7dc6c2befedf8.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "from": null,
      "to": {
        "aToken": "0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum USDS",
        "aTokenSymbol": "aEthUSDS",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 45000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
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
        "ltv": 7500,
        "oracle": "0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDS <-> DAI / USD",
        "oracleLatestAnswer": 100018761,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x21A7BD33410cb836d99efEA1f1bFE72E3094024b",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt USDS",
        "stableDebtTokenSymbol": "stableDebtEthUSDS",
        "supplyCap": 50000000,
        "symbol": "USDS",
        "underlying": "0xdC035D45d973E3EC169d2276DDab16f1e407384F",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x490E0E6255bF65b43E2e02F7acB783c5e04572Ff",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt USDS",
        "variableDebtTokenSymbol": "variableDebtEthUSDS",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "from": null,
      "to": {
        "address": "0x847A3364Cc5fE389283bD821cfC8A477288D9e82",
        "baseVariableBorrowRate": "7500000000000000000000000",
        "maxVariableBorrowRate": "820000000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "62500000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```