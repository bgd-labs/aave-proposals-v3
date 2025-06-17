## Reserve changes

### Reserves added

#### tETH ([0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8](https://etherscan.io/address/0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 20,000 tETH |
| borrowCap | 1 tETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xEcBa0A6005f67fAb09F4e107E0eCc7ff56063E19](https://etherscan.io/address/0xEcBa0A6005f67fAb09F4e107E0eCc7ff56063E19) |
| oracleDecimals | 8 |
| oracleDescription | Capped tETH / ETH / USD |
| oracleLatestAnswer | 2538.47873365 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 50 % [5000] |
| aToken | [0xce8c60fd8390eFCc3Fc66A3f0bd64BEb969e750E](https://etherscan.io/address/0xce8c60fd8390eFCc3Fc66A3f0bd64BEb969e750E) |
| variableDebtToken | [0xe7ea6125490ae4594aD9B44D05dFF9F2A4343134](https://etherscan.io/address/0xe7ea6125490ae4594aD9B44D05dFF9F2A4343134) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8958b1C39269167527821f8c276Ef7504883f2fa](https://etherscan.io/address/0x8958b1C39269167527821f8c276Ef7504883f2fa) |
| aTokenName | Aave Ethereum Lido tETH |
| aTokenSymbol | aEthLidotETH |
| aTokenUnderlyingBalance | 0 tETH [0] |
| id | 8 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt tETH |
| variableDebtTokenSymbol | variableDebtEthLidotETH |
| virtualAccountingActive | true |
| virtualBalance | 0 tETH [0] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: wstETH/WETH(id: 1)



### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)



### EMode: rsETH/Stablecoins(id: 6)



### EMode: tETH/wstETH(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | tETH/wstETH |
| eMode.ltv | - | 92 % |
| eMode.liquidationThreshold | - | 94 % |
| eMode.liquidationBonus | - | 2 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | tETH |


## Raw diff

```json
{
  "eModes": {
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "256",
        "eModeCategory": 7,
        "label": "tETH/wstETH",
        "liquidationBonus": 10200,
        "liquidationThreshold": 9400,
        "ltv": 9200
      }
    }
  },
  "reserves": {
    "0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8": {
      "from": null,
      "to": {
        "aToken": "0xce8c60fd8390eFCc3Fc66A3f0bd64BEb969e750E",
        "aTokenName": "Aave Ethereum Lido tETH",
        "aTokenSymbol": "aEthLidotETH",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 8,
        "interestRateStrategy": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
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
        "oracle": "0xEcBa0A6005f67fAb09F4e107E0eCc7ff56063E19",
        "oracleDecimals": 8,
        "oracleDescription": "Capped tETH / ETH / USD",
        "oracleLatestAnswer": "253847873365",
        "reserveFactor": 5000,
        "supplyCap": 20000,
        "symbol": "tETH",
        "underlying": "0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xe7ea6125490ae4594aD9B44D05dFF9F2A4343134",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt tETH",
        "variableDebtTokenSymbol": "variableDebtEthLidotETH",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8": {
      "from": null,
      "to": {
        "address": "0x8958b1C39269167527821f8c276Ef7504883f2fa",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x013e2c7567b6231e865bb9273f8c7656103611c0": {
      "label": "AaveV3EthereumLido.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1b6238e95bbcabee58997c99badd4154ad68ba92": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x223d844fc4b006d67c0cdbd39371a9f73f69d974": {
      "label": "AaveV3Ethereum.EMISSION_MANAGER, AaveV3EthereumEtherFi.EMISSION_MANAGER, AaveV3EthereumLido.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x2bb01ff981c81d59d6b827710e6cef9693cb1fa05724f2dc4aff50d68f31426d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xb431460c8a4f27fd28ab49428b9b65bccc51e03e856284c89732d1fd57469446": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x342631c6cefc9cfbf97b2fe4aa242a236e1fd517": {
      "label": "AaveV3EthereumLido.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e59212c34588a63350142efad594a20c88c2ced": {
      "label": "AaveV3EthereumLido.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
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
          "newValue": "0x9b325111b84d157210c0f414a19d347420ae734a7755437e048cba3ebcdb89c4"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d11c452fc99cf405034ee446803b6f6c1f6d5ed8"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000004b"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744574684c69646f7445544800000000000000002e"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d204c69646f205661726961626c652044656274"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x2074455448000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5424384b256154046e9667ddfaaa5e550145215e": {
      "label": "AaveV3EthereumLido.ASSETS.WETH.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0ec66851261d57853f2f5bf29b6fdf002ea7b1825ef27ca0f35da137982bd7dc": {
          "previousValue": "0x006851c39e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006851c39e000000000003000000000000000000000000000000000000000000"
        },
        "0x0ec66851261d57853f2f5bf29b6fdf002ea7b1825ef27ca0f35da137982bd7dd": {
          "previousValue": "0x000000000000000000093a80000000000000687fe81f00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000687fe81f0000000000006851c39f"
        }
      }
    },
    "0x7c7fdfca295a787ded12bb5c1a49a8d2cc20e3f8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7f8fc14d462bdf93c681c1f2fd615389bf969fb2": {
      "label": "AaveV3EthereumLido.DEFAULT_A_TOKEN_IMPL_REV_1",
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
          "newValue": "0x4161766520457468657265756d204c69646f207445544800000000000000002e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x614574684c69646f744554480000000000000000000000000000000000000018"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x65f6d961a32248d59ec899f7f1f9a8f1f4b375a0a43fd123b42c60a681093352"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d11c452fc99cf405034ee446803b6f6c1f6d5ed8"
        }
      }
    },
    "0x8958b1c39269167527821f8c276ef7504883f2fa": {
      "label": "AaveV3EthereumLido.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3EthereumLido.ASSETS.rsETH.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xae811e75d50ba33283ff06e4a481d019c723c5fbd03e1a2554bc2d9b02b065bd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000003e8000000001194"
        }
      }
    },
    "0xc405a0eab071a085a832f876d8e5be7cfeafb624": {
      "label": "AaveV3EthereumLido.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000010027d824b823f0"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x744554482f777374455448000000000000000000000000000000000000000016"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c014": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8000004e200000000011388811229fe000a0005"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c015": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c016": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c017": {
          "previousValue": "0x0000000000000000000008000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000008006851c39f00000000000000000000000000000000"
        }
      }
    },
    "0xce8c60fd8390efcc3fc66a3f0bd64beb969e750e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007f8fc14d462bdf93c681c1f2fd615389bf969fb2",
          "label": "Implementation slot"
        }
      }
    },
    "0xcfbf336fe147d643b9cb705648500e101504b16d": {
      "label": "AaveV3EthereumLido.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xd1a622566f277aa76c3c47a30469432aaec95e38": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2a9b9fe90656ad2636666ce3fb10fd3b66ebdc961e8598c46bea11f76203f8dc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000008e1bc9bf040000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe3c061981870c0c7b1f3c4f4bb36b95f1f260be6": {
      "label": "AaveV3EthereumLido.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xae811e75d50ba33283ff06e4a481d019c723c5fbd03e1a2554bc2d9b02b065bd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ecba0a6005f67fab09f4e107e0ecc7ff56063e19"
        }
      }
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR_IMPL, AaveV3EthereumEtherFi.POOL_CONFIGURATOR_IMPL, AaveV3EthereumLido.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe7ea6125490ae4594ad9b44d05dff9f2a4343134": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000003e59212c34588a63350142efad594a20c88c2ced",
          "label": "Implementation slot"
        }
      }
    },
    "0xecba0a6005f67fab09f4e107e0ecc7ff56063e19": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000800000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000000900000000000009c4"
        },
        "0x05725f7419f52ac606bc65a60e5ab85095522694ed898882d2777964ee382600": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d11c452fc99cf405034ee446803b6f6c1f6d5ed8"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c015": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c016": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c017": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000008000000000000000000000000000000000000000000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c018": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ce8c60fd8390efcc3fc66a3f0bd64beb969e750e"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c01a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e7ea6125490ae4594ad9b44d05dff9f2a4343134"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c01b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000008958b1c39269167527821f8c276ef7504883f2fa"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c01d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    }
  }
}
```