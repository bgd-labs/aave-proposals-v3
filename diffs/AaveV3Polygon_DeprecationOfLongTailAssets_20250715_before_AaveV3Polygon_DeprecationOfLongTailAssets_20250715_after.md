## Reserve changes

### Reserves altered

#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 675,000 $ [67500000] | 1 $ [100] |
| ltv | 65 % [6500] | 0 % [0] |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| maxVariableBorrowRate | 59 % | 61 % |
| baseVariableBorrowRate | 0 % | 2 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=20000000000000000000000000&maxVariableBorrowRate=610000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "debtCeiling": {
        "from": 67500000,
        "to": 100
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "20000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "610000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x1adb659ca7eaa45e42dcd257d09b963c5cfbb36f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
      "label": "AaveV3Polygon.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WPOL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.SUSHI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.GHST.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.DPI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.jEUR.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURA.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.miMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.stMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.MaticX.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDCn.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xebab341f8755e41e908427903682896fb6f5295dc81509190f27a340c010d4e0": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000001f40",
          "newValue": "0x0000000000000000000000000000000000000000138800000384000000c81f40"
        }
      }
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b40": {
          "previousValue": "0x00000000001d32215ceaf8f5422a54d80000000003a7714400c22cd351284d06",
          "newValue": "0x0000000000176d800f51b9eee02732120000000003a7731f907dbe50c091217f"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b41": {
          "previousValue": "0x00000000003a46bfbc0956ddaa4e11370000000003fa9ee89ed0faf3f35b5885",
          "newValue": "0x00000000004ad20000ff175c226a4eed0000000003faa2f24775df5a43a2ceb1"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b42": {
          "previousValue": "0x000000000000000000000d0068766795000000000000000000000000000002f7",
          "newValue": "0x000000000000000000000d00687682a8000000000000000000000000000002f7"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b47": {
          "previousValue": "0x00000000000000000000000005a7d59e0000000000000000000000000000117a",
          "newValue": "0x00000000000000000000000005a7d59e0000000000000000000000000000132d"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5d557b07776d12967914379c71a1310e917c7555": {
      "label": "AaveV3Polygon.ASSETS.EURS.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x771d2d9420432b8a4c076e6c4721e392c4d3794a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b3f": {
          "previousValue": "0x1000405f7e00000000000103e80003d09000002dc6c007d0850229fe1b581964",
          "newValue": "0x100000000640000000000103e80003d09000002dc6c01388850229fe1b580000"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Polygon.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Polygon.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Polygon.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0c91243f75e216cf1d80d738f653c23abf15a7e3590b83c6e4772e2ddcffe533": {
          "previousValue": "0x00687682a7000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687682a7000000000003000000000000000000000000000000000000000000"
        },
        "0x0c91243f75e216cf1d80d738f653c23abf15a7e3590b83c6e4772e2ddcffe534": {
          "previousValue": "0x000000000000000000093a8000000000000068a4a72800000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068a4a728000000000000687682a8"
        }
      }
    },
    "0xdf7d0e6454db638881302729f5ba99936eaab233": {
      "label": "AaveV2Polygon.POOL_ADMIN, AaveV3Polygon.ACL_ADMIN, GovernanceV3Polygon.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```