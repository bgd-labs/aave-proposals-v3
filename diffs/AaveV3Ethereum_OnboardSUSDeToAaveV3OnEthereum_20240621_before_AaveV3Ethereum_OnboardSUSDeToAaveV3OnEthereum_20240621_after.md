## Reserve changes

### Reserves added

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 85,000,000 sUSDe |
| borrowCap | 0 sUSDe |
| debtCeiling | 40,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A](https://etherscan.io/address/0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A) |
| oracleDecimals | 8 |
| oracleDescription | Capped sUSDe / USDe / USD |
| oracleLatestAnswer | 1.08292481 |
| usageAsCollateralEnabled | true |
| ltv | 72 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 8.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x4579a27aF00A62C0EB156349f31B345c08386419](https://etherscan.io/address/0x4579a27aF00A62C0EB156349f31B345c08386419) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0xeFFDE9BFA8EC77c14C364055a200746d6e12BeD6](https://etherscan.io/address/0xeFFDE9BFA8EC77c14C364055a200746d6e12BeD6) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0xc9335dE638f4C96a8330b2FFc44353Bab58774e3](https://etherscan.io/address/0xc9335dE638f4C96a8330b2FFc44353Bab58774e3) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | false |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x42ec99A020B78C449d17d93bC4c89e0189B5811d](https://etherscan.io/address/0x42ec99A020B78C449d17d93bC4c89e0189B5811d) |
| liquidityIndex | 1 |
| variableBorrowIndex | 1 |
| aTokenName | Aave Ethereum sUSDe |
| aTokenSymbol | aEthsUSDe |
| currentLiquidityRate | 0 % |
| currentVariableBorrowRate | 0 % |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt sUSDe |
| stableDebtTokenSymbol | stableDebtEthsUSDe |
| variableDebtTokenName | Aave Ethereum Variable Debt sUSDe |
| variableDebtTokenSymbol | variableDebtEthsUSDe |
| optimalUsageRatio | 90 % |
| maxExcessStableToTotalDebtRatio | 100 % |
| maxExcessUsageRatio | 10 % |
| optimalStableToTotalDebtRatio | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 0 % |
| variableRateSlope2 | 0 % |
| baseStableBorrowRate | 0 % |
| stableRateSlope1 | 0 % |
| stableRateSlope2 | 0 % |
| interestRate | ![ir](/.assets/a3461acfe57a779335e63f45d89078bcde2c101b.svg) |


## Raw diff

```json
{
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "from": null,
      "to": {
        "aToken": "0x4579a27aF00A62C0EB156349f31B345c08386419",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum sUSDe",
        "aTokenSymbol": "aEthsUSDe",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "currentLiquidityRate": 0,
        "currentVariableBorrowRate": 0,
        "debtCeiling": 4000000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10850,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "liquidityIndex": "1000000000000000000000000000",
        "ltv": 7200,
        "oracle": "0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A",
        "oracleDecimals": 8,
        "oracleDescription": "Capped sUSDe / USDe / USD",
        "oracleLatestAnswer": 108292481,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xc9335dE638f4C96a8330b2FFc44353Bab58774e3",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt sUSDe",
        "stableDebtTokenSymbol": "stableDebtEthsUSDe",
        "supplyCap": 85000000,
        "symbol": "sUSDe",
        "underlying": "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497",
        "usageAsCollateralEnabled": true,
        "variableBorrowIndex": "1000000000000000000000000000",
        "variableDebtToken": "0xeFFDE9BFA8EC77c14C364055a200746d6e12BeD6",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt sUSDe",
        "variableDebtTokenSymbol": "variableDebtEthsUSDe"
      }
    }
  },
  "strategies": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "from": null,
      "to": {
        "address": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d",
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": 0,
        "variableRateSlope2": 0
      }
    }
  }
}
```