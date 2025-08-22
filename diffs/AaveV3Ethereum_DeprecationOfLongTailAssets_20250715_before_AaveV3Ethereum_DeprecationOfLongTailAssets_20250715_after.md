## Reserve changes

### Reserves altered

#### SNX ([0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F](https://etherscan.io/address/0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 4,000,000 $ [400000000] | 1 $ [100] |
| ltv | 49 % [4900] | 0 % [0] |
| reserveFactor | 35 % [3500] | 95 % [9500] |
| maxVariableBorrowRate | 168 % | 171 % |
| baseVariableBorrowRate | 3 % | 6 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=30000000000000000000000000&maxVariableBorrowRate=1680000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1500000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=60000000000000000000000000&maxVariableBorrowRate=1710000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F": {
      "debtCeiling": {
        "from": 400000000,
        "to": 100
      },
      "ltv": {
        "from": 4900,
        "to": 0
      },
      "reserveFactor": {
        "from": 3500,
        "to": 9500
      }
    }
  },
  "strategies": {
    "0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F": {
      "baseVariableBorrowRate": {
        "from": "30000000000000000000000000",
        "to": "60000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "1680000000000000000000000000",
        "to": "1710000000000000000000000000"
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
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea465": {
          "previousValue": "0x00000000000824433c42605f8efa6954000000000350dfa115aa8cb04b7f685a",
          "newValue": "0x000000000000d7d0f6517f84e095dd3d00000000035115c86097a61978bb294e"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea466": {
          "previousValue": "0x000000000048789442c2a36b367a3fd60000000003b831a49591cc549ba9f741",
          "newValue": "0x0000000000615fba05970a10700eab610000000003ba4ef2ca768aac8f03c73c"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea467": {
          "previousValue": "0x000000000000000000000d00686a51cb00000000000000000000950090082d92",
          "newValue": "0x000000000000000000000d00687680ab00000000000000000000950090082d92"
        },
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea46c": {
          "previousValue": "0x00000000000084df2d08f43ae8c3cf9300000000000000000000000000000000",
          "newValue": "0x00000000000084df2d08f43ae8c3cf93000000000000000561af99200e692cea"
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
        "0xa6ec75fb559f5d48b779a90884ecf3a5c30c1991569cfc396bc64fdf43341a98": {
          "previousValue": "0x00687680aa000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687680aa000000000003000000000000000000000000000000000000000000"
        },
        "0xa6ec75fb559f5d48b779a90884ecf3a5c30c1991569cfc396bc64fdf43341a99": {
          "previousValue": "0x000000000000000000093a8000000000000068a4a52b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068a4a52b000000000000687680ab"
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
    "0x947f0054faed3481ff4e76ca35f12fbe36cc665b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xa67202cdd5816eb3aaf4ba690ecc450e266895ca4e1a61ec881c233f7f7ea464": {
          "previousValue": "0x10017d784000000000000003e80000000010000000010dac81122a6219641324",
          "newValue": "0x100000000640000000000003e8000000001000000001251c81122a6219640000"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_USDe_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_14AUG2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FBTC.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x6cd63715d5f0db03eec592ada4e78050279222b9583fb20a52ef8a37c8e911b9": {
          "previousValue": "0x00000000000000000000000000000000000000003a98000005dc0000012c1194",
          "newValue": "0x00000000000000000000000000000000000000003a98000005dc000002581194"
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
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```