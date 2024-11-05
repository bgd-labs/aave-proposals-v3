## Reserve changes

### Reserves added

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 11,000,000 GHO |
| borrowCap | 10,000,000 GHO |
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
| reserveFactor | 0.01 % [1] |
| aToken | [0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0](https://etherscan.io/address/0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a](https://etherscan.io/address/0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido GHO |
| aTokenSymbol | aEthLidoGHO |
| aTokenUnderlyingBalance | 6,760,840.6083 GHO [6760840608343987319695151] |
| id | 5 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtEthLidoGHO |
| virtualAccountingActive | true |
| virtualBalance | 6,760,840.6083 GHO [6760840608343987319695151] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 56.5 % |
| baseVariableBorrowRate | 5.75 % |
| variableRateSlope1 | 0.75 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=57500000000000000000000000&maxVariableBorrowRate=565000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93.5 % | 93.5 % |
| eMode.liquidationThreshold (unchanged) | 95.5 % | 95.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH | WETH |
| eMode.collateralBitmap (unchanged) | wstETH, WETH | wstETH, WETH |


### EMode: LRT Stablecoins main(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT Stablecoins main | LRT Stablecoins main |
| eMode.ltv (unchanged) | 75 % | 75 % |
| eMode.liquidationThreshold (unchanged) | 78 % | 78 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap (unchanged) | USDS | USDS |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


### EMode: LRT wstETH main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT wstETH main | LRT wstETH main |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "aToken": "0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido GHO",
        "aTokenSymbol": "aEthLidoGHO",
        "aTokenUnderlyingBalance": "6760840608343987319695151",
        "borrowCap": 10000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 5,
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
        "reserveFactor": 1,
        "supplyCap": 11000000,
        "symbol": "GHO",
        "underlying": "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtEthLidoGHO",
        "virtualAccountingActive": true,
        "virtualBalance": "6760840608343987319695151"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "57500000000000000000000000",
        "maxVariableBorrowRate": "565000000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "7500000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  }
}
```