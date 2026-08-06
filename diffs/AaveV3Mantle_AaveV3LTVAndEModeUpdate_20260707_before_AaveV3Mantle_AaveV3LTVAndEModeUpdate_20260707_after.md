## Reserve changes

### Reserves altered

#### WMNT ([0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8](https://mantlescan.xyz//address/0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 40 % [4000] | 0 % [0] |


#### WETH ([0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111](https://mantlescan.xyz//address/0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80.5 % [8050] | 0 % [0] |


## EMode changes

### EMode: WMNT__Stablecoins (id: 6)

| description | value before | value after |
| --- | --- | --- |
| label | - | WMNT__Stablecoins |
| ltv | - | 40 % |
| liquidationThreshold | - | 45 % |
| liquidationBonus | - | 10 % [11000] |
| borrowableBitmap | - | USDT0, USDC, GHO |
| collateralBitmap | - | WMNT |
| isolated | - | :white_check_mark: |


## Event logs

#### 0x719755fC1ACf2f9079B0Cbc56e23712c09Ab8626 (AaveV3Mantle.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | EModeCategoryAdded(categoryId: 6, ltv: 4000, liquidationThreshold: 4500, liquidationBonus: 11000, oracle: 0x0000000000000000000000000000000000000000, label: WMNT__Stablecoins) |
| 1 | topics: `0xea07f8a4f488dcc1dc8c27b9c526ac8ba2d04b8024e206616f306c51d9b16826`, `0x0000000000000000000000000000000000000000000000000000000000000006`, data: `0x0000000000000000000000000000000000000000000000000000000000000001` |
| 2 | AssetCollateralInEModeChanged(asset: 0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8 (symbol: WMNT), categoryId: 6, collateral: true) |
| 3 | AssetBorrowableInEModeChanged(asset: 0x779Ded0c9e1022225f8E0630b35a9b54bE713736 (symbol: USDT0), categoryId: 6, borrowable: true) |
| 4 | AssetBorrowableInEModeChanged(asset: 0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9 (symbol: USDC), categoryId: 6, borrowable: true) |
| 5 | AssetBorrowableInEModeChanged(asset: 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73 (symbol: GHO), categoryId: 6, borrowable: true) |
| 6 | CollateralConfigurationChanged(asset: 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111 (symbol: WETH), ltv: 0, liquidationThreshold: 8300, liquidationBonus: 10550) |
| 7 | CollateralConfigurationChanged(asset: 0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8 (symbol: WMNT), ltv: 0, liquidationThreshold: 4500, liquidationBonus: 11000) |

#### 0x70884634D0098782592111A2A6B8d223be31CB7b (AaveV3Mantle.ACL_ADMIN, GovernanceV3Mantle.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 8 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1783958440, withDelegatecall: true, resultData: 0x) |

#### 0xF089f77173A3009A98c45f49D547BF714A7B1e01 (GovernanceV3Mantle.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 9 | PayloadExecuted(payloadId: 10) |

## Raw storage changes

### 0x458f293454fe0d67ec0655f3672301301dd51422 (AaveV3Mantle.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6 | 0x0000000000000000000000000000000000000000000000000000000000000000 | 0x00000000000000000001000000000000000000000000000000022af811940fa0 |
| 0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7 | 0x0000000000000000000000000000000000000000000000000000000000000000 | 0x574d4e545f5f537461626c65636f696e73000000000000000000000000000022 |
| 0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8 | 0x0000000000000000000000000000000000000000000000000000000000000000 | 0x000000000000000000000000000000000000000000000000000000000000020c |
| 0x6cc3a721a1a588b5593bb61f189070346dc94984b3e0a3f69a324361cb83068c | 0x100000000000000000000003e8000249f0000000000107d081122af811940fa0 | 0x100000000000000000000003e8000249f0000000000107d081122af811940000 |
| 0xf379616f58ee5fcf8e573e9354f6d2badd416b275e710545bec628b28298f68a | 0x100000000000000000000003e80000027d80000023dc05dc85122936206c1f72 | 0x100000000000000000000003e80000027d80000023dc05dc85122936206c0000 |

### 0xf089f77173a3009a98c45f49d547bf714a7b1e01 (GovernanceV3Mantle.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d53 | 0x006a550ba7000000000002000000000000000000000000000000000000000000 | 0x006a550ba7000000000003000000000000000000000000000000000000000000 |
| 0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d54 | 0x000000000000000000093a800000000000006a83302800000000000000000000 | 0x000000000000000000093a800000000000006a8330280000000000006a550ba8 |


## Raw diff

```json
{
  "reserves": {
    "0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8": {
      "ltv": {
        "from": 4000,
        "to": 0
      }
    },
    "0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111": {
      "ltv": {
        "from": 8050,
        "to": 0
      }
    }
  },
  "eModes": {
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "524",
        "collateralBitmap": "2",
        "eModeCategory": 6,
        "isolated": true,
        "label": "WMNT__Stablecoins",
        "liquidationBonus": 11000,
        "liquidationThreshold": 4500,
        "ltv": 4000
      }
    }
  }
}
```
