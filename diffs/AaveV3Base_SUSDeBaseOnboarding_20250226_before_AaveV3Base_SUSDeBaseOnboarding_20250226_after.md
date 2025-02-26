## Reserve changes

### Reserves added

#### sUSDe ([0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2](https://basescan.org/address/0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,200,000 sUSDe |
| borrowCap | 0 sUSDe |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | false |
| oracle | [0xf19d560eB8d2ADf07BD6D13ed03e1D11215721F9](https://basescan.org/address/0xf19d560eB8d2ADf07BD6D13ed03e1D11215721F9) |
| oracleDecimals | 8 |
| oracleDescription | USDT / USD |
| oracleLatestAnswer | 0.99881 |
| usageAsCollateralEnabled | true |
| ltv | 70 % [7000] |
| liquidationThreshold | 73 % [7300] |
| liquidationBonus | 8.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1](https://basescan.org/address/0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1) |
| variableDebtToken | [0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb](https://basescan.org/address/0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base sUSDe |
| aTokenSymbol | aBassUSDe |
| aTokenUnderlyingBalance | 100 sUSDe [100000000000000000000] |
| id | 9 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt sUSDe |
| variableDebtTokenSymbol | variableDebtBassUSDe |
| virtualAccountingActive | true |
| virtualBalance | 100 sUSDe [100000000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: sUSDE stablecoins emode(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sUSDE stablecoins emode |
| eMode.ltv | - | 88 % |
| eMode.liquidationThreshold | - | 90 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - |  |
| eMode.collateralBitmap | - |  |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "0",
        "collateralBitmap": "0",
        "eModeCategory": 4,
        "label": "sUSDE stablecoins emode",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9000,
        "ltv": 8800
      }
    }
  },
  "reserves": {
    "0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2": {
      "from": null,
      "to": {
        "aToken": "0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1",
        "aTokenName": "Aave Base sUSDe",
        "aTokenSymbol": "aBassUSDe",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 9,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10850,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7300,
        "ltv": 7000,
        "oracle": "0xf19d560eB8d2ADf07BD6D13ed03e1D11215721F9",
        "oracleDecimals": 8,
        "oracleDescription": "USDT / USD",
        "oracleLatestAnswer": "99881000",
        "reserveFactor": 2000,
        "supplyCap": 1200000,
        "symbol": "sUSDe",
        "underlying": "0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb",
        "variableDebtTokenName": "Aave Base Variable Debt sUSDe",
        "variableDebtTokenSymbol": "variableDebtBassUSDe",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3070000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x185477906b46d9b8de0deb73a1bbfb87b5b51bc3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae36": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae37": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae3e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000056bc75e2d6310000000000000000000000000000000000000"
        },
        "0xf60bd2f8d5629b1ce9ca6d5bea0e6b3ab9f3c734a2034e2e6b1d8767604fc2b5": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000aa80",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000008aa80"
        }
      }
    },
    "0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x14641a714f09189e33d86aaec613867fdb48a8d278bdb595b1c770aa5d855349": {
          "previousValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x51b79117f0d19359fa0a1fce433b7973bff4f3904a9d2fd91b35f82ca2697566": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xa18d21615084b9826c1206470c494e38cf3dd3212fd19c94f77d788fe6b183fd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000056bc75e2d63100000"
        }
      }
    },
    "0x2425a746911128c2eaa7bebdc9bc452ee52208a1": {
      "label": "AaveV3Base.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
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
          "newValue": "0xd767dd53fe120d00bd11a085c28f13be254ade6bce8edebf471b7fcda8bbfa21"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000211cc4dd073734da055fbf44a2b4667d5e5fe5d2"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652042617365205661726961626c65204465627420735553446500003a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744261737355534465000000000000000000000028"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
        }
      }
    },
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": "AaveV3Base.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xa881669ae165a4c5763e4114ce67328c4988b515f53278697e4aadb693e63b9e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f19d560eb8d2adf07bd6d13ed03e1d11215721f9"
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
        "0x7328c223b526ac18a2ca34e3cc928d22c174fde8c81d65ae5d17c01763d134b1": {
          "previousValue": "0x0067bf631a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067bf631a000000000003000000000000000000000000000000000000000000"
        },
        "0x7328c223b526ac18a2ca34e3cc928d22c174fde8c81d65ae5d17c01763d134b2": {
          "previousValue": "0x000000000000000000093a8000000000000067ed879b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ed879b00000000000067bf631b"
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
    "0x6533a273f3ac84df91dcd654d6ebaba73687e246": {
      "label": "AaveV3Base.EMISSION_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0x0cd8b138ec71684b5b65f6240bb9b685aba9fabf3d97bc10e8b205307d8952c2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x3d15f8e4415e7537f8962b40d8ff06f8636404fce2b7722621bf121500d35980": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x6ef6b6176091f94a8ad52c08e571f81598b226a2": {
      "label": "AaveV3Base.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000028a023282260"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x735553444520737461626c65636f696e7320656d6f646500000000000000002e"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae35": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8000124f8000000000007d001122a621c841b58"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae36": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae37": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae38": {
          "previousValue": "0x0000000000000000000009000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000090067bf631b00000000000000000000000000000000"
        }
      }
    },
    "0x80a94c36747cf51b2fbabdff045f6d22c1930ed1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000098f409fc4a42f34ae3c326c7f48ed01ae8caec69",
          "label": "Implementation slot"
        }
      }
    },
    "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
      "label": "AaveV3Base.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDbC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.GHO.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xa881669ae165a4c5763e4114ce67328c4988b515f53278697e4aadb693e63b9e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000002bc000000001194"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": "AaveV3Base.ACL_ADMIN, GovernanceV3Base.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x98f409fc4a42f34ae3c326c7f48ed01ae8caec69": {
      "label": "AaveV3Base.DEFAULT_A_TOKEN_IMPL_REV_1",
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
          "newValue": "0x416176652042617365207355534465000000000000000000000000000000001e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6142617373555344650000000000000000000000000000000000000000000012"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x22183749124f0980f8197a6becc09bade9f4c9f470e9754d7292c0b815f6e42f"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ba9424d650a4f5c80a0da641254d1acce2a37057"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000211cc4dd073734da055fbf44a2b4667d5e5fe5d2"
        },
        "0x1af823d5498ee5188dde77af72b64836646560ae54176a8be5169b32412a211c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000056bc75e2d63100000"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdc2d2fa8e7b824a2c16128446e288280dcb12844": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
      "label": "AaveV3Base.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Base.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe9541c77a111bcaa5df56839bbc50894eba7afcb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000002425a746911128c2eaa7bebdc9bc452ee52208a1",
          "label": "Implementation slot"
        }
      }
    },
    "0xf19d560eb8d2adf07bd6d13ed03e1d11215721f9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000900000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000000a00000000000009c4"
        },
        "0x748ad6d0c5a24a04515706b6da6a7b0cb9e1a9408b9f3a5672a42f933d02d13e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000211cc4dd073734da055fbf44a2b4667d5e5fe5d2"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae36": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae37": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae38": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000009000000000000000000000000000000000000000000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae39": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000080a94c36747cf51b2fbabdff045f6d22c1930ed1"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae3b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e9541c77a111bcaa5df56839bbc50894eba7afcb"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae3c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000086ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae3e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
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