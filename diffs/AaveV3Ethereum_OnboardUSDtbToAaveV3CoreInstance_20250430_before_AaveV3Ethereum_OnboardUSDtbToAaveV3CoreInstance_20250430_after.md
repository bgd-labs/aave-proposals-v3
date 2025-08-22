## Reserve changes

### Reserves added

#### USDtb ([0xC139190F447e929f090Edeb554D95AbB8b18aC1C](https://etherscan.io/address/0xC139190F447e929f090Edeb554D95AbB8b18aC1C))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 USDtb |
| borrowCap | 40,000,000 USDtb |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x2FA6A78E3d617c1013a22938411602dc9Da98dBa](https://etherscan.io/address/0x2FA6A78E3d617c1013a22938411602dc9Da98dBa) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDtb / USD |
| oracleLatestAnswer | 0.99983211 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 10 % [1000] |
| aToken | [0xEc4ef66D4fCeEba34aBB4dE69dB391Bc5476ccc8](https://etherscan.io/address/0xEc4ef66D4fCeEba34aBB4dE69dB391Bc5476ccc8) |
| variableDebtToken | [0xeA85a065F87FE28Aa8Fbf0D6C7deC472b106252C](https://etherscan.io/address/0xeA85a065F87FE28Aa8Fbf0D6C7deC472b106252C) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum USDtb |
| aTokenSymbol | aEthUSDtb |
| aTokenUnderlyingBalance | 100 USDtb [100000000000000000000] |
| id | 42 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt USDtb |
| variableDebtTokenSymbol | variableDebtEthUSDtb |
| virtualAccountingActive | true |
| virtualBalance | 100 USDtb [100000000000000000000] |
| optimalUsageRatio | 80 % |
| maxVariableBorrowRate | 56 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 6 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=60000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=560000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0xC139190F447e929f090Edeb554D95AbB8b18aC1C": {
      "from": null,
      "to": {
        "aToken": "0xEc4ef66D4fCeEba34aBB4dE69dB391Bc5476ccc8",
        "aTokenName": "Aave Ethereum USDtb",
        "aTokenSymbol": "aEthUSDtb",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 40000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 42,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0x2FA6A78E3d617c1013a22938411602dc9Da98dBa",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDtb / USD",
        "oracleLatestAnswer": "99983211",
        "reserveFactor": 1000,
        "supplyCap": 50000000,
        "symbol": "USDtb",
        "underlying": "0xC139190F447e929f090Edeb554D95AbB8b18aC1C",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0xeA85a065F87FE28Aa8Fbf0D6C7deC472b106252C",
        "variableDebtTokenName": "Aave Ethereum Variable Debt USDtb",
        "variableDebtTokenSymbol": "variableDebtEthUSDtb",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0xC139190F447e929f090Edeb554D95AbB8b18aC1C": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "560000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x185477906b46d9b8de0deb73a1bbfb87b5b51bc3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e2": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e3": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37ea": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000056bc75e2d6310000000000000000000000000000000000000"
        }
      }
    },
    "0x223d844fc4b006d67c0cdbd39371a9f73f69d974": {
      "label": "AaveV3Ethereum.EMISSION_MANAGER, AaveV3EthereumEtherFi.EMISSION_MANAGER, AaveV3EthereumLido.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x7f6bd74dc5ded63e712c1a42ee8b002205aed8b5f0077e61b927696e1d0a0037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x82d50be85b133281274a9e1e6b4be5cb46dc9d7e847d9fff2840c3548c06a5ef": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": "AaveV3Ethereum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2fa6a78e3d617c1013a22938411602dc9da98dba": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x6e8a06919cb268cba6b5c4b6e72b281a2aa7ec0a7c2865f3cb4cc8afbd2b3f75": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000002fa6a78e3d617c1013a22938411602dc9da98dba"
        }
      }
    },
    "0x55fbfb9f8d4d03bec3c466eafbf35f973704661e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x66704dad467a7ca508b3be15865d9b9f3e186c90": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x089d9dba82be10d77505d9275f10474168973fc5766b8743cf39a24de0098e95": {
          "previousValue": "0x0068187cfa000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068187cfa000000000003000000000000000000000000000000000000000000"
        },
        "0x089d9dba82be10d77505d9275f10474168973fc5766b8743cf39a24de0098e96": {
          "previousValue": "0x000000000000000000093a800000000000006846a17b00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006846a17b00000000000068187cfb"
        }
      }
    },
    "0x7effd7b47bfd17e52fb7559d3f924201b9dbff3d": {
      "label": "AaveV3Ethereum.DEFAULT_A_TOKEN_IMPL_REV_1",
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
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d20555344746200000000000000000000000026"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6145746855534474620000000000000000000000000000000000000000000012"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4818f6366cffdc05f8965e240646efe30ed54a6f52d1b0c976e22c1979b1cc9a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c139190f447e929f090edeb554d95abb8b18ac1c"
        },
        "0x2c491f7384cd762770fb659d7290ed7b4da75a7c480a8a5cc401f49c4807de64": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000056bc75e2d63100000"
        }
      }
    },
    "0x8164cc65827dcfe994ab23944cbc90e0aa80bfcb": {
      "label": "AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER, AaveV3EthereumEtherFi.DEFAULT_INCENTIVES_CONTROLLER, AaveV3EthereumLido.DEFAULT_INCENTIVES_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9aeb8aaa1ca38634aa8c0c8933e7fb4d61091327": {
      "label": "AaveV3Ethereum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x10000000000000000000000000002faf080002625a0003e88512000000000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e2": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e3": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e4": {
          "previousValue": "0x000000000000000000002a000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002a0068187cfb00000000000000000000000000000000"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x6e8a06919cb268cba6b5c4b6e72b281a2aa7ec0a7c2865f3cb4cc8afbd2b3f75": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000138800000258000000001f40"
        }
      }
    },
    "0xac725cb59d16c81061bdea61041a8a5e73da9ec6": {
      "label": "AaveV3Ethereum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
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
          "newValue": "0x61c4e41f882bb1af51f4b34e50988ab89d116ef04c4be913feab2a1107954319"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c139190f447e929f090edeb554d95abb8b18ac1c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744574685553447462000000000000000000000028"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d205661726961626c6520446562742055534474"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6200000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xc139190f447e929f090edeb554d95abb8b18ac1c": {
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
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR_IMPL, AaveV3EthereumEtherFi.POOL_CONFIGURATOR_IMPL, AaveV3EthereumLido.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe7b67f44ea304dd7f6d215b13686637ff64cd2b2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xea85a065f87fe28aa8fbf0d6c7dec472b106252c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac725cb59d16c81061bdea61041a8a5e73da9ec6",
          "label": "Implementation slot"
        }
      }
    },
    "0xea8a763b5b1f9c9c7aea64f33947448d9e39e475": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x144dd7a010f3f6465282bebc9f1fadb88476c0e9abefa8a0865fd9c921c7c369": {
          "previousValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xbd0e7ba793ca4ab933a9bba66aeba3593b77201dcdbbf810de0f6d30e2960fa1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000"
        },
        "0xd009ec6c13da0b4c89a84e1103e562efc1140ce59c5c395519bc3dbb152852ef": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xec4ef66d4fceeba34abb4de69db391bc5476ccc8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007effd7b47bfd17e52fb7559d3f924201b9dbff3d",
          "label": "Implementation slot"
        }
      }
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000002a00000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000002b00000000000009c4"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002a000000000000000000000000000000000000000000"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ec4ef66d4fceeba34abb4de69db391bc5476ccc8"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ea85a065f87fe28aa8fbf0d6c7dec472b106252c"
        },
        "0xda5dd3cc2154ef792ee5a58e45443e76805a00425ced02b7b873ec8afdeb37e8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009ec6f08190dea04a54f8afc53db96134e5e3fdfb"
        },
        "0xe722a9080ca38b84605be26f7079d068a1c9e5160657aebb784e0611e3b32b55": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c139190f447e929f090edeb554d95abb8b18ac1c"
        }
      }
    }
  }
}
```