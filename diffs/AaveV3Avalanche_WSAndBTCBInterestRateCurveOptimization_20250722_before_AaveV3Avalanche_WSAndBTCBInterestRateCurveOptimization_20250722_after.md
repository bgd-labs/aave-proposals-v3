## Reserve changes

### Reserves altered

#### BTC.b ([0x152b9d0FdC40C096757F570A51E494bd4b943E50](https://snowtrace.io/address/0x152b9d0FdC40C096757F570A51E494bd4b943E50))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 307 % | 84 % |
| variableRateSlope1 | 7 % | 4 % |
| variableRateSlope2 | 300 % | 80 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=840000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0x152b9d0FdC40C096757F570A51E494bd4b943E50": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0x152b9d0FdC40C096757F570A51E494bd4b943E50": {
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
    "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
      "label": "GovernanceV3Avalanche.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1adb659ca7eaa45e42dcd257d09b963c5cfbb36f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x20c10dd73b831f22f0230303c021188863c48937": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xb6daa7f42b4684a81e654680f3320ba6299809dbe8f4089d040ee5cdfce6b64d": {
          "previousValue": "0x100000000000000000000003e800000177000000012c07d08508299a1d4c1b58",
          "newValue": "0x100000000000000000000003e800000177000000012c13888508299a1d4c1b58"
        }
      }
    },
    "0x3c06dce358add17aaf230f2234bccc4afd50d090": {
      "label": "AaveV2Avalanche.POOL_ADMIN, AaveV3Avalanche.ACL_ADMIN, GovernanceV3Avalanche.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xb6daa7f42b4684a81e654680f3320ba6299809dbe8f4089d040ee5cdfce6b64e": {
          "previousValue": "0x000000000000a141ba681ff3956d4f4a00000000033e1c2868bd8cb9d8f2056f",
          "newValue": "0x000000000000206534641bfc677da27300000000033e1c287be8d5dda069aced"
        },
        "0xb6daa7f42b4684a81e654680f3320ba6299809dbe8f4089d040ee5cdfce6b64f": {
          "previousValue": "0x00000000000a10c7babc0e995cdf7480000000000351aac4b1d185e25e5fb2c1",
          "newValue": "0x0000000000033c4033fae0211ff6e181000000000351aac5eb58424c4c80bb5a"
        },
        "0xb6daa7f42b4684a81e654680f3320ba6299809dbe8f4089d040ee5cdfce6b650": {
          "previousValue": "0x000000000000000000000b00687fc843000000000000000000000000000ad878",
          "newValue": "0x000000000000000000000b00687fc87c000000000000000000000000000ad878"
        },
        "0xb6daa7f42b4684a81e654680f3320ba6299809dbe8f4089d040ee5cdfce6b655": {
          "previousValue": "0x000000000000000000000042d3d3b35c00000000000000000000000000012ef0",
          "newValue": "0x000000000000000000000042d3d3b35c00000000000000000000000000012f5b"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5e06b10b3b9c3e1c0996d2544a35b9839be02922": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2642cbfa046d8004053cd054e488df5b74257ae1e497e38d227e7244ef11bf2d": {
          "previousValue": "0x00687fc87b000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687fc87b000000000003000000000000000000000000000000000000000000"
        },
        "0x2642cbfa046d8004053cd054e488df5b74257ae1e497e38d227e7244ef11bf2e": {
          "previousValue": "0x000000000000000000093a8000000000000068adecfc00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068adecfc000000000000687fc87c"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Avalanche.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Avalanche.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Avalanche.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa8669021776bc142dfca87c21b4a52595bcbb40a": {
      "label": "AaveV3Avalanche.ASSETS.BTCb.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Avalanche.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xce1c5509f2f4d755aa64b8d135b15ec6f12a93da": {
      "label": "AaveV3Avalanche.ASSETS.DAIe.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.LINKe.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.WBTCe.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.WETHe.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.USDt.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.AAVEe.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.WAVAX.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.sAVAX.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.MAI.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.BTCb.INTEREST_RATE_STRATEGY, AaveV3Avalanche.ASSETS.AUSD.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x22bdd7992f40d9be13ecde867eccd0cd86e660d3ce9d00c860eb6ca5ef57c4d5": {
          "previousValue": "0x00000000000000000000000000000000000000007530000002bc000000001194",
          "newValue": "0x00000000000000000000000000000000000000001f4000000190000000001f40"
        }
      }
    }
  }
}
```