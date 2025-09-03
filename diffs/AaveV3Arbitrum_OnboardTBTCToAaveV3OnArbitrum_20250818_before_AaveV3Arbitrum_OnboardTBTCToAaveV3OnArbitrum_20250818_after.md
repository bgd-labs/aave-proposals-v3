## Reserve changes

### Reserves added

#### tBTC ([0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40](https://arbiscan.io/address/0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50 tBTC |
| borrowCap | 25 tBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x6ce185860a4963106506C203335A2910413708e9](https://arbiscan.io/address/0x6ce185860a4963106506C203335A2910413708e9) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 116364.84410909 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0x62fC96b27a510cF4977B59FF952Dc32378Cc221d](https://arbiscan.io/address/0x62fC96b27a510cF4977B59FF952Dc32378Cc221d) |
| variableDebtToken | [0xB5b46F918C2923fC7f26DB76e8a6A6e9C4347Cf9](https://arbiscan.io/address/0xB5b46F918C2923fC7f26DB76e8a6A6e9C4347Cf9) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F](https://arbiscan.io/address/0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F) |
| aTokenName | Aave Arbitrum tBTC |
| aTokenSymbol | aArbtBTC |
| aTokenUnderlyingBalance | 0.001 tBTC [1000000000000000] |
| id | 19 |
| isPaused | false |
| variableDebtTokenName | Aave Arbitrum Variable Debt tBTC |
| variableDebtTokenSymbol | variableDebtArbtBTC |
| virtualBalance | 0.001 tBTC [1000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40": {
      "from": null,
      "to": {
        "aToken": "0x62fC96b27a510cF4977B59FF952Dc32378Cc221d",
        "aTokenName": "Aave Arbitrum tBTC",
        "aTokenSymbol": "aArbtBTC",
        "aTokenUnderlyingBalance": "1000000000000000",
        "borrowCap": 25,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 19,
        "interestRateStrategy": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7300,
        "oracle": "0x6ce185860a4963106506C203335A2910413708e9",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": "11636484410909",
        "reserveFactor": 2000,
        "supplyCap": 50,
        "symbol": "tBTC",
        "underlying": "0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xB5b46F918C2923fC7f26DB76e8a6A6e9C4347Cf9",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt tBTC",
        "variableDebtTokenSymbol": "variableDebtArbtBTC",
        "virtualBalance": "1000000000000000"
      }
    }
  },
  "strategies": {
    "0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40": {
      "from": null,
      "to": {
        "address": "0x429F16dBA3B9e1900087Cbaa7b50D38Bc60fB73F",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3040000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x034fd14b9ae6bb066a1f9f85a55e990b0b25c168": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a6": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a7": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9ad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000038d7ea4c6800000000000000000000000000000000000"
        },
        "0x64fc867f7f841e58bae4910ccd8e104b40d080897d387f643f816685047ca8d2": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000028a2222aaa",
          "newValue": "0x000000000000000000000000000000000000000000000000000000a8a2222aaa"
        }
      }
    },
    "0x048f2228d7bf6776f99ab50cb1b1eab4d1d4ca73": {
      "label": "AaveV3Arbitrum.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x3a8719f34b284fb497d2571e30abc2db0f7d19edc09efd5923a807dd06416b63": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xcf818572f2ea5dac8fcb296ef46c52f2ac78116ccf383b351c92aa30ec132a82": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2e": {
          "previousValue": "0x0068a36dff000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068a36dff000000000003000000000000000000000000000000000000000000"
        },
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2f": {
          "previousValue": "0x000000000000000000093a8000000000000068d1928000000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068d1928000000000000068a36e00"
        }
      }
    },
    "0x23f2818e62a48e1c19921bd7eca4d278c5ce5a12": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000038d7ea4c68000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520417262697472756d20744254430000000000000000000000000024"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6141726274425443000000000000000000000000000000000000000000000010"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xec7b0c488e3500b5e4a7ce05fde5b10ffd2645941fab8a78c8d1c626f20a391e"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006c84a8f1c29108f47a79964b5fe888d4f4d0de40"
        },
        "0x8017e81955ee9285d3a8d26b6bbb1613eb9d7ba0a27adaad804d34e923709e14": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce8000000000000000000000000038d7ea4c68000"
        }
      }
    },
    "0x429f16dba3b9e1900087cbaa7b50d38bc60fb73f": {
      "label": "AaveV3Arbitrum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.MAI.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.USDCn.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ARB.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Arbitrum.ASSETS.rsETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xe354fb092c21010075058e72eff182a629d2f1c18ff31ec8c377624ae6ba6a04": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000753000000190000000001194"
        }
      }
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5f4d15d761528c57a5c30c43c1dab26fc5452731": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x62fc96b27a510cf4977b59ff952dc32378cc221d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000023f2818e62a48e1c19921bd7eca4d278c5ce5a12",
          "label": "Implementation slot"
        }
      }
    },
    "0x6c84a8f1c29108f47a79964b5fe888d4f4d0de40": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6ce185860a4963106506c203335a2910413708e9": {
      "label": "AaveV3Arbitrum.ASSETS.WBTC.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
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
    "0x942d00008d658dbb40745bbec89a93c253f9b882": {
      "label": null,
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
    "0xacd1a67bd377c6a4397b486f8b9afabde49b8933": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000035": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xf30ddc27ccb19db01a4ed9498600e06b326f131da33d645f1664828074f62594"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006c84a8f1c29108f47a79964b5fe888d4f4d0de40"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744172627442544300000000000000000000000026"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520417262697472756d205661726961626c6520446562742074425443"
        }
      }
    },
    "0xb56c2f0b653b2e0b10c9b928c8580ac5df02c7c7": {
      "label": "AaveV3Arbitrum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xe354fb092c21010075058e72eff182a629d2f1c18ff31ec8c377624ae6ba6a04": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006ce185860a4963106506c203335a2910413708e9"
        }
      }
    },
    "0xb5b46f918c2923fc7f26db76e8a6a6e9c4347cf9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000acd1a67bd377c6a4397b486f8b9afabde49b8933",
          "label": "Implementation slot"
        }
      }
    },
    "0xce142f1e750522a3e7ed7305a224ae88dd9f6ce8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e800000003200000001907d0811229fe1e781c84"
        }
      }
    },
    "0xda534b567099ca481384133bc121d5843f681365": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0bcc32ff51015e85f67c04f0dc53202bdcb1d3ba19f278277d24eb2b3eac5a0f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x529ed493759a67c846fd499fbeac350c7fc90a9d323008df53f6729685ddd392": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000038d7ea4c68000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x7579680a55fcb99e79c60f5cf1099fef93325d50c6fd0e6eb20087c90d32673e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000038d7ea4c68000"
        }
      }
    },
    "0xe51b69e5722bf547866a4d7bc190c6e81b626806": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000001300000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000001400000000000009c4"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000130068a36e0000000000000000000000000000000000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000062fc96b27a510cf4977b59ff952dc32378cc221d"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9ab": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b5b46f918c2923fc7f26db76e8a6a6e9c4347cf9"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9ae": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x4b9d40a2215640dd5eba48d9947d32961ebf4af934dd38ae51fd3f62f9bd3dc7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006c84a8f1c29108f47a79964b5fe888d4f4d0de40"
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