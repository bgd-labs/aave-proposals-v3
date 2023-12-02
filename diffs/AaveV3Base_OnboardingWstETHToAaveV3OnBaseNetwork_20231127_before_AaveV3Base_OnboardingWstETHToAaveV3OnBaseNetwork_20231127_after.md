## Reserve changes

### Reserves added

#### wstETH ([0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452](https://basescan.org/address/0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 4,000 wstETH |
| borrowCap | 400 wstETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0x945fD405773973d286De54E44649cc0d9e264F78](https://basescan.org/address/0x945fD405773973d286De54E44649cc0d9e264F78) |
| oracleDecimals | 8 |
| oracleDescription | wstETH/ETH/USD |
| oracleLatestAnswer | 2416.61188866 |
| usageAsCollateralEnabled | true |
| ltv | 71 % |
| liquidationThreshold | 76 % |
| liquidationBonus | 6 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D](https://basescan.org/address/0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D) |
| aTokenImpl | [0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69](https://basescan.org/address/0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69) |
| variableDebtToken | [0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1](https://basescan.org/address/0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1) |
| variableDebtTokenImpl | [0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1](https://basescan.org/address/0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1) |
| stableDebtToken | [0xfe742Fa2a84294E8316F05b17c05090Fc68B5105](https://basescan.org/address/0xfe742Fa2a84294E8316F05b17c05090Fc68B5105) |
| stableDebtTokenImpl | [0xe0b9B4f959fa8B52B7228c8D78875482b8813349](https://basescan.org/address/0xe0b9B4f959fa8B52B7228c8D78875482b8813349) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9](https://basescan.org/address/0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9) |
| aTokenName | Aave Base wstETH |
| aTokenSymbol | aBaswstETH |
| isPaused | false |
| stableDebtTokenName | Aave Base Stable Debt wstETH |
| stableDebtTokenSymbol | stableDebtBaswstETH |
| variableDebtTokenName | Aave Base Variable Debt wstETH |
| variableDebtTokenSymbol | variableDebtBaswstETH |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 10 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/eda3aded0333ece535adb2c0df7f1b16add284a2.svg) |
| eMode.label | ETH correlated |
| eMode.ltv | 90 % |
| eMode.liquidationThreshold | 93 % |
| eMode.liquidationBonus | 2 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452": {
      "from": null,
      "to": {
        "aToken": "0x99CBC45ea5bb7eF3a5BC08FB1B7E56bB2442Ef0D",
        "aTokenImpl": "0x98F409Fc4A42F34AE3c326c7f48ED01ae8cAeC69",
        "aTokenName": "Aave Base wstETH",
        "aTokenSymbol": "aBaswstETH",
        "borrowCap": 400,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 1,
        "interestRateStrategy": "0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10600,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7600,
        "ltv": 7100,
        "oracle": "0x945fD405773973d286De54E44649cc0d9e264F78",
        "oracleDecimals": 8,
        "oracleDescription": "wstETH/ETH/USD",
        "oracleLatestAnswer": 241661188866,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xfe742Fa2a84294E8316F05b17c05090Fc68B5105",
        "stableDebtTokenImpl": "0xe0b9B4f959fa8B52B7228c8D78875482b8813349",
        "stableDebtTokenName": "Aave Base Stable Debt wstETH",
        "stableDebtTokenSymbol": "stableDebtBaswstETH",
        "supplyCap": 4000,
        "symbol": "wstETH",
        "underlying": "0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x41A7C3f5904ad176dACbb1D99101F59ef0811DC1",
        "variableDebtTokenImpl": "0x2425A746911128c2eAA7bEBDc9Bc452eE52208a1",
        "variableDebtTokenName": "Aave Base Variable Debt wstETH",
        "variableDebtTokenSymbol": "variableDebtBaswstETH"
      }
    }
  },
  "strategies": {
    "0x2f51b00eC4912874DFDBd8dC3C8e390c21e77aF9": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "100000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "130000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```