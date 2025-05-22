## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH | WETH, wstETH |


### EMode: sDAI / EURe(id: 2)



### EMode: sDAI/USDCe(id: 3)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "3",
        "to": "1"
      }
    }
  },
  "raw": {
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc5": {
          "previousValue": "0x00682b22e9000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b22e9000000000003000000000000000000000000000000000000000000"
        },
        "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc6": {
          "previousValue": "0x000000000000000000093a800000000000006859476a00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006859476a000000000000682b22ea"
        }
      }
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": "AaveV3Gnosis.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000003",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    }
  }
}
```