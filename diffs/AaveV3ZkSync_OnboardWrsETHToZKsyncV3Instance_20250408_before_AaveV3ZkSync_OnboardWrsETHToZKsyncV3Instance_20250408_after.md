## Reserve changes

### Reserves added

#### wrsETH ([0xd4169E045bcF9a86cC00101225d9ED61D2F51af2](https://era.zksync.network//address/0xd4169E045bcF9a86cC00101225d9ED61D2F51af2))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 700 wrsETH |
| borrowCap | 1 wrsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555](https://era.zksync.network//address/0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555) |
| oracleDecimals | 8 |
| oracleDescription | Capped rsETH / ETH / USD |
| oracleLatestAnswer | 1635.85069951 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0x5722921bb6C37EaEb78b993765Aa5D79CC50052F](https://era.zksync.network//address/0x5722921bb6C37EaEb78b993765Aa5D79CC50052F) |
| aTokenImpl | [0x34be365Fd01ac224F21490aaC6dFd65D25434bbB](https://era.zksync.network//address/0x34be365Fd01ac224F21490aaC6dFd65D25434bbB) |
| variableDebtToken | [0x97deC07366Be72884331BE21704Fd93BF35286f9](https://era.zksync.network//address/0x97deC07366Be72884331BE21704Fd93BF35286f9) |
| variableDebtTokenImpl | [0x52E97425D1Fa6885fAaC9260B711fA5047A88d06](https://era.zksync.network//address/0x52E97425D1Fa6885fAaC9260B711fA5047A88d06) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x57815Ab06D846d7dECd326Ee541CD06144FED237](https://era.zksync.network//address/0x57815Ab06D846d7dECd326Ee541CD06144FED237) |
| aTokenName | Aave ZkSync wrsETH |
| aTokenSymbol | aZkswrsETH |
| aTokenUnderlyingBalance | 0.035 wrsETH [35000000000000000] |
| id | 7 |
| isPaused | false |
| variableDebtTokenName | Aave ZkSync Variable Debt wrsETH |
| variableDebtTokenSymbol | variableDebtZkswrsETH |
| virtualAccountingActive | true |
| virtualBalance | 0.035 wrsETH [35000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: weETH correlated(id: 2)



### EMode: wrsETH/wstETH(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wrsETH/wstETH |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | wrsETH |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "8",
        "collateralBitmap": "128",
        "eModeCategory": 3,
        "label": "wrsETH/wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0xd4169E045bcF9a86cC00101225d9ED61D2F51af2": {
      "from": null,
      "to": {
        "aToken": "0x5722921bb6C37EaEb78b993765Aa5D79CC50052F",
        "aTokenImpl": "0x34be365Fd01ac224F21490aaC6dFd65D25434bbB",
        "aTokenName": "Aave ZkSync wrsETH",
        "aTokenSymbol": "aZkswrsETH",
        "aTokenUnderlyingBalance": "35000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 7,
        "interestRateStrategy": "0x57815Ab06D846d7dECd326Ee541CD06144FED237",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555",
        "oracleDecimals": 8,
        "oracleDescription": "Capped rsETH / ETH / USD",
        "oracleLatestAnswer": "163585069951",
        "reserveFactor": 1000,
        "supplyCap": 700,
        "symbol": "wrsETH",
        "underlying": "0xd4169E045bcF9a86cC00101225d9ED61D2F51af2",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x97deC07366Be72884331BE21704Fd93BF35286f9",
        "variableDebtTokenImpl": "0x52E97425D1Fa6885fAaC9260B711fA5047A88d06",
        "variableDebtTokenName": "Aave ZkSync Variable Debt wrsETH",
        "variableDebtTokenSymbol": "variableDebtZkswrsETH",
        "virtualAccountingActive": true,
        "virtualBalance": "35000000000000000"
      }
    }
  },
  "strategies": {
    "0xd4169E045bcF9a86cC00101225d9ED61D2F51af2": {
      "from": null,
      "to": {
        "address": "0x57815Ab06D846d7dECd326Ee541CD06144FED237",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {}
}
```