## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 11,000,000 USDC | 2,500,000 USDC |
| borrowCap | 11,000,000 USDC | 2,000,000 USDC |
| ltv | 75 % [7500] | 65 % [6500] |
| reserveFactor | 25 % [2500] | 40 % [4000] |


#### sDAI ([0xaf204776c7245bF4147c2612BF6e5972Ee483701](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 0 sDAI | 4,000,000 sDAI |
| maxVariableBorrowRate | 79 % | 24 % |
| variableRateSlope2 | 75 % | 20 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=790000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=200000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=240000000000000000000000000) |

## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sDAI / EURe(id: 2)



### EMode: sDAI_USDCe(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sDAI_USDCe |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDC.e |
| eMode.collateralBitmap | - | sDAI |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "128",
        "collateralBitmap": "64",
        "eModeCategory": 3,
        "label": "sDAI_USDCe",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "borrowCap": {
        "from": 11000000,
        "to": 2000000
      },
      "ltv": {
        "from": 7500,
        "to": 6500
      },
      "reserveFactor": {
        "from": 2500,
        "to": 4000
      },
      "supplyCap": {
        "from": 11000000,
        "to": 2500000
      }
    },
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "borrowCap": {
        "from": 0,
        "to": 4000000
      }
    }
  },
  "strategies": {
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "maxVariableBorrowRate": {
        "from": "790000000000000000000000000",
        "to": "240000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "200000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x1df462e2712496373a347f8ad10802a5e95f053d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x36616cf17557639614c1cddb356b1b83fc0b2132": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4ce496f0a390745102540faf041ef92ffd588b44": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x7a707fb5a667d8fcd75b759571976d14d8065a51b95e6ef656e3cfbef6769e8d": {
          "previousValue": "0x00000000000000000000000000000000000000001d4c00000190000000002328",
          "newValue": "0x000000000000000000000000000000000000000007d000000190000000002328"
        }
      }
    },
    "0x5f6f7b0a87ca3cf3d0b431ae03ef3305180bff4d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7304979ec9e4eaa0273b6a037a31c4e9e5a75d16": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x77c874799e9564a0d0670ed40bf023d249e7bb21": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f2768f": {
          "previousValue": "0x100000000000000000000007d0000a7d8c0000a7d8c009c4a50629041e781d4c",
          "newValue": "0x100000000000000000000007d00002625a00001e84800fa0a50629041e781964"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27690": {
          "previousValue": "0x0000000000286fd5b573d9f207482be700000000037e8a4e04ef3c564db5b332",
          "newValue": "0x000000000020597a6e9ea5a3e206a29c00000000037e8aa870ec9167c85c9a06"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27691": {
          "previousValue": "0x00000000004664eb4768e2fe70e7b2d300000000039b148d88af3b111fcafeae",
          "newValue": "0x00000000004664ee2db9630c890070bf00000000039b152ff76b68ebb050147a"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27692": {
          "previousValue": "0x00000000000000000000030067d0b34b00000000000000000000000000000000",
          "newValue": "0x00000000000000000000030067d0b72e00000000000000000000000000000000"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27697": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000002e511d3",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000002ef58c5"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000004028a023f02328"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x734441495f555344436500000000000000000000000000000000000000000014"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000080"
        },
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c27": {
          "previousValue": "0x100000000000000000000007d0002dc6c0000000000003e8811229041e781d4c",
          "newValue": "0x100000000000000000000007d0002dc6c000003d090003e8811229041e781d4c"
        },
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c28": {
          "previousValue": "0x0000000000000000000000000000000000000000033b3325f9972c994195ffce",
          "newValue": "0x0000000000000000000000000000000000000000033b3325f9972c994195ffce"
        },
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c29": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c2a": {
          "previousValue": "0x00000000000000000000060067d0aa7200000000000000000000000000000000",
          "newValue": "0x00000000000000000000060067d0b72e00000000000000000000000000000000"
        }
      }
    },
    "0x8fe06e1d8aff42bf6812cacf7854a2249a00bed7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xbec519531f0e78bcddb295242fa4ec5251b38574": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe59470b3be3293534603487e00a44c72f2cd466d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248f9": {
          "previousValue": "0x0067d0b72d000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d0b72d000000000003000000000000000000000000000000000000000000"
        },
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248fa": {
          "previousValue": "0x000000000000000000093a8000000000000067fedbae00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067fedbae00000000000067d0b72e"
        }
      }
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xec710f59005f48703908bc519d552df5b8472614": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```