## Reserve changes

### Reserves added

#### EURC ([0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c](https://etherscan.io/address/0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 7,000,000 EURC |
| borrowCap | 6,500,000 EURC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3](https://etherscan.io/address/0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3) |
| oracleDecimals | 8 |
| oracleDescription | Capped EURC/USD |
| oracleLatestAnswer | 1.15156086 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0](https://etherscan.io/address/0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0) |
| variableDebtToken | [0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08](https://etherscan.io/address/0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum EURC |
| aTokenSymbol | aEthEURC |
| aTokenUnderlyingBalance | 0 EURC [0] |
| id | 47 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt EURC |
| variableDebtTokenSymbol | variableDebtEthEURC |
| virtualAccountingActive | true |
| virtualBalance | 0 EURC [0] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 56 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 6 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=60000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=560000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c": {
      "from": null,
      "to": {
        "aToken": "0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0",
        "aTokenName": "Aave Ethereum EURC",
        "aTokenSymbol": "aEthEURC",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 6500000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "id": 47,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7500,
        "oracle": "0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3",
        "oracleDecimals": 8,
        "oracleDescription": "Capped EURC/USD",
        "oracleLatestAnswer": "115156086",
        "reserveFactor": 1000,
        "supplyCap": 7000000,
        "symbol": "EURC",
        "underlying": "0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08",
        "variableDebtTokenName": "Aave Ethereum Variable Debt EURC",
        "variableDebtTokenSymbol": "variableDebtEthEURC",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "560000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x04f84020fdf10d9ee64d1dcc2986edf2f556da11": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1abaea1f7c830bd89acc67ec4af516284b1bc33c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x223d844fc4b006d67c0cdbd39371a9f73f69d974": {
      "label": "AaveV3Ethereum.EMISSION_MANAGER, AaveV3EthereumEtherFi.EMISSION_MANAGER, AaveV3EthereumLido.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0xcf1dbc63ddff85d6eb5578b981099997b69bbaaf3643c12f2ec16a23c8ace8d5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xf9fb442904dc12f72a3ae800a9554f879bee287d3e41d600c9b581c36a12da7e": {
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
    "0x43506849d7c04f9138d1a2050bbf3a0c054402dd": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x45224f360f98ba369ca5a65b2a1aaf0334af584ab8c82b41cd8cff81e9b451d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100"
        }
      }
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
        "0x512d526035d29131a6dce9f9b44e4b7ce0c57a8a373dc86ba09b753b3a99bbd8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000a6ab031a4d189b24628ec9eb155f0a0f1a0e55a3"
        }
      }
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6c82c66622eb360fc973d3f492f9d8e9ea538b08": {
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
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x78c4043a166ee9ded6adb363d5e637153406f250c093d9a746243a09217ab464": {
          "previousValue": "0x00685856ce000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00685856ce000000000003000000000000000000000000000000000000000000"
        },
        "0x78c4043a166ee9ded6adb363d5e637153406f250c093d9a746243a09217ab465": {
          "previousValue": "0x000000000000000000093a8000000000000068867b4f00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068867b4f000000000000685856cf"
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
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d20455552430000000000000000000000000024"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6145746845555243000000000000000000000000000000000000000000000010"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb06"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x216e5b3df629165663f01d2c75a435d5053a1b94e2313ca217e8e54e2b7219af"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001abaea1f7c830bd89acc67ec4af516284b1bc33c"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x966dad3b93c207a9ee3a79c336145e013c5cd3fc": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9aeb8aaa1ca38634aa8c0c8933e7fb4d61091327": {
      "label": "AaveV3Ethereum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e80006acfc0000632ea003e8850629041e781d4c"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301b": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301c": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301d": {
          "previousValue": "0x000000000000000000002f000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002f00685856cf00000000000000000000000000000000"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x512d526035d29131a6dce9f9b44e4b7ce0c57a8a373dc86ba09b753b3a99bbd8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000138800000258000000002328"
        }
      }
    },
    "0xa674a0fd742f37bd5077afc90d1e82485c91989c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa6ab031a4d189b24628ec9eb155f0a0f1a0e55a3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xaa6e91c82942aeae040303bf96c15a6dbcb82ca0": {
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
          "newValue": "0xa166e4d59ef6e8cbfa6f611826196c2073f7d6d78e705f2d96a2adf3e56c1973"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001abaea1f7c830bd89acc67ec4af516284b1bc33c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744574684555524300000000000000000000000026"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb06"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d205661726961626c6520446562742045555243"
        }
      }
    },
    "0xb49f677943bc038e9857d61e7d053caa2c1734c1": {
      "label": "MiscEthereum.EUR_USD_AGGREGATOR",
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
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000002f00000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000003000000000000009c4"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002f000000000000000000000000000000000000000000"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d2301e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000aa6e91c82942aeae040303bf96c15a6dbcb82ca0"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d23020": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006c82c66622eb360fc973d3f492f9d8e9ea538b08"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d23021": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009ec6f08190dea04a54f8afc53db96134e5e3fdfb"
        },
        "0x24a6d6495ab5cae2014f8b8dc5166cee765124c46ed3c651d2361ec301d23023": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xd08db6eea880c34c8281cf6842ad4930fc629fe252408bdb9cdda6963634a943": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000001abaea1f7c830bd89acc67ec4af516284b1bc33c"
        }
      }
    }
  }
}
```