## Reserve changes

### Reserves added

#### wrsETH ([0xD2671165570f41BBB3B0097893300b6EB6101E6C](https://lineascan.build/address/0xD2671165570f41BBB3B0097893300b6EB6101E6C))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 400 wrsETH |
| borrowCap | 0 wrsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7](https://lineascan.build/address/0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7) |
| oracleDecimals | 8 |
| oracleDescription | Capped wrsETH / rsETH(ETH) / USD |
| oracleLatestAnswer | 4626.85069182 |
| usageAsCollateralEnabled | true |
| ltv | 70 % [7000] |
| liquidationThreshold | 73 % [7300] |
| liquidationBonus | 10 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 45 % [4500] |
| aToken | [0xCDD80E6211FC767352B198f827200C7e93d7Bb04](https://lineascan.build/address/0xCDD80E6211FC767352B198f827200C7e93d7Bb04) |
| variableDebtToken | [0xf3C806a402E4E9101373F76C05880EEAc91BB5b9](https://lineascan.build/address/0xf3C806a402E4E9101373F76C05880EEAc91BB5b9) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xB1532b76D054c9F9E61b25c4d91f69B4133E4671](https://lineascan.build/address/0xB1532b76D054c9F9E61b25c4d91f69B4133E4671) |
| aTokenName | Aave Linea wrsETH |
| aTokenSymbol | aLinwrsETH |
| aTokenUnderlyingBalance | 0.025 wrsETH [25000000000000000] |
| id | 7 |
| isPaused | false |
| variableDebtTokenName | Aave Linea Variable Debt wrsETH |
| variableDebtTokenSymbol | variableDebtLinwrsETH |
| virtualBalance | 0.025 wrsETH [25000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 320 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 20 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=200000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3200000000000000000000000000) |


## Emodes changed

### EMode: wstETH correlated(id: 1)



### EMode: ezETH correlated(id: 2)



### EMode: weETH correlated(id: 3)



### EMode: wrsETH/WETH Isolated Liquid E-mode(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wrsETH/WETH Isolated Liquid E-mode |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 93 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wrsETH |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "128",
        "eModeCategory": 4,
        "label": "wrsETH/WETH Isolated Liquid E-mode",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9300,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0xD2671165570f41BBB3B0097893300b6EB6101E6C": {
      "from": null,
      "to": {
        "aToken": "0xCDD80E6211FC767352B198f827200C7e93d7Bb04",
        "aTokenName": "Aave Linea wrsETH",
        "aTokenSymbol": "aLinwrsETH",
        "aTokenUnderlyingBalance": "25000000000000000",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 7,
        "interestRateStrategy": "0xB1532b76D054c9F9E61b25c4d91f69B4133E4671",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7300,
        "ltv": 7000,
        "oracle": "0x444f25c5E73fED92B91F3ECB1bD27003C3CDdeE7",
        "oracleDecimals": 8,
        "oracleDescription": "Capped wrsETH / rsETH(ETH) / USD",
        "oracleLatestAnswer": "462685069182",
        "reserveFactor": 4500,
        "supplyCap": 400,
        "symbol": "wrsETH",
        "underlying": "0xD2671165570f41BBB3B0097893300b6EB6101E6C",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xf3C806a402E4E9101373F76C05880EEAc91BB5b9",
        "variableDebtTokenName": "Aave Linea Variable Debt wrsETH",
        "variableDebtTokenSymbol": "variableDebtLinwrsETH",
        "virtualBalance": "25000000000000000"
      }
    }
  },
  "strategies": {
    "0xD2671165570f41BBB3B0097893300b6EB6101E6C": {
      "from": null,
      "to": {
        "address": "0xB1532b76D054c9F9E61b25c4d91f69B4133E4671",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "200000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x0165c65fb21bdc9cdc09c627d62ab3a983337158": {
      "label": "AaveV3Linea.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x5ee4052fe64aac5cf2274c272348d4ce3f114f379d0d3be63a08e4b7b36b112f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000def1fa4cefe67365ba046a7c630d6b885298e210"
        },
        "0x83203b96fe7a089d4960fe306b4947403c800ae8643deec49d3648181795346e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000def1fa4cefe67365ba046a7c630d6b885298e210"
        }
      }
    },
    "0x0635163285c6ef5692167f18b799fb339df064f8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x10efd3d5c0578c426d2960eef0153c446dd6c6fa": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x21fe2c937eab9065f103ff0486542c7d56a2bdcd": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x330a2c27fce66685d87ebae4ce9da71d2f6d1141": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7041": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7042": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7048": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000058d15e1762800000000000000000000000000000000000"
        },
        "0x1ed8a229768f4c1663a05a11cc060da27910b4f074e5a9ada65f5810b706615f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000002aaa",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000aaaa"
        }
      }
    },
    "0x3bce23a1363728091bc57a58a226cf2940c2e074": {
      "label": "GovernanceV3Linea.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3c6cd9cc7c7a4c2cf5a82734cd249d7d593354da": {
      "label": "AaveV3Linea.ASSETS.WETH.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x444f25c5e73fed92b91f3ecb1bd27003c3cddee7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x45338b98572c67c28425bba5af6120719aae8492": {
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
          "newValue": "0x0000000000000000000000000000000000000000000000000058d15e17628000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x41617665204c696e656120777273455448000000000000000000000000000022"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x614c696e77727345544800000000000000000000000000000000000000000014"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xb7e914faa390a4eb1e7d0428ae428d9af12081ecfefe1cf266ac37d2e1f921e2"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d2671165570f41bbb3b0097893300b6eb6101e6c"
        },
        "0xf2f5eef955c5a5b13b9f328808846efb7adf276eb36326d879eb5e990ea7c750": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000000058d15e17628000"
        }
      }
    },
    "0x6f0d003a0743f5acea5680b1d128bd433b07ffce": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x812e7c19421d9f41a6ddcf047d5cc2de2ca5bfa2": {
      "label": "AaveV3Linea.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x89502c3731f69ddc95b65753708a07f8cd0373f4": {
      "label": "AaveV3Linea.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8c2d95fe7aeb57b86961f3abb296a54f0adb7f88": {
      "label": "AaveV3Linea.ACL_ADMIN, GovernanceV3Linea.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9b7f1be0baae6e9483dd15f37cc92cb769d12f1e": {
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
          "newValue": "0x439a64d0cbca85fb0738b31d81b9c11c96e4a03153cd332f24a9e6869c9969d9"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d2671165570f41bbb3b0097893300b6eb6101e6c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x41617665204c696e6561205661726961626c652044656274207772734554483e"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744c696e777273455448000000000000000000002a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        }
      }
    },
    "0xa806da549fcb2b4912a7dffe4c1aa7a1ed0bd5c9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd56a60595ebefebed7f22dcee6c2acc61b06cf8c68e84c88677840365d1ff92b": {
          "previousValue": "0x00689b3a99000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00689b3a99000000000003000000000000000000000000000000000000000000"
        },
        "0xd56a60595ebefebed7f22dcee6c2acc61b06cf8c68e84c88677840365d1ff92c": {
          "previousValue": "0x000000000000000000093a8000000000000068c95f1a00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068c95f1a000000000000689b3a9a"
        }
      }
    },
    "0xb1532b76d054c9f9e61b25c4d91f69b4133e4671": {
      "label": "AaveV3Linea.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Linea.ASSETS.weETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xb5c9cb0780394d8953ee3fb35e37653235edb8be5e8fc13f31ba4bffda5982ba": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000007d0000000001194"
        }
      }
    },
    "0xb823381bead441ee3c330da498f3cc0f2033d828": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xa0424655a084f238205b00fd277efd949de2731bd63f52980587490053114f0b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xa0b036a2e1f2082316f2f55b2ca6fd2bca46334e99da4ef31b3263e96476d479": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000058d15e17628000"
        },
        "0xe15b195b8c00ea41e4d9d7c50f33e919f3486b07b5066b7a0697de20e4ac72b7": {
          "previousValue": "0x000000000000000000000000000000000000000000000000007c585087238000",
          "newValue": "0x000000000000000000000000000000000000000000000000002386f26fc10000"
        }
      }
    },
    "0xbb6558a80ed7811bd6d02bd26814e49c349b3acd": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000070000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000080000000000000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7041": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7042": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7043": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000700689b3a9a00000000000000000000000000000000"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7044": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000cdd80e6211fc767352b198f827200c7e93d7bb04"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7046": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f3c806a402e4e9101373f76c05880eeac91bb5b9"
        },
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7049": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x433de8acc5517b03dcea2b76624190e6bdf174d47449230aa1a80bf123f01991": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d2671165570f41bbb3b0097893300b6eb6101e6c"
        }
      }
    },
    "0xbf32c7dfc72b730967072b112927ca0de205dbb5": {
      "label": "AaveV3Linea.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc47b8c00b0f69a36fa203ffeac0334874574a8ac": {
      "label": "AaveV3Linea.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc67bb8f2314fa0df50cba314c6509a7bdad500c0": {
      "label": "AaveV3Linea.DEFAULT_INCENTIVES_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xcdd80e6211fc767352b198f827200c7e93d7bb04": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000045338b98572c67c28425bba5af6120719aae8492",
          "label": "Implementation slot"
        }
      }
    },
    "0xcfdada7dcd2e785cf706badbc2b8af5084d595e9": {
      "label": "AaveV3Linea.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xb5c9cb0780394d8953ee3fb35e37653235edb8be5e8fc13f31ba4bffda5982ba": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000444f25c5e73fed92b91f3ecb1bd27003c3cddee7"
        }
      }
    },
    "0xd2671165570f41bbb3b0097893300b6eb6101e6c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xeedf0b095b5dfe75f3881cb26c19da209a27463a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf1597757c7d88e72e3778606277aab514166cf3d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7040": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8000000190000000000119481122af81c841b58"
        },
        "0x3abd1c8caef2dd139a58cd5aea99f6780c8cd43266b005905f3ee916b2797dc9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7772734554482f574554482049736f6c61746564204c697175696420452d6d6f"
        },
        "0x3abd1c8caef2dd139a58cd5aea99f6780c8cd43266b005905f3ee916b2797dca": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6465000000000000000000000000000000000000000000000000000000000000"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000080277424542328"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000045"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0xf3c806a402e4e9101373f76c05880eeac91bb5b9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009b7f1be0baae6e9483dd15f37cc92cb769d12f1e",
          "label": "Implementation slot"
        }
      }
    }
  }
}
```