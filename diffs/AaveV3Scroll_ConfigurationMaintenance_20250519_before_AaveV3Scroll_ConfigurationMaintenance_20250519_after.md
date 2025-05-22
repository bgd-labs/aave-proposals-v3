## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH, weETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, weETH | WETH, wstETH, weETH |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "13",
        "to": "1"
      }
    }
  },
  "raw": {
    "0x11fcfe756c05ad438e312a7fd934381537d3cffe": {
      "label": "AaveV3Scroll.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000000d",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0x6b6b41c0f8c223715f712be83cec3c37bbfdc3fe": {
      "label": "GovernanceV3Scroll.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xa6d60d4ff1c38ae572157a43d1b8579039e4b4cc96e22c75c07379751785fe51": {
          "previousValue": "0x00682b22f3000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b22f3000000000003000000000000000000000000000000000000000000"
        },
        "0xa6d60d4ff1c38ae572157a43d1b8579039e4b4cc96e22c75c07379751785fe52": {
          "previousValue": "0x000000000000000000093a800000000000006859477400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068594774000000000000682b22f4"
        }
      }
    }
  }
}
```