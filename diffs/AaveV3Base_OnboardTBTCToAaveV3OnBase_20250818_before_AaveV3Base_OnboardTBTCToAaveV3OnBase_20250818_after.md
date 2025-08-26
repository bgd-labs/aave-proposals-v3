## Reserve changes

### Reserves added

#### tBTC ([0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b](https://basescan.org/address/0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 130 tBTC |
| borrowCap | 13 tBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F](https://basescan.org/address/0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 115651.56 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0xbcFFB4B3beADc989Bd1458740952aF6EC8fBE431](https://basescan.org/address/0xbcFFB4B3beADc989Bd1458740952aF6EC8fBE431) |
| variableDebtToken | [0x182cDEEC1D52ccad869d621bA422F449FA5809f5](https://basescan.org/address/0x182cDEEC1D52ccad869d621bA422F449FA5809f5) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base tBTC |
| aTokenSymbol | aBastBTC |
| aTokenUnderlyingBalance | 0.001 tBTC [1000000000000000] |
| id | 13 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt tBTC |
| variableDebtTokenSymbol | variableDebtBastBTC |
| virtualBalance | 0.001 tBTC [1000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 64 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 60 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=640000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b": {
      "from": null,
      "to": {
        "aToken": "0xbcFFB4B3beADc989Bd1458740952aF6EC8fBE431",
        "aTokenName": "Aave Base tBTC",
        "aTokenSymbol": "aBastBTC",
        "aTokenUnderlyingBalance": "1000000000000000",
        "borrowCap": 13,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 13,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
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
        "oracle": "0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": "11565156000000",
        "reserveFactor": 2000,
        "supplyCap": 130,
        "symbol": "tBTC",
        "underlying": "0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x182cDEEC1D52ccad869d621bA422F449FA5809f5",
        "variableDebtTokenName": "Aave Base Variable Debt tBTC",
        "variableDebtTokenSymbol": "variableDebtBastBTC",
        "virtualBalance": "1000000000000000"
      }
    }
  },
  "strategies": {
    "0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "640000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x034fd14b9ae6bb066a1f9f85a55e990b0b25c168": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x41d4f1bb3b829a8d7806c78e83214233da7d29c6fa7bc5a227258cd200225274": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000002a8aaaa",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000aa8aaaa"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a8": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a9": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68af": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000038d7ea4c6800000000000000000000000000000000000"
        }
      }
    },
    "0x182cdeec1d52ccad869d621ba422f449fa5809f5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000039ea4b1802d0c60bdbd13bcf763043984a4ba197",
          "label": "Implementation slot"
        }
      }
    },
    "0x236aa50979d5f3de3bd1eeb40e81137f22ab794b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": "AaveV3Base.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x8a11f69d178d125021147e13e07322a79a8417ce3fc7d61a6f62bab67fe3b87c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000064c911996d3c6ac71f9b455b1e8e7266bcbd848f"
        }
      }
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x319d156ea750b20d5370ef7b348b6ff1ab5d0256": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2306dd40301e71102649086fa4506190474e93c93807bd630a59f18e25c47965": {
          "previousValue": "0x0068a46218000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068a46218000000000003000000000000000000000000000000000000000000"
        },
        "0x2306dd40301e71102649086fa4506190474e93c93807bd630a59f18e25c47966": {
          "previousValue": "0x000000000000000000093a8000000000000068d2869900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068d2869900000000000068a46219"
        }
      }
    },
    "0x39ea4b1802d0c60bdbd13bcf763043984a4ba197": {
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
          "newValue": "0x4b12379b60555f999d75da8b81cf7a5af39e683971bbf478aaf1bc85c71ffe1b"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000236aa50979d5f3de3bd1eeb40e81137f22ab794b"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652042617365205661726961626c652044656274207442544300000038"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744261737442544300000000000000000000000026"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        }
      }
    },
    "0x41c9b5639e3f2f6c61e9b78b2c6ff3746e79d91a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2eed789a2bb62157646a70900c7f573a6f66f4a88dd5fe7713c8f839e455ffcb": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x7af6e1c32843706a0b22762b8978f85dfd1ce4a5b46442a9e7caa44f8ede00d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000038d7ea4c68000"
        },
        "0xeca15e2be32fe00db48f5a373bdefe26f4203f44ead8d2c0bd693475ffc05a8f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000003919072c9e1cb",
          "newValue": "0x00000000000000000000000000000000000000000000000000000411ce0361cb"
        }
      }
    },
    "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
      "label": "AaveV3Base.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4d0109d509e66df298257ffdd55f94a3814343aa": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
      "label": "AaveV3Base.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x64c911996d3c6ac71f9b455b1e8e7266bcbd848f": {
      "label": "AaveV3Base.ASSETS.cbBTC.ORACLE, AaveV3Base.ASSETS.LBTC.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6533a273f3ac84df91dcd654d6ebaba73687e246": {
      "label": "AaveV3Base.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x86150f39d0ba1f6d9c1983e8c8e294d6d2cb72cf7bf2f8481641f19258367c02": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xfb3308a53168c2a3b7c575844ee6bc58da1d854b34ce9f4da3305c3d7b2b0dc7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x79ab8fc5ba13daf37b4e978a543286bc2a16508c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e800000008200000000d07d0851229fe1e781c84"
        }
      }
    },
    "0x852ae0b1af1aaedb0fc4428b4b24420780976ca8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
      "label": "AaveV3Base.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDbC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.wrsETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.EURC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.AAVE.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x8a11f69d178d125021147e13e07322a79a8417ce3fc7d61a6f62bab67fe3b87c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000177000000190000000001194"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": "AaveV3Base.ACL_ADMIN, GovernanceV3Base.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb4fb1a0db5627a79cf3d0e4acc286d52fec54688": {
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
          "newValue": "0x416176652042617365207442544300000000000000000000000000000000001c"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6142617374425443000000000000000000000000000000000000000000000010"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xd2261ca55e0faa5db640129fa0f66a93d8c3726032d7523928a68a818fdf67be"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000236aa50979d5f3de3bd1eeb40e81137f22ab794b"
        },
        "0xe02ba9fe3fe72fe4457de0f0f3000b7de04e0ed037bd90e34d6d4182590c700d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce8000000000000000000000000038d7ea4c68000"
        }
      }
    },
    "0xbcffb4b3beadc989bd1458740952af6ec8fbe431": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b4fb1a0db5627a79cf3d0e4acc286d52fec54688",
          "label": "Implementation slot"
        }
      }
    },
    "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
      "label": "AaveV3Base.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe51b69e5722bf547866a4d7bc190c6e81b626806": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000d00000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000000e00000000000009c4"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68aa": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000d0068a4621900000000000000000000000000000000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68ab": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bcffb4b3beadc989bd1458740952af6ec8fbe431"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68ad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000182cdeec1d52ccad869d621ba422f449fa5809f5"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68b0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xe0d1ddf44d1b58bbd9730933190424ec95782b7368eced03798ebf724278fb88": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000236aa50979d5f3de3bd1eeb40e81137f22ab794b"
        }
      }
    },
    "0xf9cc4f0d883f1a1eb2c253bdb46c254ca51e1f44": {
      "label": "AaveV3Base.DEFAULT_INCENTIVES_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```