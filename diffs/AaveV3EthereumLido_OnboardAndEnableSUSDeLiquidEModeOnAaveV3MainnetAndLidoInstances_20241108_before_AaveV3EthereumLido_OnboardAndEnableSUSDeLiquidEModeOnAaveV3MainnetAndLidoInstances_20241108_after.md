## Reserve changes

### Reserves added

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 20,000,000 sUSDe |
| borrowCap | 1,000 sUSDe |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A](https://etherscan.io/address/0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A) |
| oracleDecimals | 8 |
| oracleDescription | Capped sUSDe / USDe / USD |
| oracleLatestAnswer | 1.11869905 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0](https://etherscan.io/address/0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a](https://etherscan.io/address/0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido sUSDe |
| aTokenSymbol | aEthLidosUSDe |
| aTokenUnderlyingBalance | 100 sUSDe [100000000000000000000] |
| id | 5 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt sUSDe |
| variableDebtTokenSymbol | variableDebtEthLidosUSDe |
| virtualAccountingActive | true |
| virtualBalance | 100 sUSDe [100000000000000000000] |
| optimalUsageRatio | 1 % |
| maxVariableBorrowRate | 3.15 % |
| baseVariableBorrowRate | 0.05 % |
| variableRateSlope1 | 0.1 % |
| variableRateSlope2 | 3 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=1000000000000000000000000&variableRateSlope2=30000000000000000000000000&optimalUsageRatio=10000000000000000000000000&baseVariableBorrowRate=500000000000000000000000&maxVariableBorrowRate=31500000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | LRT Stablecoins main | sUSDe Stablecoins |
| eMode.ltv | 75 % | 90 % |
| eMode.liquidationThreshold | 78 % | 92 % |
| eMode.liquidationBonus | 7.5 % | 3 % |
| eMode.borrowableBitmap | USDS | USDS, USDC |
| eMode.collateralBitmap | ezETH | ezETH, sUSDe |


### EMode: LRT wstETH main(id: 3)



## Raw diff

```json
{
  "eModes": {
    "2": {
      "borrowableBitmap": {
        "from": 4,
        "to": 12
      },
      "collateralBitmap": {
        "from": 16,
        "to": 48
      },
      "label": {
        "from": "LRT Stablecoins main",
        "to": "sUSDe Stablecoins"
      },
      "liquidationBonus": {
        "from": 10750,
        "to": 10300
      },
      "liquidationThreshold": {
        "from": 7800,
        "to": 9200
      },
      "ltv": {
        "from": 7500,
        "to": 9000
      }
    }
  },
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "from": null,
      "to": {
        "aToken": "0xc2015641564a5914A17CB9A92eC8d8feCfa8f2D0",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido sUSDe",
        "aTokenSymbol": "aEthLidosUSDe",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 1000,
        "borrowingEnabled": false,
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
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A",
        "oracleDecimals": 8,
        "oracleDescription": "Capped sUSDe / USDe / USD",
        "oracleLatestAnswer": 111869905,
        "reserveFactor": 1000,
        "supplyCap": 20000000,
        "symbol": "sUSDe",
        "underlying": "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x2ABbAab3EF4e4A899d39e7EC996b5715E76b399a",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt sUSDe",
        "variableDebtTokenSymbol": "variableDebtEthLidosUSDe",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "500000000000000000000000",
        "maxVariableBorrowRate": "31500000000000000000000000",
        "optimalUsageRatio": "10000000000000000000000000",
        "variableRateSlope1": "1000000000000000000000000",
        "variableRateSlope2": "30000000000000000000000000"
      }
    }
  }
}
```