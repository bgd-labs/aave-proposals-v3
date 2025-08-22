## Reserve changes

### Reserves altered

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 0.01 % | 0.01 % |
| eMode.liquidationThreshold (unchanged) | 87 % | 87 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | DAI, USDC, USDT, sUSD, USDC |  |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, sUSD, USDC | DAI, USDC, USDT, sUSD, USDC |


### EMode: ETH correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH, rETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, rETH | WETH, wstETH, rETH |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "8357",
        "to": "0"
      }
    },
    "2": {
      "borrowableBitmap": {
        "from": "4624",
        "to": "16"
      }
    }
  },
  "reserves": {
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": "GovernanceV3Optimism.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x58c60c4a0bb2d3f34cbaba1a0b564f51356f6627445683dc231bf6b72193af3c": {
          "previousValue": "0x00682b21e6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b21e6000000000003000000000000000000000000000000000000000000"
        },
        "0x58c60c4a0bb2d3f34cbaba1a0b564f51356f6627445683dc231bf6b72193af3d": {
          "previousValue": "0x000000000000000000093a800000000000006859466700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068594667000000000000682b21e7"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Optimism.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000001210",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000000020a5",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb2": {
          "previousValue": "0x100000000000000000000103e80001e848000000000107d08512292c1b580000",
          "newValue": "0x100000000000000000000103e80001e848000000000107d08112292c1b580000"
        }
      }
    }
  }
}
```