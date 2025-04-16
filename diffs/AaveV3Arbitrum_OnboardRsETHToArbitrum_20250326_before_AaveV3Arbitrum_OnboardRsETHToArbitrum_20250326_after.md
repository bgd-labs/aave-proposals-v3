## Reserve changes

### Reserves added

#### rsETH ([0x4186BFC76E2E237523CBC30FD220FE055156b41F](https://arbiscan.io/address/0x4186BFC76E2E237523CBC30FD220FE055156b41F))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 900 rsETH |
| borrowCap | 1 rsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089](https://arbiscan.io/address/0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089) |
| oracleDecimals | 8 |
| oracleDescription | Capped rsETH / ETH / USD |
| oracleLatestAnswer | 2089.7980069 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0x6b030Ff3FB9956B1B69f475B77aE0d3Cf2CC5aFa](https://arbiscan.io/address/0x6b030Ff3FB9956B1B69f475B77aE0d3Cf2CC5aFa) |
| variableDebtToken | [0x80cA0d8C38d2e2BcbaB66aA1648Bd1C7160500FE](https://arbiscan.io/address/0x80cA0d8C38d2e2BcbaB66aA1648Bd1C7160500FE) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F](https://arbiscan.io/address/0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F) |
| aTokenName | Aave Arbitrum rsETH |
| aTokenSymbol | aArbrsETH |
| aTokenUnderlyingBalance | 0.035 rsETH [35000000000000000] |
| id | 18 |
| isPaused | false |
| variableDebtTokenName | Aave Arbitrum Variable Debt rsETH |
| variableDebtTokenSymbol | variableDebtArbrsETH |
| virtualAccountingActive | true |
| virtualBalance | 0.035 rsETH [35000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH wstETH(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH/wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/wstETH |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | rsETH |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "256",
        "collateralBitmap": "262144",
        "eModeCategory": 5,
        "label": "rsETH/wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0x4186BFC76E2E237523CBC30FD220FE055156b41F": {
      "from": null,
      "to": {
        "aToken": "0x6b030Ff3FB9956B1B69f475B77aE0d3Cf2CC5aFa",
        "aTokenName": "Aave Arbitrum rsETH",
        "aTokenSymbol": "aArbrsETH",
        "aTokenUnderlyingBalance": "35000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 18,
        "interestRateStrategy": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089",
        "oracleDecimals": 8,
        "oracleDescription": "Capped rsETH / ETH / USD",
        "oracleLatestAnswer": "208979800690",
        "reserveFactor": 2000,
        "supplyCap": 900,
        "symbol": "rsETH",
        "underlying": "0x4186BFC76E2E237523CBC30FD220FE055156b41F",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x80cA0d8C38d2e2BcbaB66aA1648Bd1C7160500FE",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt rsETH",
        "variableDebtTokenSymbol": "variableDebtArbrsETH",
        "virtualAccountingActive": true,
        "virtualBalance": "35000000000000000"
      }
    }
  },
  "strategies": {
    "0x4186BFC76E2E237523CBC30FD220FE055156b41F": {
      "from": null,
      "to": {
        "address": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x048f2228d7bf6776f99ab50cb1b1eab4d1d4ca73": {
      "label": "AaveV3Arbitrum.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x4f0cc385ee424427359f4888043b57df0ebfac77e7c2038928cd14a95a28c1f1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xc8a30dc871102a7a97a20957ca45f43988b5087ed59cce29bf33482054987ff3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0cc2e7a263101f3ec4cff7d64ef5961ae18d1d70e854cb40c5302bf7c043d7b9": {
          "previousValue": "0x0067e46fbb000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067e46fbb000000000003000000000000000000000000000000000000000000"
        },
        "0x0cc2e7a263101f3ec4cff7d64ef5961ae18d1d70e854cb40c5302bf7c043d7ba": {
          "previousValue": "0x000000000000000000093a800000000000006812943c00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006812943c00000000000067e46fbc"
        }
      }
    },
    "0x185477906b46d9b8de0deb73a1bbfb87b5b51bc3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x64fc867f7f841e58bae4910ccd8e104b40d080897d387f643f816685047ca8d2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000002000000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241cf": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d0": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000007c58508723800000000000000000000000000000000000"
        }
      }
    },
    "0x1be1798b70aee431c2986f7ff48d9d1fa350786a": {
      "label": "AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2",
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000007c585087238000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520417262697472756d20727345544800000000000000000000000026"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6141726272734554480000000000000000000000000000000000000000000012"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000929ec64c34a17401f460460d4b9390518e5b473e12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7a88eb25d8c62e815bf75ed74b7825ea4de1b1e6fc8135698d9d9979755d45f7"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000053d55f9b5af8694c503eb288a1b7e552f590710"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000004186bfc76e2e237523cbc30fd220fe055156b41f"
        },
        "0x8017e81955ee9285d3a8d26b6bbb1613eb9d7ba0a27adaad804d34e923709e14": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce80000000000000000000000007c585087238000"
        }
      }
    },
    "0x3607e46698d218b3a5cae44bf381475c0a5e2ca7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3a917e6b5732dfcc4a45257e3930979fae6a3737": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4186bfc76e2e237523cbc30fd220fe055156b41f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4577033f7ea062ba7413a5c282708829ad9f9d30c4b813e7322e5a963a502ad4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000007c585087238000"
        },
        "0x793d61c98fd42db7a7383499c38d13f84d26e83823ab121a6db4129073291f26": {
          "previousValue": "0x000000000000000000000000000000000000000000000000007c585087238000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x7a457e545dd44d7b465027d5433114d3678c24ca445f73a5a8afb889a2837672": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x429f16dba3b9e1900087cbaa7b50d38bc60fb73f": {
      "label": "AaveV3Arbitrum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.MAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDCn.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ARB.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ezETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x1d8d29598d76da51f71b1806157e64074686cbc0315577173c92a1aa65a8f97c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000003e8000000001194"
        }
      }
    },
    "0x5e76e98e0963ecdc6a065d1435f84065b7523f39": {
      "label": "AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2",
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000035": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x92c6a83ef94ea3ab13635f6b1bdf934b0222022a943dc7f676166d72151435f5"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000004186bfc76e2e237523cbc30fd220fe055156b41f"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744172627273455448000000000000000000000028"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000929ec64c34a17401f460460d4b9390518e5b473e12"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520417262697472756d205661726961626c6520446562742072734554"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4800000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x5f4d15d761528c57a5c30c43c1dab26fc5452731": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x639fe6ab55c921f74e7fac1ee960c0b6293ba612": {
      "label": "AaveV3Arbitrum.ASSETS.WETH.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6b030ff3fb9956b1b69f475b77ae0d3cf2cc5afa": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001be1798b70aee431c2986f7ff48d9d1fa350786a",
          "label": "Implementation slot"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7f775bb7af2e7e09d5dc9506c95516159a5ca0d0": {
      "label": "AaveV3Arbitrum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000040000277424ea2422"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f7773744554480000000000000000000000000000000000000018"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000100"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241ce": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e800000038400000000107d0811229fe000a0005"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241cf": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d0": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d1": {
          "previousValue": "0x0000000000000000000012000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000120067e46fbc00000000000000000000000000000000"
        }
      }
    },
    "0x80ca0d8c38d2e2bcbab66aa1648bd1c7160500fe": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000005e76e98e0963ecdc6a065d1435f84065b7523f39",
          "label": "Implementation slot"
        }
      }
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Arbitrum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x929ec64c34a17401f460460d4b9390518e5b473e": {
      "label": "AaveV3Arbitrum.DEFAULT_INCENTIVES_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Arbitrum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb4b0cbca864c2eb0c0342608d92490c034ac1089": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb56c2f0b653b2e0b10c9b928c8580ac5df02c7c7": {
      "label": "AaveV3Arbitrum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x1d8d29598d76da51f71b1806157e64074686cbc0315577173c92a1aa65a8f97c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b4b0cbca864c2eb0c0342608d92490c034ac1089"
        }
      }
    },
    "0xdf8a3fc9bc6fa89f1b630e58f6eb4b874f24c165": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Arbitrum.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000001200000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000001300000000000009c4"
        },
        "0x0adda2a6278b08f6534d82b0eca7b85adfdf06eb4772353fece45ca26b009ccf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000004186bfc76e2e237523cbc30fd220fe055156b41f"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241cf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000012000000000000000000000000000000000000000000"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006b030ff3fb9956b1b69f475b77ae0d3cf2cc5afa"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000080ca0d8c38d2e2bcbab66aa1648bd1c7160500fe"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000429f16dba3b9e1900087cbaa7b50d38bc60fb73f"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": "AaveV3Arbitrum.ACL_ADMIN, GovernanceV3Arbitrum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```