## Reserve changes

### Reserve altered

#### RLUSD ([0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD](https://etherscan.io/address/0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 20 % [2000] |
| baseVariableBorrowRate | 0 % | 4 % |
| variableRateSlope1 | 6.5 % | 2.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=40000000000000000000000000&maxVariableBorrowRate=565000000000000000000000000) |

#### SNX ([0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F](https://etherscan.io/address/0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 80 % | 45 % |
| maxVariableBorrowRate | 118 % | 168 % |
| variableRateSlope2 | 100 % | 150 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=1180000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=1680000000000000000000000000) |

#### USDtb ([0xC139190F447e929f090Edeb554D95AbB8b18aC1C](https://etherscan.io/address/0xC139190F447e929f090Edeb554D95AbB8b18aC1C))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 20 % [2000] |


#### CRV ([0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 70 % | 45 % |
| maxVariableBorrowRate | 317 % | 163 % |
| variableRateSlope1 | 14 % | 10 % |
| variableRateSlope2 | 300 % | 150 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=140000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=700000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=3170000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=1630000000000000000000000000) |

#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 80 % | 45 % |
| maxVariableBorrowRate | 177 % | 170 % |
| variableRateSlope1 | 22 % | 15 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=220000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=50000000000000000000000000&maxVariableBorrowRate=1770000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=50000000000000000000000000&maxVariableBorrowRate=1700000000000000000000000000) |

#### crvUSD ([0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E](https://etherscan.io/address/0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 20 % [2000] |


## Raw diff

```json
{
  "reserves": {
    "0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0xC139190F447e929f090Edeb554D95AbB8b18aC1C": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    }
  },
  "strategies": {
    "0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "40000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "25000000000000000000000000"
      }
    },
    "0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F": {
      "maxVariableBorrowRate": {
        "from": "1180000000000000000000000000",
        "to": "1680000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "800000000000000000000000000",
        "to": "450000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "1000000000000000000000000000",
        "to": "1500000000000000000000000000"
      }
    },
    "0xD533a949740bb3306d119CC777fa900bA034cd52": {
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
    "0xba100000625a3754423978a60c9317c58a424e3D": {
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
    "0x028f7886f3e937f8479efad64f31b3fe1119857a": {
      "label": "AaveV3Ethereum.ASSETS.crvUSD.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1b7d3f4b3c032a5ae656e30eea4e8e1ba376068f": {
      "label": "AaveV3Ethereum.ASSETS.CRV.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": "AaveV3Ethereum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3d3efceb4ff0966d34d9545d3a2fa2dcdbf451f2": {
      "label": "AaveV3Ethereum.ASSETS.BAL.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
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
        "0x60c4bd52853516a4ad3e3dbefa5ca3d5b5f891da2433d0d3a1077c90dd29981d": {
          "previousValue": "0x00683f69fe000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00683f69fe000000000003000000000000000000000000000000000000000000"
        },
        "0x60c4bd52853516a4ad3e3dbefa5ca3d5b5f891da2433d0d3a1077c90dd29981e": {
          "previousValue": "0x000000000000000000093a80000000000000686d8e7f00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000686d8e7f000000000000683f69ff"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8d0de040e8aad872ec3c33a3776de9152d3c34ca": {
      "label": "AaveV3Ethereum.ASSETS.SNX.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9aeb8aaa1ca38634aa8c0c8933e7fb4d61091327": {
      "label": "AaveV3Ethereum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x6073da802cfd57970e5c385150de92b75756eff0ea9d13effae07956cf21353b": {
          "previousValue": "0x000000000001cb10efe280239f12d12e0000000003655f671e207a28b24d5661",
          "newValue": "0x000000000001ddf57f60e558b7c421750000000003655fbf7a2a430c16733190"
        },
        "0x6073da802cfd57970e5c385150de92b75756eff0ea9d13effae07956cf21353c": {
          "previousValue": "0x0000000000334c77b12e0a0f1b016fe60000000004077e0873ed7dc10a652f67",
          "newValue": "0x000000000035685a47098232095fbb8800000000040789bf930e339f04a4463a"
        },
        "0x6073da802cfd57970e5c385150de92b75756eff0ea9d13effae07956cf21353d": {
          "previousValue": "0x000000000000000000000e00683f11df00000000000000000000000000000000",
          "newValue": "0x000000000000000000000e00683f69ff00000000000000000000000000000000"
        },
        "0x6073da802cfd57970e5c385150de92b75756eff0ea9d13effae07956cf213542": {
          "previousValue": "0x000000000000000000000000000000000000000000000001a1ba7e9f1e0f061a",
          "newValue": "0x000000000000000000000000000000000000000000000001ce9705a5f7f74c20"
        },
        "0x9c5488d84d2a2a7cd0c3bdfdf95e375dff32a113c880ebf8321378ed34906a20": {
          "previousValue": "0x10000000000000000000000000011e1a300002625a0003e88512000000000000",
          "newValue": "0x10000000000000000000000000011e1a300002625a0007d08512000000000000"
        },
        "0x9c5488d84d2a2a7cd0c3bdfdf95e375dff32a113c880ebf8321378ed34906a21": {
          "previousValue": "0x0000000000044813db2770c77e1feb3200000000033b7040956d3f8c5cf61dbc",
          "newValue": "0x00000000000881929ebae3db69227cba00000000033b7052f442d22a941cd2e5"
        },
        "0x9c5488d84d2a2a7cd0c3bdfdf95e375dff32a113c880ebf8321378ed34906a22": {
          "previousValue": "0x000000000011e187c356811f628aa8ec00000000033c8f6f2f4c72116b7252d7",
          "newValue": "0x000000000027f6eb7db712f9d817c32400000000033c8fbc024ed0df9eba2527"
        },
        "0x9c5488d84d2a2a7cd0c3bdfdf95e375dff32a113c880ebf8321378ed34906a23": {
          "previousValue": "0x000000000000000000002700683f61ef00000000000000000000000000000000",
          "newValue": "0x000000000000000000002700683f69ff00000000000000000000000000000000"
        },
        "0x9c5488d84d2a2a7cd0c3bdfdf95e375dff32a113c880ebf8321378ed34906a28": {
          "previousValue": "0x000000000000000000000000000000000000000000000023da4474bf6caa17e5",
          "newValue": "0x00000000000000000000000000000000000000000000002428be37c72b05d44f"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea465": {
          "previousValue": "0x00000000000637f147dab7dd33f7ed7100000000035004c2291d6dc883048145",
          "newValue": "0x000000000008cb072c41fd3140be2abd000000000350154de8a58410f6cee9dd"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea466": {
          "previousValue": "0x000000000034e07a013a278a6e0894650000000003b04a8f5ec010dcaaf055cf",
          "newValue": "0x00000000004aba9a2bd9a3a07df110280000000003b0e74655b5a5b2a3c0ac42"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea467": {
          "previousValue": "0x000000000000000000000d00683a891b00000000000000000000950090082d92",
          "newValue": "0x000000000000000000000d00683f69ff00000000000000000000950090082d92"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea46c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000001c46aae4de7701d13"
        },
        "0xbe8e21c71475cd42602a4439a4c0329a6ce30e27bc0c32121fc9abce5eef5543": {
          "previousValue": "0x100000000000000000000000000004c4b400002625a003e88512000000000000",
          "newValue": "0x100000000000000000000000000004c4b400002625a007d08512000000000000"
        },
        "0xbe8e21c71475cd42602a4439a4c0329a6ce30e27bc0c32121fc9abce5eef5544": {
          "previousValue": "0x000000000017cb24a489cde01e8645f00000000003b87da618ee4718bf7ccc6f",
          "newValue": "0x00000000001526989c8b3ed9147a6ef30000000003b8885ca05a61b0ddaaf9f5"
        },
        "0xbe8e21c71475cd42602a4439a4c0329a6ce30e27bc0c32121fc9abce5eef5545": {
          "previousValue": "0x000000000026c6461493fbac399c27f50000000003e0cee70fdf666ffdcd4604",
          "newValue": "0x000000000026c67ff7bf40476d240e2e0000000003e0e119b2b2ebcfa6fff763"
        },
        "0xbe8e21c71475cd42602a4439a4c0329a6ce30e27bc0c32121fc9abce5eef5546": {
          "previousValue": "0x000000000000000000001a00683eadd70000000000000000347d5a6f62b86761",
          "newValue": "0x000000000000000000001a00683f69ff0000000000000000347d5a6f62b86761"
        },
        "0xbe8e21c71475cd42602a4439a4c0329a6ce30e27bc0c32121fc9abce5eef554b": {
          "previousValue": "0x000000000000000000000000000000000000000000000000cb00d396272cdd74",
          "newValue": "0x000000000000000000000000000000000000000000000000e955fb2f48d9b1c3"
        },
        "0xd76b69b0f7b1c04da356d786043ab33773b3ac2ca4b62d97fc88b41c43fd1250": {
          "previousValue": "0x00000000001489417a7c695519ce00c5000000000365626e4e8d4cab93daf012",
          "newValue": "0x000000000016287e7ba5618a04cb35ef000000000365637a5b29021284636db6"
        },
        "0xd76b69b0f7b1c04da356d786043ab33773b3ac2ca4b62d97fc88b41c43fd1251": {
          "previousValue": "0x000000000055c2ed8752c618f78050850000000003fbe75b385a4c9aea7792f5",
          "newValue": "0x00000000005c88b7f68e2e969ea264620000000003fbec7c71e42ecff26a34fc"
        },
        "0xd76b69b0f7b1c04da356d786043ab33773b3ac2ca4b62d97fc88b41c43fd1252": {
          "previousValue": "0x000000000000000000000b00683f52a7000000000000000290e6136a435f1ba0",
          "newValue": "0x000000000000000000000b00683f69ff000000000000000290e6136a435f1ba0"
        },
        "0xd76b69b0f7b1c04da356d786043ab33773b3ac2ca4b62d97fc88b41c43fd1257": {
          "previousValue": "0x00000000000000000000000000000000000000000000005825bf715d13fac5d8",
          "newValue": "0x00000000000000000000000000000000000000000000005a4722185e72dcddf9"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e1": {
          "previousValue": "0x10000000000000000000000000002faf080002625a0003e88512000000000000",
          "newValue": "0x10000000000000000000000000002faf080002625a0007d08512000000000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e2": {
          "previousValue": "0x00000000001a48a11916b7295caab07e00000000033c6e91892716c2f140c67a",
          "newValue": "0x0000000000175fd4d0e208a7a4518d0600000000033cd12fb7179c2fa53ea0f8"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e3": {
          "previousValue": "0x00000000002a90a552aeac957a4fac2700000000033d0b47b7b1c9c700060df3",
          "newValue": "0x00000000002a93389e482f0a1217417e00000000033dab2a23bb92a3df5c7a17"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e4": {
          "previousValue": "0x000000000000000000002a0068385f3b00000000000000000000000000000000",
          "newValue": "0x000000000000000000002a00683f69ff00000000000000000000000000000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000013044cb7437216a"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x2bc93a8060526cefdf8802183664660d7d7310808def67df12894f0e5193b433": {
          "previousValue": "0x00000000000000000000000000000000000000003a9800000898000001f41f40",
          "newValue": "0x00000000000000000000000000000000000000003a98000005dc000001f41194"
        },
        "0x4e4f22273bf5bc307ce4d44de9b696fde788cba6119ef3bd24dc8a4ace26ced8": {
          "previousValue": "0x000000000000000000000000000000000000000013880000028a000000001f40",
          "newValue": "0x00000000000000000000000000000000000000001388000000fa000001901f40"
        },
        "0x6cd63715d5f0db03eec592ada4e78050279222b9583fb20a52ef8a37c8e911b9": {
          "previousValue": "0x00000000000000000000000000000000000000002710000005dc0000012c1f40",
          "newValue": "0x00000000000000000000000000000000000000003a98000005dc0000012c1194"
        },
        "0x70c3dba262fa5eaaf3e393830b86a1923f032bbcdc463b5d2b22ed5f11b1e685": {
          "previousValue": "0x00000000000000000000000000000000000000007530000005780000012c1b58",
          "newValue": "0x00000000000000000000000000000000000000003a98000003e80000012c1194"
        }
      }
    },
    "0xac725cb59d16c81061bdea61041a8a5e73da9ec6": {
      "label": "AaveV3Ethereum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xbdfe7ad7976d5d7e0965ea83a81ca1bcff7e84a9": {
      "label": "AaveV3Ethereum.ASSETS.RLUSD.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": "AaveV3Ethereum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR_IMPL, AaveV3EthereumEtherFi.POOL_CONFIGURATOR_IMPL, AaveV3EthereumLido.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xea85a065f87fe28aa8fbf0d6c7dec472b106252c": {
      "label": "AaveV3Ethereum.ASSETS.USDtb.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```