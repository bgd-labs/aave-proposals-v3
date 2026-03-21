## Reserve changes

### Reserve altered

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://explorer.inkonchain.com/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 18,000 ezETH | 36,000 ezETH |


#### USDC ([0x2D270e6886d130D724215A266106e6832161EAEd](https://explorer.inkonchain.com/address/0x2D270e6886d130D724215A266106e6832161EAEd))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 20,000,000 USDC | 40,000,000 USDC |
| borrowCap | 19,000,000 USDC | 38,000,000 USDC |


#### WETH ([0x4200000000000000000000000000000000000006](https://explorer.inkonchain.com/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 42.7 % | 42.5 % |
| variableRateSlope1 | 2.7 % | 2.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=27000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=427000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=425000000000000000000000000) |

#### GHO ([0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://explorer.inkonchain.com/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 20,000,000 GHO | 40,000,000 GHO |
| borrowCap | 18,000,000 GHO | 36,000,000 GHO |


## Raw diff

```json
{
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "supplyCap": {
        "from": 18000,
        "to": 36000
      }
    },
    "0x2D270e6886d130D724215A266106e6832161EAEd": {
      "borrowCap": {
        "from": 19000000,
        "to": 38000000
      },
      "supplyCap": {
        "from": 20000000,
        "to": 40000000
      }
    },
    "0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73": {
      "borrowCap": {
        "from": 18000000,
        "to": 36000000
      },
      "supplyCap": {
        "from": 20000000,
        "to": 40000000
      }
    }
  },
  "strategies": {
    "0x4200000000000000000000000000000000000006": {
      "maxVariableBorrowRate": {
        "from": "427000000000000000000000000",
        "to": "425000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "27000000000000000000000000",
        "to": "25000000000000000000000000"
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
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd2": {
          "previousValue": "0x0069415477000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069415477000000000003000000000000000000000000000000000000000000"
        },
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd3": {
          "previousValue": "0x000000000000000000093a80000000000000696f78f800000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000696f78f800000000000069415478"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981044": {
          "previousValue": "0x10000000000000000000000000001312d0000121eac003e8a506000000000000",
          "newValue": "0x10000000000000000000000000002625a0000243d58003e8a506000000000000"
        },
        "0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2": {
          "previousValue": "0x100000000000000000000003e800000465000000000103e881122af8000a0005",
          "newValue": "0x100000000000000000000003e8000008ca000000000103e881122af8000a0005"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3adf": {
          "previousValue": "0x00000000000cfb6fc0e4b281ff23ec6300000000033baa2c15f93d502240e21d",
          "newValue": "0x00000000000c0541b82339c4ad25262d00000000033baa3e2c10cae7f2fb8b36"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ae0": {
          "previousValue": "0x00000000001377d9c158a10829c4df0700000000033c734fca1a31386fb07fc5",
          "newValue": "0x00000000001206ad4ede71f66dba156200000000033c736af00431787a072508"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ae1": {
          "previousValue": "0x000000000000000000000000694151da00000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006941547800000000000000000000000000000000"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ae6": {
          "previousValue": "0x000000000000022bd24924833219431a000000000000000016f3f2591d710224",
          "newValue": "0x000000000000022bd24924833219431a000000000000000016fde34cd67f0734"
        },
        "0xd65dfe8da0b5a761df1b1a8535b7c5e4a8bdd40bd305a11fa569ad02c896b907": {
          "previousValue": "0x10000000000000000000000000001312d0000112a88003e88512000000000000",
          "newValue": "0x10000000000000000000000000002625a0000225510003e88512000000000000"
        }
      }
    },
    "0xcfdada7dcd2e785cf706badbc2b8af5084d595e9": {
      "label": "AaveV3InkWhitelabel.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.kBTC.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDG.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.wrsETH.INTEREST_RATE_STRATEGY, AaveV3InkWhitelabel.ASSETS.ezETH.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xaa544f6996e1da4967517881576aedff824813d40fbf84798b92a9de03a071fe": {
          "previousValue": "0x00000000000000000000000000000000000000000fa00000010e000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa0000000fa000000002328"
        }
      }
    }
  }
}
```