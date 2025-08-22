## Reserve changes

### Reserves altered

#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

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
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
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
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": "GovernanceV3Optimism.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1adb659ca7eaa45e42dcd257d09b963c5cfbb36f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae96": {
          "previousValue": "0x00000000002b2c9761ced6b6d1cdaf6e0000000003a9bffdb429d2ba8b939f92",
          "newValue": "0x000000000021b0241dc3e720407353cd0000000003a9c2a046bfdcd82036b278"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae97": {
          "previousValue": "0x0000000000429c0edd03570b7b3a16bb0000000003eb1cd401229508135dc09b",
          "newValue": "0x0000000000532899f1d782436c0b5f3e0000000003eb212d4af9ae697d6e7250"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae98": {
          "previousValue": "0x000000000000000000000a00687669150000000000000000016bb31f94658518",
          "newValue": "0x000000000000000000000a00687682fd0000000000000000016bb31f94658518"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae9d": {
          "previousValue": "0x00000000000003896f719ec346ff11630000000000000000133b9d366f356fb7",
          "newValue": "0x00000000000003896f719ec346ff11630000000000000000163069434aa1364b"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x746c675dab49bcd5bb9dc85161f2d7eb435009bf": {
      "label": "AaveV3Optimism.ACL_ADMIN, GovernanceV3Optimism.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Optimism.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Optimism.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x893b4d783e62e8bd46d93eda5599491ff8ad5c40": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae95": {
          "previousValue": "0x1000000000000000000000000000007a120000061a8007d08512000000000000",
          "newValue": "0x1000000000000000000000000000007a120000061a8013888512000000000000"
        }
      }
    },
    "0x9359282735496463131139875849d5302fb4bed1": {
      "label": "AaveV3Optimism.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.sUSD.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.OP.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.MAI.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Optimism.ASSETS.USDCn.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x1c7f307829b43601cc9e310d5b7c696a0f5a58e0e5f7e8e14880124f843d7a16": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000226000000001f40",
          "newValue": "0x0000000000000000000000000000000000000000138800000226000000c81f40"
        }
      }
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Optimism.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Optimism.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xce186f6cccb0c955445bb9d10c59cae488fea559": {
      "label": "AaveV3Optimism.ASSETS.LUSD.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x21a96d7401b4330badc55cca6afdb5531f4ba2a6923da027f434c4639f5c1d71": {
          "previousValue": "0x00687682fc000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687682fc000000000003000000000000000000000000000000000000000000"
        },
        "0x21a96d7401b4330badc55cca6afdb5531f4ba2a6923da027f434c4639f5c1d72": {
          "previousValue": "0x000000000000000000093a8000000000000068a4a77d00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068a4a77d000000000000687682fd"
        }
      }
    }
  }
}
```