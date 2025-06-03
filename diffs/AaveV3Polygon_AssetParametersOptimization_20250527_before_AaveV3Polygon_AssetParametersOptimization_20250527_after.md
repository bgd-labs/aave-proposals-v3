## Reserve changes

### Reserve altered

#### CRV ([0x172370d5Cd63279eFa6d502DAB29171933a610AF](https://polygonscan.com/address/0x172370d5Cd63279eFa6d502DAB29171933a610AF))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 70 % | 45 % |
| maxVariableBorrowRate | 317 % | 163 % |
| variableRateSlope1 | 14 % | 10 % |
| variableRateSlope2 | 300 % | 150 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=140000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=700000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=3170000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=1630000000000000000000000000) |

#### BAL ([0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 80 % | 45 % |
| maxVariableBorrowRate | 177 % | 170 % |
| variableRateSlope1 | 22 % | 15 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=220000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=50000000000000000000000000&maxVariableBorrowRate=1770000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=50000000000000000000000000&maxVariableBorrowRate=1700000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x172370d5Cd63279eFa6d502DAB29171933a610AF": {
      "maxVariableBorrowRate": {
        "from": "3170000000000000000000000000",
        "to": "1630000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "700000000000000000000000000",
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "140000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "1500000000000000000000000000"
      }
    },
    "0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3": {
      "maxVariableBorrowRate": {
        "from": "1770000000000000000000000000",
        "to": "1700000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "800000000000000000000000000",
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "220000000000000000000000000",
        "to": "150000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
      "label": "AaveV3Polygon.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WPOL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.SUSHI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.GHST.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.DPI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.jEUR.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURA.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.miMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.stMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.MaticX.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDCn.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x8ca5a3f9ec346dd1a281cdfd9e78eefb22f1efbe2daa564788c58de89031003b": {
          "previousValue": "0x00000000000000000000000000000000000000007530000005780000012c1b58",
          "newValue": "0x00000000000000000000000000000000000000003a98000003e80000012c1194"
        },
        "0x999a92fb2bcd559de181ea9fc1e67c2d347c13cd90cb669a982d5cd55973e4f8": {
          "previousValue": "0x00000000000000000000000000000000000000003a9800000898000001f41f40",
          "newValue": "0x00000000000000000000000000000000000000003a98000005dc000001f41194"
        }
      }
    },
    "0x77ca01483f379e58174739308945f044e1a764dc": {
      "label": "AaveV3Polygon.ASSETS.CRV.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x79b5e91037ae441de0d9e6fd3fd85b96b83d4e93": {
      "label": "AaveV3Polygon.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2",
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
    "0xa8669021776bc142dfca87c21b4a52595bcbb40a": {
      "label": "AaveV3Polygon.ASSETS.BAL.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Polygon.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb7467b66d86ce80cc258f28d266a18a51db7fac8": {
      "label": "AaveV3Polygon.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x2074557ae98d029f93e2e7da626a163f4ed6d3b09e02107794c8172629f3fa29": {
          "previousValue": "0x00000000000dbc11c94cb86e43fe17be00000000038077eb77b8a2a0fc093d46",
          "newValue": "0x00000000000ec1380b2f4122d19007a10000000003809a8af4a0a55692532d3c"
        },
        "0x2074557ae98d029f93e2e7da626a163f4ed6d3b09e02107794c8172629f3fa2a": {
          "previousValue": "0x000000000048d22b71587a0c4940375800000000045f70426e0b0d3010a297ff",
          "newValue": "0x00000000004e2f6a56123f897d9ccbe30000000004605594722bef634326f0ac"
        },
        "0x2074557ae98d029f93e2e7da626a163f4ed6d3b09e02107794c8172629f3fa2b": {
          "previousValue": "0x000000000000000000000800683b0aba000000000000000030a0b53339869f23",
          "newValue": "0x000000000000000000000800683f6a02000000000000000030a0b53339869f23"
        },
        "0x2074557ae98d029f93e2e7da626a163f4ed6d3b09e02107794c8172629f3fa30": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000074fa184acb16fc8a"
        },
        "0x9d6c1570366f1668d7d7e0495b449910ee14e6c30b1e0ba28bdbefd7bc9bcf60": {
          "previousValue": "0x00000000000387081dbee9fbc3cfa9db0000000003a4d260cdf967af16118be5",
          "newValue": "0x000000000003bf39b30f15c29e8908940000000003a4d318fcdbd1638784f291"
        },
        "0x9d6c1570366f1668d7d7e0495b449910ee14e6c30b1e0ba28bdbefd7bc9bcf61": {
          "previousValue": "0x00000000003a80e8c515f90cc3dd93b00000000004d3d1e245ac8fbb21c90add",
          "newValue": "0x00000000003e24278dd5b619b66de23a0000000004d3e1b14d5604e4c2d198e6"
        },
        "0x9d6c1570366f1668d7d7e0495b449910ee14e6c30b1e0ba28bdbefd7bc9bcf62": {
          "previousValue": "0x000000000000000000000b00683f12fa0000000000000000084232e3e28b7db7",
          "newValue": "0x000000000000000000000b00683f6a020000000000000000084232e3e28b7db7"
        },
        "0x9d6c1570366f1668d7d7e0495b449910ee14e6c30b1e0ba28bdbefd7bc9bcf67": {
          "previousValue": "0x00000000000000000000000000000000000000000000000012da23319e38eb23",
          "newValue": "0x00000000000000000000000000000000000000000000000014712755361a35de"
        }
      }
    },
    "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xbb4ac5d7b238e09f0346251f5f12e6fe98711019a88910e6a64f47bf73e6c3c2": {
          "previousValue": "0x00683f6a01000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00683f6a01000000000003000000000000000000000000000000000000000000"
        },
        "0xbb4ac5d7b238e09f0346251f5f12e6fe98711019a88910e6a64f47bf73e6c3c3": {
          "previousValue": "0x000000000000000000093a80000000000000686d8e8200000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000686d8e82000000000000683f6a02"
        }
      }
    },
    "0xdf7d0e6454db638881302729f5ba99936eaab233": {
      "label": "AaveV2Polygon.POOL_ADMIN, AaveV3Polygon.ACL_ADMIN, GovernanceV3Polygon.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Polygon.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```