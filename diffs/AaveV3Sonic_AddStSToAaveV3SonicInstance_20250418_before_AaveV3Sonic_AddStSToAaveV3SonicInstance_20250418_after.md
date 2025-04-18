## Reserve changes

### Reserves added

#### stS ([0xE5DA20F15420aD15DE0fa650600aFc998bbE3955](https://sonicscan.org//address/0xE5DA20F15420aD15DE0fa650600aFc998bbE3955))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 30,000,000 stS |
| borrowCap | 1 stS |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a](https://sonicscan.org//address/0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a) |
| oracleDecimals | 8 |
| oracleDescription | Capped stS / S / USD |
| oracleLatestAnswer | 0.48048357 |
| usageAsCollateralEnabled | true |
| ltv | 66 % [6600] |
| liquidationThreshold | 68 % [6800] |
| liquidationBonus | 10 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0xeAa74D7F42267eB907092AF4Bc700f667EeD0B8B](https://sonicscan.org//address/0xeAa74D7F42267eB907092AF4Bc700f667EeD0B8B) |
| variableDebtToken | [0x333cFdCB6457C409e4f0C88F3806252bEe5fe425](https://sonicscan.org//address/0x333cFdCB6457C409e4f0C88F3806252bEe5fe425) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xdFf435BCcf782f11187D3a4454d96702eD78e092](https://sonicscan.org//address/0xdFf435BCcf782f11187D3a4454d96702eD78e092) |
| aTokenName | Aave Sonic stS |
| aTokenSymbol | aSonstS |
| aTokenUnderlyingBalance | 0 stS [0] |
| id | 3 |
| isPaused | false |
| variableDebtTokenName | Aave Sonic Variable Debt stS |
| variableDebtTokenSymbol | variableDebtSonstS |
| virtualAccountingActive | true |
| virtualBalance | 0 stS [0] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: stS/wS(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | stS/wS |
| eMode.ltv | - | 87 % |
| eMode.liquidationThreshold | - | 90 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wS |
| eMode.collateralBitmap | - | stS |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "8",
        "eModeCategory": 1,
        "label": "stS/wS",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9000,
        "ltv": 8700
      }
    }
  },
  "reserves": {
    "0xE5DA20F15420aD15DE0fa650600aFc998bbE3955": {
      "from": null,
      "to": {
        "aToken": "0xeAa74D7F42267eB907092AF4Bc700f667EeD0B8B",
        "aTokenName": "Aave Sonic stS",
        "aTokenSymbol": "aSonstS",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 3,
        "interestRateStrategy": "0xdFf435BCcf782f11187D3a4454d96702eD78e092",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 6800,
        "ltv": 6600,
        "oracle": "0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a",
        "oracleDecimals": 8,
        "oracleDescription": "Capped stS / S / USD",
        "oracleLatestAnswer": "48048357",
        "reserveFactor": 1000,
        "supplyCap": 30000000,
        "symbol": "stS",
        "underlying": "0xE5DA20F15420aD15DE0fa650600aFc998bbE3955",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x333cFdCB6457C409e4f0C88F3806252bEe5fe425",
        "variableDebtTokenName": "Aave Sonic Variable Debt stS",
        "variableDebtTokenSymbol": "variableDebtSonstS",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xE5DA20F15420aD15DE0fa650600aFc998bbE3955": {
      "from": null,
      "to": {
        "address": "0xdFf435BCcf782f11187D3a4454d96702eD78e092",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x0846c28dd54dea4fd7fb31bcc5eb81673d68c695": {
      "label": "GovernanceV3Sonic.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x0bdbff19543b20d0bc2d1ea08dee2be4c0b76743": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x333cfdcb6457c409e4f0c88f3806252bee5fe425": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000cb85c501b3a5e9851850d66648d69b26a4c90942",
          "label": "Implementation slot"
        }
      }
    },
    "0x3a790a47c4d531fd333fad24f70b0ccb521b3b5a": {
      "label": "AaveV3Sonic.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x46dcd5f4600319b02649fd76b55aa6c1035ca478": {
      "label": "AaveV3Sonic.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000082774232821fc"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7374532f7753000000000000000000000000000000000000000000000000000c"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8001c9c38000000000103e881122af81a9019c8"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b1": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b2": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b3": {
          "previousValue": "0x0000000000000000000003000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000030068021e3b00000000000000000000000000000000"
        }
      }
    },
    "0x50c70feb95abc1a92fc30b9acc41bd349e5de2f0": {
      "label": "AaveV3Sonic.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5362dbb1e601abf3a4c14c22ffeda64042e5eaa3": {
      "label": "AaveV3Sonic.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5ba5d5213b47dfe020b1f8d6fb54db3f74f9ea9a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5c2e738f6e27bce0f7558051bf90605dd6176900": {
      "label": "AaveV3Sonic.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5cc4f782cfe249286476a7effd9d7bd215768194": {
      "label": "AaveV3Sonic.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7b62461a3570c6ac8a9f8330421576e417b71ee7": {
      "label": "AaveV3Sonic.ACL_ADMIN, GovernanceV3Sonic.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x91fc11136d5615575a0fc5981ab5c0c54418e2c6": {
      "label": "AaveV3Sonic.DEFAULT_A_TOKEN_IMPL_REV_1",
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
          "newValue": "0x4161766520536f6e69632073745300000000000000000000000000000000001c"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61536f6e7374530000000000000000000000000000000000000000000000000e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000024bd6e9ca54f1737467def82dca9702925b3aa5912"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x3ca20e75562b99b9d7da117802508e83423ab60085d05f3b54de8d08aab95289"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001ab55bbdd5df0782bbcf73553af93bc6b29a286b"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e5da20f15420ad15de0fa650600afc998bbe3955"
        }
      }
    },
    "0xc76dfb89ff298145b417d221b2c747d84952e01d": {
      "label": "AaveV3Sonic.ASSETS.wS.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xcb85c501b3a5e9851850d66648d69b26a4c90942": {
      "label": "AaveV3Sonic.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
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
          "newValue": "0x624ddf30b04af21bbf4bc2ca98b8dd7002e84cd09cbef9cc766798891269aef6"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e5da20f15420ad15de0fa650600afc998bbe3955"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520536f6e6963205661726961626c6520446562742073745300000038"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274536f6e7374530000000000000000000000000024"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000024bd6e9ca54f1737467def82dca9702925b3aa5912"
        }
      }
    },
    "0xd3a0a19cdb7d1615f30988763bea5f8fecc17a87": {
      "label": "AaveV3Sonic.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x3245a93b6d726086dcdd9b678f91d397130aea29811e588831357ca7295c7e97": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x3bae99625b9c606a82f4dd535f61d31e3c7bbadd7b604d255a1c1931874a0d1f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0xd5f7fc8ba92756a34693baa386edcc8dd5b3f141": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x185706433352a93b67f640044980cccef35582c5471e58f029197238c46526bf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000ad78ebc5ac6200000"
        }
      }
    },
    "0xd63f7658c66b2934bd234d79d06aef5290734b30": {
      "label": "AaveV3Sonic.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x62e94e882e13721f46d33652cb7b3bb78146e831a2be59c44508df5f2fa4f005": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000005ba5d5213b47dfe020b1f8d6fb54db3f74f9ea9a"
        }
      }
    },
    "0xdff435bccf782f11187d3a4454d96702ed78e092": {
      "label": "AaveV3Sonic.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Sonic.ASSETS.USDCe.INTEREST_RATE_STRATEGY, AaveV3Sonic.ASSETS.wS.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x62e94e882e13721f46d33652cb7b3bb78146e831a2be59c44508df5f2fa4f005": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000003e8000000001194"
        }
      }
    },
    "0xe5da20f15420ad15de0fa650600afc998bbe3955": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xeaa74d7f42267eb907092af4bc700f667eed0b8b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000091fc11136d5615575a0fc5981ab5c0c54418e2c6",
          "label": "Implementation slot"
        }
      }
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000030000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000040000000000000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000003000000000000000000000000000000000000000000"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000eaa74d7f42267eb907092af4bc700f667eed0b8b"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000333cfdcb6457c409e4f0c88f3806252bee5fe425"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000dff435bccf782f11187d3a4454d96702ed78e092"
        },
        "0xbbfe9c7193e6c76e11ab53d1ab9a0207f201ec122eca4a35e912f449f93173b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xbc2f57311c21670184a5dbcdfc5939827a8f57c97f69166be8694e2ce000cebc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e5da20f15420ad15de0fa650600afc998bbe3955"
        }
      }
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xcbc4e5fb02c3d1de23a9f1e014b4d2ee5aeaea9505df5e855c9210bf472495af": {
          "previousValue": "0x0068021e3a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068021e3a000000000003000000000000000000000000000000000000000000"
        },
        "0xcbc4e5fb02c3d1de23a9f1e014b4d2ee5aeaea9505df5e855c9210bf472495b0": {
          "previousValue": "0x000000000000000000093a80000000000000683042bb00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683042bb00000000000068021e3b"
        }
      }
    }
  }
}
```