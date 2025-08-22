## Reserve changes

### Reserves altered

#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | DAI.e, USDC, USDt, FRAX, MAI |  |
| eMode.collateralBitmap (unchanged) | DAI.e, USDC, USDt, FRAX, MAI | DAI.e, USDC, USDt, FRAX, MAI |


### EMode: AVAX correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | AVAX correlated | AVAX correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WAVAX, sAVAX | WAVAX |
| eMode.collateralBitmap (unchanged) | WAVAX, sAVAX | WAVAX, sAVAX |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "1573",
        "to": "0"
      }
    },
    "2": {
      "borrowableBitmap": {
        "from": "384",
        "to": "128"
      }
    }
  },
  "reserves": {
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
      "label": "GovernanceV3Avalanche.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xd59eb1c08df610a2d207db4db91372b9fa60f3de2255ec3b0fbfc33ac8593149": {
          "previousValue": "0x00682b2180000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b2180000000000003000000000000000000000000000000000000000000"
        },
        "0xd59eb1c08df610a2d207db4db91372b9fa60f3de2255ec3b0fbfc33ac859314a": {
          "previousValue": "0x000000000000000000093a800000000000006859460100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068594601000000000000682b2181"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Avalanche.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000180",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000080"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a58": {
          "previousValue": "0x10005f5e1000000000000103e80000493e0000041eb007d0851229041e140000",
          "newValue": "0x10005f5e1000000000000103e80000493e0000041eb007d0811229041e140000"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000625",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    }
  }
}
```