## Reserve changes

### Reserves altered

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % [6000] | 0 % [0] |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv | 90 % | 0.01 % |
| eMode.liquidationThreshold | 93 % | 87 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | DAI, USDC, USDT, sUSD, USDC | DAI, USDC, USDT, sUSD, USDC |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, sUSD, USDC | DAI, USDC, USDT, sUSD, USDC |


### EMode: ETH correlated(id: 2)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "liquidationThreshold": {
        "from": 9300,
        "to": 8700
      },
      "ltv": {
        "from": 9000,
        "to": 1
      }
    }
  },
  "reserves": {
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "ltv": {
        "from": 6000,
        "to": 0
      }
    }
  },
  "raw": {
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x746c675dab49bcd5bb9dc85161f2d7eb435009bf": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7a7ef57479123f26db6a0e3efbf8a3562edd65be": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
          "previousValue": "0x00000000000000000000000000000000000000000000000020a5277424542328",
          "newValue": "0x00000000000000000000000000000000000000000000000020a5277421fc0001"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb1": {
          "previousValue": "0x537461626c65636f696e73000000000000000000000000000000000000000016",
          "newValue": "0x537461626c65636f696e73000000000000000000000000000000000000000016"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb2": {
          "previousValue": "0x100000000000000000000103e800098968000000000107d08512292c1b581770",
          "newValue": "0x100000000000000000000103e800098968000000000107d08512292c1b580000"
        }
      }
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x682542400590cecd25f82cad25103b4dc125cd3511d319539197c8bb9765a74f": {
          "previousValue": "0x0067b6ed9a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067b6ed9a000000000003000000000000000000000000000000000000000000"
        },
        "0x682542400590cecd25f82cad25103b4dc125cd3511d319539197c8bb9765a750": {
          "previousValue": "0x000000000000000000093a8000000000000067e5121b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067e5121b00000000000067b6ed9b"
        }
      }
    }
  }
}
```