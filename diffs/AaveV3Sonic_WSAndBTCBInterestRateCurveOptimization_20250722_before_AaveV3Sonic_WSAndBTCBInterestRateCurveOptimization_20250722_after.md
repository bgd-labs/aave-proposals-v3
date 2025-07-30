## Reserve changes

### Reserves altered

#### wS ([0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38](https://sonicscan.org//address/0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 307 % | 84 % |
| variableRateSlope1 | 7 % | 4 % |
| variableRateSlope2 | 300 % | 80 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=840000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38": {
      "maxVariableBorrowRate": {
        "from": "3070000000000000000000000000",
        "to": "840000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "40000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "800000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x0846c28dd54dea4fd7fb31bcc5eb81673d68c695": {
      "label": "GovernanceV3Sonic.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3a790a47c4d531fd333fad24f70b0ccb521b3b5a": {
      "label": "AaveV3Sonic.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x50c70feb95abc1a92fc30b9acc41bd349e5de2f0": {
      "label": "AaveV3Sonic.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5362dbb1e601abf3a4c14c22ffeda64042e5eaa3": {
      "label": "AaveV3Sonic.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1c6109d2bbfbdadfc462a8d70dd8be07bf59af5d98a33599fd824b82f078f1ae": {
          "previousValue": "0x0000000000051631432439dd4eaf547800000000033ea04800f63e5af2fe2e09",
          "newValue": "0x000000000001a28fd6504704dd43f51000000000033ea0482c70b7bac0e8faf3"
        },
        "0x1c6109d2bbfbdadfc462a8d70dd8be07bf59af5d98a33599fd824b82f078f1af": {
          "previousValue": "0x00000000001bbfce1d34aabcaf05318d00000000034815f69de0b0efc4dfac70",
          "newValue": "0x000000000008eb5daff4e7bd57b7ec1900000000034815f78dc3e50d864e8c1f"
        },
        "0x1c6109d2bbfbdadfc462a8d70dd8be07bf59af5d98a33599fd824b82f078f1b0": {
          "previousValue": "0x000000000000000000000200687fc8f400000000000000000000000000000000",
          "newValue": "0x000000000000000000000200687fc90400000000000000000000000000000000"
        },
        "0x1c6109d2bbfbdadfc462a8d70dd8be07bf59af5d98a33599fd824b82f078f1b5": {
          "previousValue": "0x0000000000612ad313f1e5495d1fde2a000000000000000c650e2944135e2dc8",
          "newValue": "0x0000000000612ad313f1e5495d1fde2a000000000000000c6631e59fc7efff67"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5c2e738f6e27bce0f7558051bf90605dd6176900": {
      "label": "AaveV3Sonic.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7b62461a3570c6ac8a9f8330421576e417b71ee7": {
      "label": "AaveV3Sonic.ACL_ADMIN, GovernanceV3Sonic.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc47692016d70496e2e44531aaa8511aa07d4d185": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdff435bccf782f11187d3a4454d96702ed78e092": {
      "label": "AaveV3Sonic.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Sonic.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Sonic.ASSETS.wS.INTEREST_RATE_STRATEGY, AaveV3Sonic.ASSETS.stS.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x6c25d4659e21d12be9149fe56708ccaa64adf240a47e26b06a5deef01e2dddf2": {
          "previousValue": "0x00000000000000000000000000000000000000007530000002bc000000001194",
          "newValue": "0x00000000000000000000000000000000000000001f4000000190000000001f40"
        }
      }
    },
    "0xf6089b790fbf8f4812a79a31cfabeb00b06ba7bd": {
      "label": "AaveV3Sonic.ASSETS.wS.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd2": {
          "previousValue": "0x00687fc903000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687fc903000000000003000000000000000000000000000000000000000000"
        },
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd3": {
          "previousValue": "0x000000000000000000093a8000000000000068aded8400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068aded84000000000000687fc904"
        }
      }
    }
  }
}
```