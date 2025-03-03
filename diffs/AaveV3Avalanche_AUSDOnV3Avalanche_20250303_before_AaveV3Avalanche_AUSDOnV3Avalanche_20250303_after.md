## Reserve changes

### Reserves altered

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowtrace.io/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % [0] | 69 % [6900] |
| liquidationThreshold | 0 % [0] | 72 % [7200] |
| liquidationBonus | 0 % | 6 % |


## Raw diff

```json
{
  "reserves": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "liquidationBonus": {
        "from": 0,
        "to": 10600
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 7200
      },
      "ltv": {
        "from": 0,
        "to": 6900
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  },
  "raw": {
    "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3c06dce358add17aaf230f2234bccc4afd50d090": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5e06b10b3b9c3e1c0996d2544a35b9839be02922": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a5": {
          "previousValue": "0x0067c5ee74000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067c5ee74000000000003000000000000000000000000000000000000000000"
        },
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a6": {
          "previousValue": "0x000000000000000000093a8000000000000067f412f500000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067f412f500000000000067c5ee75"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
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
    "0xb7467b66d86ce80cc258f28d266a18a51db7fac8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e4f": {
          "previousValue": "0x1000000000000000000000000000121eac00010980c003e88506000000000000",
          "newValue": "0x1000000000000000000000000000121eac00010980c003e8850629681c201af4"
        }
      }
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```