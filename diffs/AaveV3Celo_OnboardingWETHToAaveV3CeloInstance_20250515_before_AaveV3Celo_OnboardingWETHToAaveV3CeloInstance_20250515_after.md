## Reserve changes

### Reserves added

#### WETH ([0xD221812de1BD094f35587EE8E174B07B6167D9Af](https://celoscan.io/address/0xD221812de1BD094f35587EE8E174B07B6167D9Af))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 500 WETH |
| borrowCap | 450 WETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x1FcD30A73D67639c1cD89ff5746E7585731c083B](https://celoscan.io/address/0x1FcD30A73D67639c1cD89ff5746E7585731c083B) |
| oracleDecimals | 8 |
| oracleDescription | ETH / USD |
| oracleLatestAnswer | 2528.09 |
| usageAsCollateralEnabled | true |
| ltv | 78 % [7800] |
| liquidationThreshold | 80 % [8000] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0xf385280F36e009C157697D25E0B802EfaBfd789c](https://celoscan.io/address/0xf385280F36e009C157697D25E0B802EfaBfd789c) |
| variableDebtToken | [0x6508cff7c5FbA053Af00a4E894500e6fA00274B7](https://celoscan.io/address/0x6508cff7c5FbA053Af00a4E894500e6fA00274B7) |
| borrowingEnabled | true |
| isBorrowableInIsolation | true |
| interestRateStrategy | [0x8B62D241Bf59f40991DCd18531683156d7013355](https://celoscan.io/address/0x8B62D241Bf59f40991DCd18531683156d7013355) |
| aTokenName | Aave Celo WETH |
| aTokenSymbol | aCelWETH |
| aTokenUnderlyingBalance | 0 WETH [0] |
| id | 5 |
| isPaused | false |
| variableDebtTokenName | Aave Celo Variable Debt WETH |
| variableDebtTokenSymbol | variableDebtCelWETH |
| virtualAccountingActive | true |
| virtualBalance | 0 WETH [0] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 82.7 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 2.7 % |
| variableRateSlope2 | 80 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=27000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=827000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0xD221812de1BD094f35587EE8E174B07B6167D9Af": {
      "from": null,
      "to": {
        "aToken": "0xf385280F36e009C157697D25E0B802EfaBfd789c",
        "aTokenName": "Aave Celo WETH",
        "aTokenSymbol": "aCelWETH",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 450,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 5,
        "interestRateStrategy": "0x8B62D241Bf59f40991DCd18531683156d7013355",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 8000,
        "ltv": 7800,
        "oracle": "0x1FcD30A73D67639c1cD89ff5746E7585731c083B",
        "oracleDecimals": 8,
        "oracleDescription": "ETH / USD",
        "oracleLatestAnswer": "252809000000",
        "reserveFactor": 1500,
        "supplyCap": 500,
        "symbol": "WETH",
        "underlying": "0xD221812de1BD094f35587EE8E174B07B6167D9Af",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x6508cff7c5FbA053Af00a4E894500e6fA00274B7",
        "variableDebtTokenName": "Aave Celo Variable Debt WETH",
        "variableDebtTokenSymbol": "variableDebtCelWETH",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xD221812de1BD094f35587EE8E174B07B6167D9Af": {
      "from": null,
      "to": {
        "address": "0x8B62D241Bf59f40991DCd18531683156d7013355",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "827000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "27000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x1df462e2712496373a347f8ad10802a5e95f053d": {
      "label": "AaveV3Celo.ACL_ADMIN, GovernanceV3Celo.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1e693d088cefd1e95ba4c4a5f7eea41a1ec37e8b": {
      "label": "AaveV3Celo.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x63a15bbb2897bf2cbca7bae720ee49b9784b4ce8462067ce5d3190a0c10a5207": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001fcd30a73d67639c1cd89ff5746e7585731c083b"
        }
      }
    },
    "0x1fcd30a73d67639c1cd89ff5746e7585731c083b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e59a31363e2ad014dcbc521c4a0d5757d9f3402": {
      "label": "AaveV3Celo.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3f662aa079a9619f10bff4848910195c52cb2fb4": {
      "label": "AaveV3Celo.DEFAULT_A_TOKEN_IMPL_REV_1",
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652043656c6f205745544800000000000000000000000000000000001c"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6143656c57455448000000000000000000000000000000000000000000000010"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000004725a0fdbeb14a77964bc1c221ee3a798226310312"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xccb99b8240ef866062fd54b086f2c358fd39bd02e26da83c02bca99c01157d5e"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c959439207da5341b74adcdac59016aa9be7e9e7"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d221812de1bd094f35587ee8e174b07b6167d9af"
        }
      }
    },
    "0x44d38b18a99e50e51b99f05c1f418db26ded315f": {
      "label": "AaveV3Celo.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052874": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e80000001f40000001c205dca51229fe1f401e78"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052875": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052876": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052877": {
          "previousValue": "0x0000000000000000000005000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000050068265ea000000000000000000000000000000000"
        }
      }
    },
    "0x4d96b289326603e18762a49e57a6b7073220312e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x50b8ed003a371cc498c57518e3581a059834c70c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000050000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000060000000000000000"
        },
        "0x426fb85b9ffd4afdf007eb9b61285b9cbd06153f94ac272e73c9e2c3e978fe97": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d221812de1bd094f35587ee8e174b07b6167d9af"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052875": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052876": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052877": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000005000000000000000000000000000000000000000000"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe6052878": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f385280f36e009c157697d25e0b802efabfd789c"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe605287a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006508cff7c5fba053af00a4e894500e6fa00274b7"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe605287b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000008b62d241bf59f40991dcd18531683156d7013355"
        },
        "0xb430fce07ae1bb3b095acf9d2fb6faa55089d04937161173e88e141fe605287d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x6508cff7c5fba053af00a4e894500e6fa00274b7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000008ff70ee5f8b607844a094a938e4ded76aebca5f0",
          "label": "Implementation slot"
        }
      }
    },
    "0x7567e3434cc1bef724ab595e6072367ef4914691": {
      "label": "AaveV3Celo.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7a12dcfd73c1b4cddf294da4cfce75fcabba314c": {
      "label": "AaveV3Celo.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x87f6224536d9bd1d4fe6052e06f9647b51843e33": {
      "label": "AaveV3Celo.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8b62d241bf59f40991dcd18531683156d7013355": {
      "label": "AaveV3Celo.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.cEUR.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.cUSD.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.CELO.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x63a15bbb2897bf2cbca7bae720ee49b9784b4ce8462067ce5d3190a0c10a5207": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000001f400000010e000000002328"
        }
      }
    },
    "0x8ff70ee5f8b607844a094a938e4ded76aebca5f0": {
      "label": "AaveV3Celo.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000035": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xd42b7a5b6bce9cfcb00bb69a70150e8ee0ff966eddc9de4543cf2c650f7d2d64"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d221812de1bd094f35587ee8e174b07b6167d9af"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652043656c6f205661726961626c652044656274205745544800000038"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c654465627443656c5745544800000000000000000000000026"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000004725a0fdbeb14a77964bc1c221ee3a798226310312"
        }
      }
    },
    "0x9e04cb339163b06068397d9b6af2da78440954e0": {
      "label": "AaveV3Celo.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0xbec4266a736212f2388f9db16980aea047fac15dd800ac06b366769493ebb087": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xe7bf8d803643eb1393b5268d6f83de100a45960fd08e6b11139dae3d001a259e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x9f7cf9417d5251c59fe94fb9147feee1aad9cea5": {
      "label": "AaveV3Celo.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xd221812de1bd094f35587ee8e174b07b6167d9af": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x50399b528b7b13cec2e4f00cbdf2f58f56e8711e1420e606a35d38efb791b85b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000b1a2bc2ec50000"
        }
      }
    },
    "0xda4b6024aa06f7565bbcaad9b8be24c3c229aab5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772465": {
          "previousValue": "0x0068265e9f000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068265e9f000000000003000000000000000000000000000000000000000000"
        },
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772466": {
          "previousValue": "0x000000000000000000093a800000000000006854832000000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006854832000000000000068265ea0"
        }
      }
    },
    "0xe48e10834c04e394a04bf22a565d063d40b9fa42": {
      "label": "GovernanceV3Celo.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf385280f36e009c157697d25e0b802efabfd789c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000003f662aa079a9619f10bff4848910195c52cb2fb4",
          "label": "Implementation slot"
        }
      }
    }
  }
}
```