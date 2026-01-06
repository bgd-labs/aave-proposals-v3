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
          "previousValue": "0x00695d170f000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00695d170f000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb459": {
          "previousValue": "0x000000000000000000093a80000000000000698b3b9000000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000698b3b90000000000000695d1710"
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
          "previousValue": "0x000000000019ec9143f1abcfa2e0460e000000000342817865df4f01544c2b5f",
          "newValue": "0x0000000000179140b9114f1b5fb900e400000000034281da030f8a0bd5ab379e"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf5": {
          "previousValue": "0x000000000028792095595435188ac1970000000003461935e25b8d851724f675",
          "newValue": "0x000000000024cb36d4c89739980f81ec00000000034619ceeff0baef6a327a28"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf6": {
          "previousValue": "0x000000000000000000000300695d100c00000000000000000000000000000000",
          "newValue": "0x000000000000000000000300695d171000000000000000000000000000000000"
        },
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abfb": {
          "previousValue": "0x000000000000000000000934e1172d28000000000000000000000001565af4a1",
          "newValue": "0x000000000000000000000934e1172d2800000000000000000000000156c445a9"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981045": {
          "previousValue": "0x000000000006d6bb94023892640ea00200000000033bbceafcc6b34c3f3b4369",
          "newValue": "0x0000000000063793535a3c20b83e071900000000033bbcedbf12c2bfe624a01f"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981046": {
          "previousValue": "0x000000000013994963c68c0459350ec900000000033d06fa28d416c325b32f25",
          "newValue": "0x000000000011d12b8ca79d8561c49cb600000000033d0702141a3f8a0371be89"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981047": {
          "previousValue": "0x000000000000000000000500695d164e00000000000000000000000000000000",
          "newValue": "0x000000000000000000000500695d171000000000000000000000000000000000"
        },
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a3998104c": {
          "previousValue": "0x0000000000000000000016466209281f0000000000000000000000004a83d2a3",
          "newValue": "0x0000000000000000000016466209281f0000000000000000000000004a874506"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa778": {
          "previousValue": "0x00000000000811bdd3957c317ad2b33000000000033d22136899edfc5ecf179c",
          "newValue": "0x00000000000755f2653c220e3b6eb5fe00000000033d2213b1c0aa81add9ca87"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa779": {
          "previousValue": "0x0000000000154a018897d8b5b7d78d44000000000340197eb36cb211aa61c7e6",
          "newValue": "0x0000000000135a8d0a6b6b3c527d1847000000000340197f751bd9a3c2ad139e"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa77a": {
          "previousValue": "0x000000000000000000000200695d16ff00000000000000000000000000000000",
          "newValue": "0x000000000000000000000200695d171000000000000000000000000000000000"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa77f": {
          "previousValue": "0x0000000000000000000072096152c1c0000000000000000000000001f52ae427",
          "newValue": "0x0000000000000000000072096152c1c0000000000000000000000001f52cd161"
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