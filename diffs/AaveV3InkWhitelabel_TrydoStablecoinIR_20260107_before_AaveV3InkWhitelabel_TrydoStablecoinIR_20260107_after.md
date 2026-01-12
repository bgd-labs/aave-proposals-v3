## Reserve changes

### Reserve altered

#### USD₮0 ([0x0200C29006150606B650577BBE7B6248F58470c1](https://explorer.inkonchain.com/address/0x0200C29006150606B650577BBE7B6248F58470c1))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 45.5 % | 45 % |
| variableRateSlope1 | 5.5 % | 5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=455000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=50000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=450000000000000000000000000) |

#### USDC ([0x2D270e6886d130D724215A266106e6832161EAEd](https://explorer.inkonchain.com/address/0x2D270e6886d130D724215A266106e6832161EAEd))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 45.5 % | 45 % |
| variableRateSlope1 | 5.5 % | 5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=455000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=50000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=450000000000000000000000000) |

#### USDG ([0xe343167631d89B6Ffc58B88d6b7fB0228795491D](https://explorer.inkonchain.com/address/0xe343167631d89B6Ffc58B88d6b7fB0228795491D))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 55.5 % | 55 % |
| variableRateSlope1 | 5.5 % | 5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=555000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=50000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=550000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x0200C29006150606B650577BBE7B6248F58470c1": {
      "maxVariableBorrowRate": {
        "from": "455000000000000000000000000",
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "50000000000000000000000000"
      }
    },
    "0x2D270e6886d130D724215A266106e6832161EAEd": {
      "maxVariableBorrowRate": {
        "from": "455000000000000000000000000",
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "50000000000000000000000000"
      }
    },
    "0xe343167631d89B6Ffc58B88d6b7fB0228795491D": {
      "maxVariableBorrowRate": {
        "from": "555000000000000000000000000",
        "to": "550000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "50000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x1de9cb9420dd1f2ccefff9393e126b800d413b7a": {
      "label": "GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb458": {
          "previousValue": "0x00695e91d0000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00695e91d0000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb459": {
          "previousValue": "0x000000000000000000093a80000000000000698cb65100000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000698cb651000000000000695e91d1"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf4": {
          "previousValue": "0x000000000019e6a21019ff433bdbd3ad000000000342965c4351ab87eb124831",
          "newValue": "0x0000000000178bd98c77cb6869823694000000000342966c031b94893faa06e2"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf5": {
          "previousValue": "0x000000000028747e6a481289e3a6abaf00000000034639fa7fbc15e61fa1f257",
          "newValue": "0x000000000024c6fedf4212b4e324a2a30000000003463a133482ec67c14cbf1f"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf6": {
          "previousValue": "0x000000000000000000000300695e90af00000000000000000000000000000000",
          "newValue": "0x000000000000000000000300695e91d100000000000000000000000000000000"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abfb": {
          "previousValue": "0x00000000000000000000093494fd39c10000000000000000000000016ce2651f",
          "newValue": "0x00000000000000000000093494fd39c10000000000000000000000016cf35cdb"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981045": {
          "previousValue": "0x000000000009b4b91ab08c9524822a5500000000033bc25da827a3dded2d962c",
          "newValue": "0x000000000008d2db89202c35228a7a8e00000000033bc30874f97a85e1f69789"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981046": {
          "previousValue": "0x0000000000175933e6e2d151452c1b3700000000033d15d0bcb26dddc079f8a7",
          "newValue": "0x00000000001539d7c31874367a8ee7e000000000033d176c452f9fb8ad7fbe4c"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981047": {
          "previousValue": "0x000000000000000000000500695e70c300000000000000000000000000000000",
          "newValue": "0x000000000000000000000500695e91d100000000000000000000000000000000"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a3998104c": {
          "previousValue": "0x000000000000000000001393a956674f00000000000000000000000051522bcb",
          "newValue": "0x000000000000000000001393a956674f00000000000000000000000052278c55"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa778": {
          "previousValue": "0x0000000000080901382828c5cded80d500000000033d286027e3ba4cc5998450",
          "newValue": "0x0000000000074e017f88164716d53a4300000000033d286e95837ad494a588c7"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa779": {
          "previousValue": "0x0000000000153e780236872885d28ce00000000003402a30b098fc4ecc1db176",
          "newValue": "0x000000000013501085e0eebe4451e85e0000000003402a56f981d1fb7c71701a"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa77a": {
          "previousValue": "0x000000000000000000000200695e8e7300000000000000000000000000000000",
          "newValue": "0x000000000000000000000200695e91d100000000000000000000000000000000"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa77f": {
          "previousValue": "0x00000000000000000000721ef6a9906c0000000000000000000000021fa2fee3",
          "newValue": "0x00000000000000000000721ef6a9906c00000000000000000000000220043220"
        }
      }
    },
    "0xcfdada7dcd2e785cf706badbc2b8af5084d595e9": {
      "label": "AaveV3InkWhitelabel.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.kBTC.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDG.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.wrsETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.ezETH.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x21508b8977913ef2fad21ad8ad40729a198a718db58f3c42aecfa5ba00331466": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000226000000001f40",
          "newValue": "0x00000000000000000000000000000000000000001388000001f4000000001f40"
        },
        "0x3fcd0eaf5e2cf97e4157582de3fb3560da8bf54376e89fb9125e642c52b9118a": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000226000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa0000001f4000000002328"
        },
        "0xcba1a9c44d9330bd23f98606a19303bf9373d011db3344ba68033594b8c36e5d": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000226000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa0000001f4000000002328"
        }
      }
    }
  }
}
```