## Reserve changes

### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 85.55 % | 40.55 % |
| variableRateSlope2 | 85 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=5500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=855500000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=5500000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=405500000000000000000000000) |

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 15 % [1500] |


## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "reserveFactor": {
        "from": 1000,
        "to": 1500
      }
    }
  },
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "maxVariableBorrowRate": {
        "from": "855500000000000000000000000",
        "to": "405500000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "850000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x013e2c7567b6231e865bb9273f8c7656103611c0": {
      "label": "AaveV3EthereumLido.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x342631c6cefc9cfbf97b2fe4aa242a236e1fd517": {
      "label": "AaveV3EthereumLido.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x34fd9638ee82e78f21d66b54bf4d4e61cdb4f7d1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x564c42578a1b270eae16c25da39d901245881d1f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b3": {
          "previousValue": "0x00000000000354e22daa0c7748e6ed7400000000033da8f6366bf9a6f0927cca",
          "newValue": "0x00000000000354e22f25c14fb2176dc300000000033da8f9a10f1a3ae9e80f59"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b4": {
          "previousValue": "0x00000000000435dcc2f6477e6228ebac00000000033f7f06edc27a42ef896047",
          "newValue": "0x00000000000435dcc3e6368f9b343f8800000000033f7f0b418f7a538077916f"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b5": {
          "previousValue": "0x000000000000000000000000687e206700000000000000000000000000000000",
          "newValue": "0x000000000000000000000000687e225300000000000000000000000000000000"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01ba": {
          "previousValue": "0x0000000000000830d5e682ba4aa986c700000000000000000224694fcee67453",
          "newValue": "0x0000000000000830d5e682ba4aa986c7000000000000000002271f8e2b894296"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec0": {
          "previousValue": "0x000000000030199c8766f015d5d4414d00000000034c57a56cd476b4975a0731",
          "newValue": "0x00000000002d6d9ff985d790c1cdf83300000000034c57d79ffbba78f372b6d3"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec1": {
          "previousValue": "0x000000000039c4274e36c69b0fb44757000000000351a18c43c3b311668cc77c",
          "newValue": "0x000000000039c448858749056f69d01c000000000351a1c8ee2a17b47cf54881"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec2": {
          "previousValue": "0x000000000000000000000100687e206700000000000000000000000000000000",
          "newValue": "0x000000000000000000000100687e225300000000000000000000000000000000"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec7": {
          "previousValue": "0x00000000000001dc9ca575faf72a50040000000000000000191f1182b480354b",
          "newValue": "0x00000000000001dc9ca575faf72a5004000000000000000019484c28d6307ecb"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a26": {
          "previousValue": "0x00687e2252000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687e2252000000000003000000000000000000000000000000000000000000"
        },
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a27": {
          "previousValue": "0x000000000000000000093a8000000000000068ac46d300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068ac46d3000000000000687e2253"
        }
      }
    },
    "0x8958b1c39269167527821f8c276ef7504883f2fa": {
      "label": "AaveV3EthereumLido.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.rsETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xf37caed32e4e49c83636e0f1684f3f4a9a23c463a49eb17cd63abd50680b378b": {
          "previousValue": "0x0000000000000000000000000000000000000000213400000037000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa000000037000000002328"
        }
      }
    },
    "0x91b7d78bf92db564221f6b5aee744d1727d1dd1e": {
      "label": "AaveV3EthereumLido.ASSETS.WETH.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xcfbf336fe147d643b9cb705648500e101504b16d": {
      "label": "AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe439edd2625772aa635b437c099c607b6eb7d35f": {
      "label": "AaveV3EthereumLido.ASSETS.wstETH.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xeabd3344f14b4df97611910dd3826b0767bcc588": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ebf": {
          "previousValue": "0x100000000000000000000103e80000dbba00000c5c1003e885122904213420d0",
          "newValue": "0x100000000000000000000103e80000dbba00000c5c1005dc85122904213420d0"
        }
      }
    }
  }
}
```