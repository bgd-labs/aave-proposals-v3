## Reserve changes

### Reserves altered

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowtrace.io/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % [0] | 69 % [6900] |
| liquidationThreshold | 0 % [0] | 72 % [7200] |
| liquidationBonus | 0 % | 6 % |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |


## Raw diff

```json
{
  "reserves": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "liquidationBonus": {
        "from": 0,
        "to": 10600
      },
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
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
      "label": "GovernanceV3Avalanche.PAYLOADS_CONTROLLER",
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
      "label": "AaveV3Avalanche.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e4f": {
          "previousValue": "0x1000000000000000000000000000121eac00010980c003e88506000000000000",
          "newValue": "0x100000000000000000000003e800121eac00010980c003e8850629681c201af4"
        }
      }
    }
  }
}
```