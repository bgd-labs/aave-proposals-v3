## Reserve changes

### Reserves added

#### crvUSD ([0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E](https://etherscan.io/address/0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 60,000,000 crvUSD |
| borrowCap | 50,000,000 crvUSD |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xEEf0C605546958c1f899b6fB336C20671f9cD49F](https://etherscan.io/address/0xEEf0C605546958c1f899b6fB336C20671f9cD49F) |
| oracleDecimals | 8 |
| oracleDescription | CRVUSD / USD |
| oracleLatestAnswer | 0.99867336 |
| usageAsCollateralEnabled | false |
| ltv | 0 % |
| liquidationThreshold | 0 % |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % |
| reserveFactor | 10 % |
| aToken | [0x82F9c5ad306BBa1AD0De49bB5FA6F01bf61085ef](https://etherscan.io/address/0x82F9c5ad306BBa1AD0De49bB5FA6F01bf61085ef) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x68e9f0aD4e6f8F5DB70F6923d4d6d5b225B83b16](https://etherscan.io/address/0x68e9f0aD4e6f8F5DB70F6923d4d6d5b225B83b16) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x61dFd349140C239d3B61fEe203Efc811b518a317](https://etherscan.io/address/0x61dFd349140C239d3B61fEe203Efc811b518a317) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://etherscan.io/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) |
| aTokenName | Aave Ethereum crvUSD |
| aTokenSymbol | aEthcrvUSD |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt crvUSD |
| stableDebtTokenSymbol | stableDebtEthcrvUSD |
| variableDebtTokenName | Aave Ethereum Variable Debt crvUSD |
| variableDebtTokenSymbol | variableDebtEthcrvUSD |
| optimalUsageRatio | 80 % |
| maxExcessUsageRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5 % |
| variableRateSlope2 | 80 % |
| baseStableBorrowRate | 8 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/ee0b6581b78f686087dd5f50440a7a76f4dd607d.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E": {
      "from": null,
      "to": {
        "aToken": "0x82F9c5ad306BBa1AD0De49bB5FA6F01bf61085ef",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum crvUSD",
        "aTokenSymbol": "aEthcrvUSD",
        "borrowCap": 50000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0xEEf0C605546958c1f899b6fB336C20671f9cD49F",
        "oracleDecimals": 8,
        "oracleDescription": "CRVUSD / USD",
        "oracleLatestAnswer": 99867336,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x61dFd349140C239d3B61fEe203Efc811b518a317",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt crvUSD",
        "stableDebtTokenSymbol": "stableDebtEthcrvUSD",
        "supplyCap": 60000000,
        "symbol": "crvUSD",
        "underlying": "0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x68e9f0aD4e6f8F5DB70F6923d4d6d5b225B83b16",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt crvUSD",
        "variableDebtTokenSymbol": "variableDebtEthcrvUSD"
      }
    }
  },
  "strategies": {
    "0x53b13a6D43F647D788411Abfd28D229C274AfBF9": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "130000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```