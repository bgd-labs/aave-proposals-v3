## Reserve changes

### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 5 % [500] | 35 % [3500] |
| maxVariableBorrowRate | 86.6 % | 41 % |
| variableRateSlope1 | 1.6 % | 1 % |
| variableRateSlope2 | 85 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=16000000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=866000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=10000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=410000000000000000000000000) |

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 94 % | 92 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=27000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=940000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=427000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=27000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=427000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "reserveFactor": {
        "from": 500,
        "to": 3500
      }
    }
  },
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "maxVariableBorrowRate": {
        "from": "866000000000000000000000000",
        "to": "410000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "16000000000000000000000000",
        "to": "10000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "850000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "optimalUsageRatio": {
        "from": "940000000000000000000000000",
        "to": "920000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": "AaveV3Ethereum.POOL_ADDRESSES_PROVIDER",
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
          "previousValue": "0x0000000000009adc2b99f92f8b31cc7a00000000033c481aa41e9356b0beafd6",
          "newValue": "0x00000000000042391961d8088aae8f0500000000033c481aa41e9356b0beafd6"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b4": {
          "previousValue": "0x0000000000033ee398e498cb0719512c000000000343e1f71b0e9af814c2257f",
          "newValue": "0x000000000002074e3f8edf7ee46fd2bc000000000343e1f71b0e9af814c2257f"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec0": {
          "previousValue": "0x000000000024a9fe86bcb1aef21679af000000000363dc9783795e1b48c1e838",
          "newValue": "0x0000000000625e65e03094c706b744c1000000000363dc9a6433586919cbc50a"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec1": {
          "previousValue": "0x00000000002dae80e4d6543338d1970700000000037a4c443bc1f479e3360846",
          "newValue": "0x00000000007a9012aa74e16be8ec4e4d00000000037a4c47e96a16f88c7a6685"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec2": {
          "previousValue": "0x000000000000000000000000687e21cf000000000000000000007130241f9be0",
          "newValue": "0x000000000000000000000000687e21f3000000000000000000007130241f9be0"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec7": {
          "previousValue": "0x0000000000001cb8a287b2edc4edb7c70000000000000002fa209b674edecfa7",
          "newValue": "0x0000000000001cb8a287b2edc4edb7c70000000000000002fa6a25119775e13e"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a26": {
          "previousValue": "0x00687e21f2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687e21f2000000000003000000000000000000000000000000000000000000"
        },
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a27": {
          "previousValue": "0x000000000000000000093a8000000000000068ac467300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068ac4673000000000000687e21f3"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x947f0054faed3481ff4e76ca35f12fbe36cc665b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2": {
          "previousValue": "0x100000000000000000000103e80001adb0000007530001f4851229681fa41eaa",
          "newValue": "0x100000000000000000000103e80001adb000000753000dac851229681fa41eaa"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_USDe_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_14AUG2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FBTC.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x2a11cb67ca5c7e99dba99b50e02c11472d0f19c22ed5af42a1599a7f57e1c7a4": {
          "previousValue": "0x00000000000000000000000000000000000000000fa00000010e0000000024b8",
          "newValue": "0x00000000000000000000000000000000000000000fa00000010e0000000023f0"
        },
        "0xf37caed32e4e49c83636e0f1684f3f4a9a23c463a49eb17cd63abd50680b378b": {
          "previousValue": "0x00000000000000000000000000000000000000002134000000a0000000001f40",
          "newValue": "0x00000000000000000000000000000000000000000fa000000064000000001f40"
        }
      }
    },
    "0xb58ed8ec66e43de3fecd27e351485e7efe006f38": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": "AaveV3Ethereum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc96113eed8cab59cd8a66813bcb0ceb29f06d2e4": {
      "label": "AaveV3Ethereum.ASSETS.wstETH.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xea51d7853eefb32b6ee06b1c12e6dcca88be0ffe": {
      "label": "AaveV3Ethereum.ASSETS.WETH.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```