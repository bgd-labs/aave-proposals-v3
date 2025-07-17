## Reserve changes

### Reserves altered

#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| maxVariableBorrowRate | 55.5 % | 57.5 % |
| baseVariableBorrowRate | 0 % | 2 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=555000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=20000000000000000000000000&maxVariableBorrowRate=575000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "20000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "555000000000000000000000000",
        "to": "575000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec673": {
          "previousValue": "0x006876836f000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006876836f000000000003000000000000000000000000000000000000000000"
        },
        "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec674": {
          "previousValue": "0x000000000000000000093a8000000000000068a4a7f000000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068a4a7f000000000000068768370"
        }
      }
    },
    "0x1adb659ca7eaa45e42dcd257d09b963c5cfbb36f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x429f16dba3b9e1900087cbaa7b50d38bc60fb73f": {
      "label": "AaveV3Arbitrum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.MAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDCn.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ARB.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.rsETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x0b802dd8ef10b7199d8583a067e6a339f2cdf2c4173b3505e7604a919519a9e8": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000226000000001f40",
          "newValue": "0x0000000000000000000000000000000000000000138800000226000000c81f40"
        }
      }
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e85": {
          "previousValue": "0x00000000001363b6e1d816515b60cecc00000000039ce420c063fb6ddaefb33f",
          "newValue": "0x00000000001184c249ff8403744d212400000000039ce4a2760b6437898e4992"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e86": {
          "previousValue": "0x000000000025203012e45287293047e50000000003d853372376d60a7bbadb5f",
          "newValue": "0x000000000035ab5db511352642d1aa4d0000000003d8543f753e1ba45f4c05c8"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e87": {
          "previousValue": "0x000000000000000000000b006876783100000000000000000243211d4f7bdab7",
          "newValue": "0x000000000000000000000b006876837000000000000000000243211d4f7bdab7"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e8c": {
          "previousValue": "0x0000000000001947e9ca71bf712efe1600000000000000002a575ea8b43236b3",
          "newValue": "0x0000000000001947e9ca71bf712efe1600000000000000002c9fecc0f3f25468"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Arbitrum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Arbitrum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa8669021776bc142dfca87c21b4a52595bcbb40a": {
      "label": "AaveV3Arbitrum.ASSETS.LUSD.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa9022f64f4e86f1c9f4c07b248caa06b0af915d9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e84": {
          "previousValue": "0x1000000000000000000000000000019d5480000fde8007d08512000000000000",
          "newValue": "0x1000000000000000000000000000019d5480000fde8013888512000000000000"
        }
      }
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": "AaveV3Arbitrum.ACL_ADMIN, GovernanceV3Arbitrum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```