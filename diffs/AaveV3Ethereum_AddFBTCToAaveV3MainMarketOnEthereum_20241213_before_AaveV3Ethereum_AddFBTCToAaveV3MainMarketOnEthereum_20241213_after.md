## Reserve changes

### Reserves added

#### FBTC ([0xC96dE26018A54D51c097160568752c4E3BD6C364](https://etherscan.io/address/0xC96dE26018A54D51c097160568752c4E3BD6C364))

| description | value |
| --- | --- |
| decimals | 8 |
| isActive | true |
| isFrozen | false |
| supplyCap | 200 FBTC |
| borrowCap | 100 FBTC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) |
| oracleDecimals | 8 |
| oracleDescription | BTC / USD |
| oracleLatestAnswer | 94745.25 |
| usageAsCollateralEnabled | true |
| ltv | 73 % [7300] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 50 % [5000] |
| aToken | [0x4B0821e768Ed9039a70eD1E80E15E76a5bE5Df5F](https://etherscan.io/address/0x4B0821e768Ed9039a70eD1E80E15E76a5bE5Df5F) |
| variableDebtToken | [0x3c20fbFD32243Dd9899301C84bCe17413EeE0A0C](https://etherscan.io/address/0x3c20fbFD32243Dd9899301C84bCe17413EeE0A0C) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum FBTC |
| aTokenSymbol | aEthFBTC |
| aTokenUnderlyingBalance | 0.001 FBTC [100000] |
| id | 40 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt FBTC |
| variableDebtTokenSymbol | variableDebtEthFBTC |
| virtualAccountingActive | true |
| virtualBalance | 0.001 FBTC [100000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 304 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: FBTC/WBTC(id: 8)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | FBTC/WBTC |
| eMode.ltv | - | 84 % |
| eMode.liquidationThreshold | - | 86 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | WBTC |
| eMode.collateralBitmap | - | FBTC |


## Raw diff

```json
{
  "eModes": {
    "8": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "1099511627776",
        "eModeCategory": 8,
        "label": "FBTC/WBTC",
        "liquidationBonus": 10300,
        "liquidationThreshold": 8600,
        "ltv": 8400
      }
    }
  },
  "reserves": {
    "0xC96dE26018A54D51c097160568752c4E3BD6C364": {
      "from": null,
      "to": {
        "aToken": "0x4B0821e768Ed9039a70eD1E80E15E76a5bE5Df5F",
        "aTokenName": "Aave Ethereum FBTC",
        "aTokenSymbol": "aEthFBTC",
        "aTokenUnderlyingBalance": "100000",
        "borrowCap": 100,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 8,
        "id": 40,
        "interestRateStrategy": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
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
        "oracle": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "oracleDecimals": 8,
        "oracleDescription": "BTC / USD",
        "oracleLatestAnswer": "9474525000000",
        "reserveFactor": 5000,
        "supplyCap": 200,
        "symbol": "FBTC",
        "underlying": "0xC96dE26018A54D51c097160568752c4E3BD6C364",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x3c20fbFD32243Dd9899301C84bCe17413EeE0A0C",
        "variableDebtTokenName": "Aave Ethereum Variable Debt FBTC",
        "variableDebtTokenSymbol": "variableDebtEthFBTC",
        "virtualAccountingActive": true,
        "virtualBalance": "100000"
      }
    }
  },
  "strategies": {
    "0xC96dE26018A54D51c097160568752c4E3BD6C364": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3040000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x185477906b46d9b8de0deb73a1bbfb87b5b51bc3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25acdf": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace0": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000186a000000000000000000000000000000000"
        },
        "0xdacfe7a8adbf8359f41dcfa7c31c6a0f0553b393d1ed6bae9994c90e5024f1da": {
          "previousValue": "0x000000000000000000000000000000000000000000002aaa8a802000000aaaaa",
          "newValue": "0x000000000000000000000000000000000000000000022aaa8a802000000aaaaa"
        }
      }
    },
    "0x223d844fc4b006d67c0cdbd39371a9f73f69d974": {
      "label": "AaveV3Ethereum.EMISSION_MANAGER, AaveV3EthereumEtherFi.EMISSION_MANAGER, AaveV3EthereumLido.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x145efc079e54c71d8ab3d1001e46878131b70ee596b36e3ff7819b6c3a5674a5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x1ca83c1ec67740d234a590e1886c343011e5f97efbcad788ead5a1c8033e9f62": {
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
    "0x3c20fbfd32243dd9899301c84bce17413eee0a0c": {
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
    "0x4a3411ac2948b33c69666b35cc6d055b27ea84f1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4b0821e768ed9039a70ed1e80e15e76a5be5df5f": {
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
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xb390137caa68caf243feed0ce2cfc0106e46c102fba671ab670a3461357dde78": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c"
        }
      }
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x67fadecd89164265e5c47e00f2e6239d22fdc6834e14bcb04ef8be15889e2bbd": {
          "previousValue": "0x00680f2fd2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00680f2fd2000000000003000000000000000000000000000000000000000000"
        },
        "0x67fadecd89164265e5c47e00f2e6239d22fdc6834e14bcb04ef8be15889e2bbe": {
          "previousValue": "0x000000000000000000093a80000000000000683d545300000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683d5453000000000000680f2fd3"
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
          "newValue": "0x00000000000000000000000000000000000000000000000000000000000186a0"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d20464254430000000000000000000000000024"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6145746846425443000000000000000000000000000000000000000000000010"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb08"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xab6eab7e75cce90ff97c47ddbc859f12e79529805d379664c336d0b748bdf764"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c96de26018a54d51c097160568752c4e3bd6c364"
        },
        "0x2c491f7384cd762770fb659d7290ed7b4da75a7c480a8a5cc401f49c4807de64": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce8000000000000000000000000000000000186a0"
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
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25acde": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e80000000c80000000641388850829fe1e781c84"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25acdf": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace0": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace1": {
          "previousValue": "0x0000000000000000000028000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000002800680f2fd300000000000000000000000000000000"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481917": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000010000000000283c219820d0"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481918": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x464254432f574254430000000000000000000000000000000000000000000012"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481919": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xb390137caa68caf243feed0ce2cfc0106e46c102fba671ab670a3461357dde78": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000753000000190000000001194"
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
          "newValue": "0x17e09456e417c854130cb5fc110be948318e14bc6c5945f7f5e4f5945768da07"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c96de26018a54d51c097160568752c4e3bd6c364"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744574684642544300000000000000000000000026"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb08"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d205661726961626c6520446562742046425443"
        }
      }
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": "AaveV3Ethereum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc96de26018a54d51c097160568752c4e3bd6c364": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2022e56a2d37a0e7b2339f9a850bd446cd2dab30c80988af47a31b0e9fda5cfc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x31faaccc375cc214196213bd298e4f0b16d02b9261eb8049291f7b503901f2c6": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000001adb0",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000002710"
        },
        "0xf6dc6cdc39a7eaf4e3ad55adfede365d66cc38be4d16f88754faa65fda77bbd9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000000186a0"
        }
      }
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
    "0xf4030086522a5beea4988f8ca5b36dbc97bee88c": {
      "label": "AaveV3Ethereum.ASSETS.cbBTC.ORACLE",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000002800000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000002900000000000009c4"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25acdf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000028000000000000000000000000000000000000000000"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000004b0821e768ed9039a70ed1e80e15e76a5be5df5f"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000003c20fbfd32243dd9899301c84bce17413eee0a0c"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009ec6f08190dea04a54f8afc53db96134e5e3fdfb"
        },
        "0x3ac954c9393f97dc542a64c3cb762571588a4e206e615a2d51e2ff19be25ace7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xd7a3d42dc052a02f0a1829d68686ea3890b68bc0506f5d5411bf9f18ee66e766": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c96de26018a54d51c097160568752c4e3bd6c364"
        }
      }
    }
  }
}
```