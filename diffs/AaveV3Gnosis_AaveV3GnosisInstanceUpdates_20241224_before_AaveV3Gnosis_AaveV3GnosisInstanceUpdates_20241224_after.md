## Reserve changes

### Reserves added

#### osGNO ([0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0](https://gnosisscan.io/address/0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 4,750 osGNO |
| borrowCap | 1 osGNO |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | false |
| oracle | [0x22441d81416430A54336aB28765abd31a792Ad37](https://gnosisscan.io/address/0x22441d81416430A54336aB28765abd31a792Ad37) |
| oracleDecimals | 8 |
| oracleDescription | GNO / USD |
| oracleLatestAnswer | 280.77832643 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0x3FdCeC11B4f15C79d483Aedc56F37D302837Cf4d](https://gnosisscan.io/address/0x3FdCeC11B4f15C79d483Aedc56F37D302837Cf4d) |
| aTokenImpl | [0x589750BA8aF186cE5B55391B0b7148cAD43a1619](https://gnosisscan.io/address/0x589750BA8aF186cE5B55391B0b7148cAD43a1619) |
| variableDebtToken | [0x2766EEFE0311Bf7421cC30155b03d210BCE30dF8](https://gnosisscan.io/address/0x2766EEFE0311Bf7421cC30155b03d210BCE30dF8) |
| variableDebtTokenImpl | [0xBeC519531F0E78BcDdB295242fA4EC5251B38574](https://gnosisscan.io/address/0xBeC519531F0E78BcDdB295242fA4EC5251B38574) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x4cE496f0a390745102540faF041EF92FfD588b44](https://gnosisscan.io/address/0x4cE496f0a390745102540faF041EF92FfD588b44) |
| aTokenName | Aave Gnosis osGNO |
| aTokenSymbol | aGnoosGNO |
| aTokenUnderlyingBalance | 0 osGNO [0] |
| id | 8 |
| isPaused | false |
| variableDebtTokenName | Aave Gnosis Variable Debt osGNO |
| variableDebtTokenSymbol | variableDebtGnoosGNO |
| virtualAccountingActive | true |
| virtualBalance | 0 osGNO [0] |
| optimalUsageRatio | 50 % |
| maxVariableBorrowRate | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 0 % |
| variableRateSlope2 | 0 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=0&optimalUsageRatio=500000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=0) |


### Reserve altered

#### GNO ([0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb](https://gnosisscan.io/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 2,000,000 $ [200000000] | 0 $ [0] |


#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 10 % [1000] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: osGNO / GNO(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | osGNO / GNO |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92.5 % |
| eMode.liquidationBonus | - | 2.5 % |
| eMode.borrowableBitmap | - | GNO |
| eMode.collateralBitmap | - | osGNO |


### EMode: sDAI / EURe(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sDAI / EURe |
| eMode.ltv | - | 85 % |
| eMode.liquidationThreshold | - | 87.5 % |
| eMode.liquidationBonus | - | 5 % |
| eMode.borrowableBitmap | - | EURe |
| eMode.collateralBitmap | - | sDAI |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "256",
        "eModeCategory": 2,
        "label": "osGNO / GNO",
        "liquidationBonus": 10250,
        "liquidationThreshold": 9250,
        "ltv": 9000
      }
    },
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "32",
        "collateralBitmap": "64",
        "eModeCategory": 3,
        "label": "sDAI / EURe",
        "liquidationBonus": 10500,
        "liquidationThreshold": 8750,
        "ltv": 8500
      }
    }
  },
  "reserves": {
    "0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb": {
      "debtCeiling": {
        "from": 200000000,
        "to": 0
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "reserveFactor": {
        "from": 2000,
        "to": 1000
      }
    },
    "0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0": {
      "from": null,
      "to": {
        "aToken": "0x3FdCeC11B4f15C79d483Aedc56F37D302837Cf4d",
        "aTokenImpl": "0x589750BA8aF186cE5B55391B0b7148cAD43a1619",
        "aTokenName": "Aave Gnosis osGNO",
        "aTokenSymbol": "aGnoosGNO",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 8,
        "interestRateStrategy": "0x4cE496f0a390745102540faF041EF92FfD588b44",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0x22441d81416430A54336aB28765abd31a792Ad37",
        "oracleDecimals": 8,
        "oracleDescription": "GNO / USD",
        "oracleLatestAnswer": "28077832643",
        "reserveFactor": 1000,
        "supplyCap": 4750,
        "symbol": "osGNO",
        "underlying": "0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x2766EEFE0311Bf7421cC30155b03d210BCE30dF8",
        "variableDebtTokenImpl": "0xBeC519531F0E78BcDdB295242fA4EC5251B38574",
        "variableDebtTokenName": "Aave Gnosis Variable Debt osGNO",
        "variableDebtTokenSymbol": "variableDebtGnoosGNO",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0": {
      "from": null,
      "to": {
        "address": "0x4cE496f0a390745102540faF041EF92FfD588b44",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "0",
        "optimalUsageRatio": "500000000000000000000000000",
        "variableRateSlope1": "0",
        "variableRateSlope2": "0"
      }
    }
  }
}
```