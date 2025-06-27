## Reserve changes

### Reserves added

#### PT-sUSDE-25SEP2025 ([0x9F56094C450763769BA0EA9Fe2876070c0fD5F77](https://etherscan.io/address/0x9F56094C450763769BA0EA9Fe2876070c0fD5F77))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 PT-sUSDE-25SEP2025 |
| borrowCap | 1 PT-sUSDE-25SEP2025 |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x7585693910f39df4959912B27D09EAEef06C1a93](https://etherscan.io/address/0x7585693910f39df4959912B27D09EAEef06C1a93) |
| oracleDecimals | 8 |
| oracleDescription | PT Capped sUSDe USDT/USD linear discount 25SEP2025 |
| oracleLatestAnswer | 0.98152072 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | [0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0](https://etherscan.io/address/0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0) |
| variableDebtToken | [0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08](https://etherscan.io/address/0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum PT_sUSDe_25SEP2025 |
| aTokenSymbol | aEthPT_sUSDe_25SEP2025 |
| aTokenUnderlyingBalance | 0 PT-sUSDE-25SEP2025 [0] |
| id | 47 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt PT_sUSDe_25SEP2025 |
| variableDebtTokenSymbol | variableDebtEthPT_sUSDe_25SEP2025 |
| virtualAccountingActive | true |
| virtualBalance | 0 PT-sUSDE-25SEP2025 [0] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 56 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 6 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=60000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=560000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: PT-sUSDe Stablecoins Jul 2025(id: 8)



### EMode: PT-eUSDe Stablecoins May 2025(id: 9)



### EMode: PT-USDe Stablecoins July 2025(id: 10)



### EMode: USDe Stablecoin(id: 11)



### EMode: PT-USDe USDe July 2025(id: 12)



### EMode: PT-eUSDe Stablecoins August 2025(id: 13)



### EMode: PT-eUSDe USDe August 2025(id: 14)



### EMode: eUSDe_Stablecoin(id: 15)



### EMode: FBTC/WBTC(id: 16)



### EMode: PT-sUSDe Stablecoins September 2025(id: 17)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | PT-sUSDe Stablecoins September 2025 |
| eMode.ltv | - | 85.7 % |
| eMode.liquidationThreshold | - | 87.7 % |
| eMode.liquidationBonus | - | 5.6 % |
| eMode.borrowableBitmap | - | USDC, USDT, USDe, USDS |
| eMode.collateralBitmap | - | PT-sUSDE-31JUL2025 |


### EMode: PT-sUSDe USDe Spetember 2025(id: 18)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | PT-sUSDe USDe Spetember 2025 |
| eMode.ltv | - | 87.1 % |
| eMode.liquidationThreshold | - | 89.1 % |
| eMode.liquidationBonus | - | 3.7 % |
| eMode.borrowableBitmap | - | USDe |
| eMode.collateralBitmap | - | PT-sUSDE-31JUL2025 |


## Raw diff

```json
{
  "eModes": {
    "17": {
      "from": null,
      "to": {
        "borrowableBitmap": "35433480456",
        "collateralBitmap": "2199023255552",
        "eModeCategory": 17,
        "label": "PT-sUSDe Stablecoins September 2025",
        "liquidationBonus": 10560,
        "liquidationThreshold": 8770,
        "ltv": 8570
      }
    },
    "18": {
      "from": null,
      "to": {
        "borrowableBitmap": "1073741824",
        "collateralBitmap": "2199023255552",
        "eModeCategory": 18,
        "label": "PT-sUSDe USDe Spetember 2025",
        "liquidationBonus": 10370,
        "liquidationThreshold": 8910,
        "ltv": 8710
      }
    }
  },
  "reserves": {
    "0x9F56094C450763769BA0EA9Fe2876070c0fD5F77": {
      "from": null,
      "to": {
        "aToken": "0xAA6e91C82942aeAE040303Bf96c15a6dBcB82CA0",
        "aTokenName": "Aave Ethereum PT_sUSDe_25SEP2025",
        "aTokenSymbol": "aEthPT_sUSDe_25SEP2025",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 47,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
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
        "oracle": "0x7585693910f39df4959912B27D09EAEef06C1a93",
        "oracleDecimals": 8,
        "oracleDescription": "PT Capped sUSDe USDT/USD linear discount 25SEP2025",
        "oracleLatestAnswer": "98152072",
        "reserveFactor": 1000,
        "supplyCap": 50000000,
        "symbol": "PT-sUSDE-25SEP2025",
        "underlying": "0x9F56094C450763769BA0EA9Fe2876070c0fD5F77",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x6c82c66622Eb360FC973D3F492f9D8E9eA538b08",
        "variableDebtTokenName": "Aave Ethereum Variable Debt PT_sUSDe_25SEP2025",
        "variableDebtTokenSymbol": "variableDebtEthPT_sUSDe_25SEP2025",
        "virtualAccountingActive": true,
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0x9F56094C450763769BA0EA9Fe2876070c0fD5F77": {
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
    "0x0d5f4aadf3fde31bbb55db5f42c080f18ad54df5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x223d844fc4b006d67c0cdbd39371a9f73f69d974": {
      "label": "AaveV3Ethereum.EMISSION_MANAGER, AaveV3EthereumEtherFi.EMISSION_MANAGER, AaveV3EthereumLido.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0xb2ee2cf8a4c69b5c4c8eeebb83f83dd619fa1f5387698d416db0bd87feefe191": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xcf1dbc63ddff85d6eb5578b981099997b69bbaaf3643c12f2ec16a23c8ace8d5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x260326c220e469358846b187ee53328303efe19c": {
      "label": "AaveV3Ethereum.ASSETS.USDT.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": "AaveV3Ethereum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e7d1eab13ad0104d2750b8863b489d65364e32d": {
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
        "0x60047994dc5a9c6ccd3aa5e34a586be9d37c95c2b71692caadd44f25aa07db34": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007585693910f39df4959912b27d09eaeef06c1a93"
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
        "0x9690e49a8cc516395450b184f91abdba4253a1008b9a709a8932aaf81cf8130d": {
          "previousValue": "0x00685e9ffa000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00685e9ffa000000000003000000000000000000000000000000000000000000"
        },
        "0x9690e49a8cc516395450b184f91abdba4253a1008b9a709a8932aaf81cf8130e": {
          "previousValue": "0x000000000000000000093a80000000000000688cc47b00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000688cc47b000000000000685e9ffb"
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
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6145746850545f73555344655f3235534550323032350000000000000000002c"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xe1de9b82096d67e6dccf0de9bb5c8b9b777539f1ae4efd576006a743b4721221"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009f56094c450763769ba0ea9fe2876070c0fd5f77"
        },
        "0x42a7b7dd785cd69714a189dffb3fd7d7174edc9ece837694ce50f7078f7c31ae": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d2050545f73555344655f323553455032303235"
        }
      }
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
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564addda": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000002000000000029402242217a"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564adddb": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000047"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564adddc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000840000108"
        },
        "0xad685eb1539e227904de4d026e2fa285114f8a6da148661059c13a946d709f4f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000020000000000288222ce2206"
        },
        "0xad685eb1539e227904de4d026e2fa285114f8a6da148661059c13a946d709f50": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x50542d735553446520555344652053706574656d626572203230323500000038"
        },
        "0xad685eb1539e227904de4d026e2fa285114f8a6da148661059c13a946d709f51": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000040000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f803": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8002faf08000000000103e8811229fe000a0005"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f804": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f805": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f806": {
          "previousValue": "0x000000000000000000002f000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002f00685e9ffb00000000000000000000000000000000"
        },
        "0xf6ae0d4ae2d98c3ea962f8b70bec8e22a5fee3ba42870edba969d3e15fcee29a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x50542d735553446520537461626c65636f696e732053657074656d6265722032"
        },
        "0xf6ae0d4ae2d98c3ea962f8b70bec8e22a5fee3ba42870edba969d3e15fcee29b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x3032350000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_USDe_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_14AUG2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FBTC.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0x60047994dc5a9c6ccd3aa5e34a586be9d37c95c2b71692caadd44f25aa07db34": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000138800000258000000002328"
        }
      }
    },
    "0x9f56094c450763769ba0ea9fe2876070c0fd5f77": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xf28b05d7cb1c50f8ef449275074a75213b412b4964112d5fc8ca14bc4785d5eb": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000"
        }
      }
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
          "newValue": "0xf8c4b50368072c048ca9487277d03cb819bf3db64a229c229e0cd24fc65b13d8"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009f56094c450763769ba0ea9fe2876070c0fd5f77"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000005d"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d205661726961626c6520446562742050545f73"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x555344655f323553455032303235000000000000000000000000000000000000"
        },
        "0xc6bb06cb7f92603de181bf256cd16846b93b752a170ff24824098b31aa008a7e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c654465627445746850545f73555344655f3235534550323032"
        },
        "0xc6bb06cb7f92603de181bf256cd16846b93b752a170ff24824098b31aa008a7f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x3500000000000000000000000000000000000000000000000000000000000000"
        }
      }
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
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f804": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f805": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f806": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002f000000000000000000000000000000000000000000"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f807": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000aa6e91c82942aeae040303bf96c15a6dbcb82ca0"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f809": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006c82c66622eb360fc973d3f492f9d8e9ea538b08"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f80a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009ec6f08190dea04a54f8afc53db96134e5e3fdfb"
        },
        "0xc00262ed55c3f8b3ae06bbb28c20fbb0e54ee84605c5c00c4ce60d963f62f80c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xd08db6eea880c34c8281cf6842ad4930fc629fe252408bdb9cdda6963634a943": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009f56094c450763769ba0ea9fe2876070c0fd5f77"
        }
      }
    }
  }
}
```