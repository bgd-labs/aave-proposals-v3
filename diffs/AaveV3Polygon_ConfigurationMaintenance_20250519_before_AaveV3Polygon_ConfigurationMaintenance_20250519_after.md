## Reserve changes

### Reserves altered

#### MaticX ([0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6](https://polygonscan.com/address/0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: MATIC correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | MATIC correlated | MATIC correlated |
| eMode.ltv (unchanged) | 92.5 % | 92.5 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WPOL, stMATIC, MaticX | WPOL |
| eMode.collateralBitmap (unchanged) | WPOL, stMATIC, MaticX | WPOL, stMATIC, MaticX |


### EMode: ETH correlated(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH | WETH, wstETH |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "borrowableBitmap": {
        "from": "393344",
        "to": "128"
      }
    },
    "3": {
      "borrowableBitmap": {
        "from": "524304",
        "to": "16"
      }
    }
  },
  "reserves": {
    "0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc2": {
          "previousValue": "0x00682b2123000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b2123000000000003000000000000000000000000000000000000000000"
        },
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc3": {
          "previousValue": "0x000000000000000000093a80000000000000685945a400000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000685945a4000000000000682b2124"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000060080",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000080"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000080010",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0xd87cce9b5faabfdec37f32d8c75e0689cf8e2c9faac27b070479c3cf61dba3ed": {
          "previousValue": "0x100000000000000000000203e8007270e0000000000107d085122af817701388",
          "newValue": "0x100000000000000000000203e8007270e0000000000107d081122af817701388"
        }
      }
    }
  }
}
```