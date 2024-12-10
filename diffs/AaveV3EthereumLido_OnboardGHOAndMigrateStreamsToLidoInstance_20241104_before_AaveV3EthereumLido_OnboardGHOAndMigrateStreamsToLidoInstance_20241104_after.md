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
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
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
| aTokenUnderlyingBalance | 3,000,000 GHO [3000000000000000000000000] |
| id | 6 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtEthLidoGHO |
| virtualAccountingActive | true |
| virtualBalance | 3,000,000 GHO [3000000000000000000000000] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 63.5 % |
| baseVariableBorrowRate | 10.5 % |
| variableRateSlope1 | 3 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=30000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=105000000000000000000000000&maxVariableBorrowRate=635000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: LRT Stablecoins main(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT Stablecoins main | LRT Stablecoins main |
| eMode.ltv (unchanged) | 75 % | 75 % |
| eMode.liquidationThreshold (unchanged) | 78 % | 78 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap | USDS | USDS, USDC, GHO |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | sUSDe Stablecoins | sUSDe Stablecoins |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 92 % | 92 % |
| eMode.liquidationBonus (unchanged) | 3 % | 3 % |
| eMode.borrowableBitmap | USDS, USDC | USDS, USDC, GHO |
| eMode.collateralBitmap (unchanged) | sUSDe | sUSDe |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "borrowableBitmap": {
        "from": "4",
        "to": "76"
      }
    },
    "4": {
      "borrowableBitmap": {
        "from": "12",
        "to": "76"
      }
    }
  },
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "aToken": "0x18eFE565A5373f430e2F809b97De30335B3ad96A",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido GHO",
        "aTokenSymbol": "aEthLidoGHO",
        "aTokenUnderlyingBalance": "3000000000000000000000000",
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
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0xD110cac5d8682A3b045D5524a9903E031d70FCCd",
        "oracleDecimals": 8,
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 1000,
        "supplyCap": 20000000,
        "symbol": "GHO",
        "underlying": "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x18577F0f4A0B2Ee6F4048dB51c7acd8699F97DB8",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtEthLidoGHO",
        "virtualAccountingActive": true,
        "virtualBalance": "3000000000000000000000000"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "105000000000000000000000000",
        "maxVariableBorrowRate": "635000000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "30000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  }
}
```