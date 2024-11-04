## Reserve changes

### Reserves added

#### ezETH ([0xbf5495Efe5DB9ce00f80364C8B423567e58d2110](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 15,000 ezETH |
| borrowCap | 100 ezETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | false |
| oracle | [0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee](https://etherscan.io/address/0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee) |
| oracleDecimals | 8 |
| oracleDescription | Capped ezETH / ezETH(ETH) / USD |
| oracleLatestAnswer | 2714.95678736 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0x74e5664394998f13B07aF42446380ACef637969f](https://etherscan.io/address/0x74e5664394998f13B07aF42446380ACef637969f) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x08e1bba76D27841dD91FAb4b3a636A0D5CF8c3E9](https://etherscan.io/address/0x08e1bba76D27841dD91FAb4b3a636A0D5CF8c3E9) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido ezETH |
| aTokenSymbol | aEthLidoezETH |
| aTokenUnderlyingBalance | 0.1 ezETH [100000000000000000] |
| id | 4 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt ezETH |
| variableDebtTokenSymbol | variableDebtEthLidoezETH |
| virtualAccountingActive | true |
| virtualBalance | 0.1 ezETH [100000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](/.assets/3b30aea0d7ed061d9d9b0eeecb2e4835c7844ba5.svg) |


### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 100 wstETH | 14,000 wstETH |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93.5 % | 93.5 % |
| eMode.liquidationThreshold (unchanged) | 95.5 % | 95.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH, WETH | WETH |
| eMode.collateralBitmap (unchanged) | wstETH, WETH | wstETH, WETH |


### EMode: LRT Stablecoins main(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | LRT Stablecoins main |
| eMode.ltv | - | 75 % |
| eMode.liquidationThreshold | - | 78 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDS |
| eMode.collateralBitmap | - | ezETH |


### EMode: LRT wstETH main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | LRT wstETH main |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | ezETH |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "3",
        "to": "2"
      }
    },
    "2": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "16",
        "eModeCategory": 2,
        "label": "LRT Stablecoins main",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7800,
        "ltv": 7500
      }
    },
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "16",
        "eModeCategory": 3,
        "label": "LRT wstETH main",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowCap": {
        "from": 100,
        "to": 14000
      }
    },
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "aToken": "0x74e5664394998f13B07aF42446380ACef637969f",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido ezETH",
        "aTokenSymbol": "aEthLidoezETH",
        "aTokenUnderlyingBalance": "100000000000000000",
        "borrowCap": 100,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 4,
        "interestRateStrategy": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
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
        "oracle": "0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ezETH / ezETH(ETH) / USD",
        "oracleLatestAnswer": "271495678736",
        "reserveFactor": 1500,
        "supplyCap": 15000,
        "symbol": "ezETH",
        "underlying": "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x08e1bba76D27841dD91FAb4b3a636A0D5CF8c3E9",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt ezETH",
        "variableDebtTokenSymbol": "variableDebtEthLidoezETH",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000"
      }
    }
  },
  "strategies": {
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3070000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```