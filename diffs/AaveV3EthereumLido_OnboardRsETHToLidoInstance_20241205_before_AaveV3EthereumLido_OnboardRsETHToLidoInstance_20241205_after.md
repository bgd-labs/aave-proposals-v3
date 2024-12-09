## Reserve changes

### Reserves added

#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 10,000 rsETH |
| borrowCap | 1 rsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x47F52B2e43D0386cF161e001835b03Ad49889e3b](https://etherscan.io/address/0x47F52B2e43D0386cF161e001835b03Ad49889e3b) |
| oracleDecimals | 8 |
| oracleDescription | Capped rsETH / ETH / USD |
| oracleLatestAnswer | 4023.47907549 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 0.15 % [15] |
| aToken | [0x18eFE565A5373f430e2F809b97De30335B3ad96A](https://etherscan.io/address/0x18eFE565A5373f430e2F809b97De30335B3ad96A) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8](https://etherscan.io/address/0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido rsETH |
| aTokenSymbol | aEthLidorsETH |
| aTokenUnderlyingBalance | 0.03 rsETH [30000000000000000] |
| id | 6 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt rsETH |
| variableDebtTokenSymbol | variableDebtEthLidorsETH |
| virtualAccountingActive | true |
| virtualBalance | 0.03 rsETH [30000000000000000] |
| optimalUsageRatio | 1 % |
| maxVariableBorrowRate | 110 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 100 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=1000000000000000000000000000&optimalUsageRatio=10000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=1100000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH LST main |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | rsETH |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "64",
        "eModeCategory": 5,
        "label": "rsETH LST main",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "from": null,
      "to": {
        "aToken": "0x18eFE565A5373f430e2F809b97De30335B3ad96A",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido rsETH",
        "aTokenSymbol": "aEthLidorsETH",
        "aTokenUnderlyingBalance": "30000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 6,
        "interestRateStrategy": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
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
        "oracle": "0x47F52B2e43D0386cF161e001835b03Ad49889e3b",
        "oracleDecimals": 8,
        "oracleDescription": "Capped rsETH / ETH / USD",
        "oracleLatestAnswer": "402347907549",
        "reserveFactor": 15,
        "supplyCap": 10000,
        "symbol": "rsETH",
        "underlying": "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt rsETH",
        "variableDebtTokenSymbol": "variableDebtEthLidorsETH",
        "virtualAccountingActive": true,
        "virtualBalance": "30000000000000000"
      }
    }
  },
  "strategies": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "1100000000000000000000000000",
        "optimalUsageRatio": "10000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    }
  }
}
```