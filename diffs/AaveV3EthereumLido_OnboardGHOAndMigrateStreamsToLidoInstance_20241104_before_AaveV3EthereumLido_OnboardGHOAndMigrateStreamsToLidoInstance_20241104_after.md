## Reserve changes

### Reserves added

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 20,000,000 GHO |
| borrowCap | 2,500,000 GHO |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xD110cac5d8682A3b045D5524a9903E031d70FCCd](https://etherscan.io/address/0xD110cac5d8682A3b045D5524a9903E031d70FCCd) |
| oracleDecimals | 8 |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0x18eFE565A5373f430e2F809b97De30335B3ad96A](https://etherscan.io/address/0x18eFE565A5373f430e2F809b97De30335B3ad96A) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8](https://etherscan.io/address/0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido GHO |
| aTokenSymbol | aEthLidoGHO |
| aTokenUnderlyingBalance | 1,000 GHO [1000000000000000000000] |
| id | 6 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtEthLidoGHO |
| virtualAccountingActive | true |
| virtualBalance | 1,000 GHO [1000000000000000000000] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 59.5 % |
| baseVariableBorrowRate | 6.5 % |
| variableRateSlope1 | 3 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=30000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=65000000000000000000000000&maxVariableBorrowRate=595000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "aToken": "0x18eFE565A5373f430e2F809b97De30335B3ad96A",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido GHO",
        "aTokenSymbol": "aEthLidoGHO",
        "aTokenUnderlyingBalance": "1000000000000000000000",
        "borrowCap": 2500000,
        "borrowingEnabled": true,
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
        "liquidationThreshold": 7800,
        "ltv": 7500,
        "oracle": "0xD110cac5d8682A3b045D5524a9903E031d70FCCd",
        "oracleDecimals": 8,
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 1000,
        "supplyCap": 20000000,
        "symbol": "GHO",
        "underlying": "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtEthLidoGHO",
        "virtualAccountingActive": true,
        "virtualBalance": "1000000000000000000000"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "65000000000000000000000000",
        "maxVariableBorrowRate": "595000000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "30000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  }
}
```