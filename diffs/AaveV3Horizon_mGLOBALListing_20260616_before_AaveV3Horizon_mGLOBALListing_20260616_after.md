## Reserve changes

### Reserves added

#### mGLOBAL ([0x7433806912Eae67919e66aea853d46Fa0aef98A8](https://etherscan.io/address/0x7433806912Eae67919e66aea853d46Fa0aef98A8))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 mGLOBAL |
| borrowCap | 0 mGLOBAL |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | false |
| oracle | [0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193](https://etherscan.io/address/0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193) |
| oracleDecimals | 8 |
| oracleDescription | mGLOBAL NAV |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 6 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 0 % [0] |
| aToken | [0x49d3cdE03813eE32DFD47F6aA3957d5F9CbAB985](https://etherscan.io/address/0x49d3cdE03813eE32DFD47F6aA3957d5F9CbAB985) |
| variableDebtToken | [0x40606ce958e14AD6BA575B00402d07438c3d58aC](https://etherscan.io/address/0x40606ce958e14AD6BA575B00402d07438c3d58aC) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x87593272C06f4FC49EC2942eBda0972d2F1Ab521](https://etherscan.io/address/0x87593272C06f4FC49EC2942eBda0972d2F1Ab521) |
| aTokenName | Aave Horizon RWA mGLOBAL |
| aTokenSymbol | aHorRwamGLOBAL |
| aTokenUnderlyingBalance | 0 mGLOBAL [0] |
| id | 10 |
| isPaused | false |
| variableDebtTokenName | Aave Horizon RWA Variable Debt mGLOBAL |
| variableDebtTokenSymbol | variableDebtHorRwamGLOBAL |
| virtualBalance | 0 mGLOBAL [0] |
| optimalUsageRatio | 99 % |
| maxVariableBorrowRate | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 0 % |
| variableRateSlope2 | 0 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=0&optimalUsageRatio=990000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=0) |


## Emodes changed

### EMode: VBILL GHO(id: 1)



### EMode: USTB GHO(id: 2)



### EMode: ACRED GHO(id: 3)



### EMode: USCC GHO(id: 4)



### EMode: mGLOBAL Stablecoins(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | mGLOBAL Stablecoins |
| eMode.ltv | 85 % | 75 % |
| eMode.liquidationThreshold | 89 % | 80 % |
| eMode.liquidationBonus | 3.1 % | 6 % |
| eMode.borrowableBitmap |  | USDC, RLUSD |
| eMode.collateralBitmap |  | mGLOBAL |


### EMode: USYC GHO(id: 6)



### EMode: (id: 7)



### EMode: JTRSY GHO(id: 8)



### EMode: (id: 9)



### EMode: JAAA GHO(id: 10)



## Raw diff

```json
{
  "eModes": {
    "5": {
      "borrowableBitmap": {
        "from": "0",
        "to": "6"
      },
      "collateralBitmap": {
        "from": "0",
        "to": "1024"
      },
      "label": {
        "from": "",
        "to": "mGLOBAL Stablecoins"
      },
      "liquidationBonus": {
        "from": 10310,
        "to": 10600
      },
      "liquidationThreshold": {
        "from": 8900,
        "to": 8000
      },
      "ltv": {
        "from": 8500,
        "to": 7500
      }
    }
  },
  "reserves": {
    "0x7433806912Eae67919e66aea853d46Fa0aef98A8": {
      "from": null,
      "to": {
        "aToken": "0x49d3cdE03813eE32DFD47F6aA3957d5F9CbAB985",
        "aTokenName": "Aave Horizon RWA mGLOBAL",
        "aTokenSymbol": "aHorRwamGLOBAL",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 10,
        "interestRateStrategy": "0x87593272C06f4FC49EC2942eBda0972d2F1Ab521",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10600,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193",
        "oracleDecimals": 8,
        "oracleDescription": "mGLOBAL NAV",
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 0,
        "supplyCap": 50000000,
        "symbol": "mGLOBAL",
        "underlying": "0x7433806912Eae67919e66aea853d46Fa0aef98A8",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x40606ce958e14AD6BA575B00402d07438c3d58aC",
        "variableDebtTokenName": "Aave Horizon RWA Variable Debt mGLOBAL",
        "variableDebtTokenSymbol": "variableDebtHorRwamGLOBAL",
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0x7433806912Eae67919e66aea853d46Fa0aef98A8": {
      "from": null,
      "to": {
        "address": "0x87593272C06f4FC49EC2942eBda0972d2F1Ab521",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "0",
        "optimalUsageRatio": "990000000000000000000000000",
        "variableRateSlope1": "0",
        "variableRateSlope2": "0"
      }
    }
  },
  "raw": {
    "0x09e88e877b39d883bafd46b65e7b06cc56963041": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 21,
        "newValue": 23
      },
      "stateDiff": {}
    },
    "0x40606ce958e14ad6ba575b00402d07438c3d58ac": {
      "label": null,
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 0,
        "newValue": 1
      },
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
          "newValue": "0x81e00ea8cb8089ca2b4fb01f08fce74cf74376fbdd2f9646efc22bdfe6330eda"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007433806912eae67919e66aea853d46fa0aef98a8"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000004d"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274486f725277616d474c4f42414c00000000000032"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000001d5d386a90cea8acea9fa75389e97cf5f1ae21d312"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000015f03e5de87c12cb2e2b8e5d6ecef0a9e21ab269",
          "label": "Implementation slot"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520486f72697a6f6e20525741205661726961626c652044656274206d"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x474c4f42414c0000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x49d3cde03813ee32dfd47f6aa3957d5f9cbab985": {
      "label": null,
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 0,
        "newValue": 1
      },
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000003"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520486f72697a6f6e20525741206d474c4f42414c0000000000000030"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61486f725277616d474c4f42414c00000000000000000000000000000000001c"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000001d5d386a90cea8acea9fa75389e97cf5f1ae21d312"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5cbeccd454cfa837c06b944dd12e47d9e3ced3ca9fb5295fe75b1136d5b964a6"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000070cc725b8f05e0f230b05c4e91abc651e121354f"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007433806912eae67919e66aea853d46fa0aef98a8"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000005148d810b1dae509d68f9d9219ad1d004ea32545",
          "label": "Implementation slot"
        }
      }
    },
    "0x83cb1b4af26eef6463ac20afbac9c0e2e017202f": {
      "label": "AaveV3EthereumHorizon.POOL_CONFIGURATOR",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 21,
        "newValue": 23
      },
      "stateDiff": {}
    },
    "0x87593272c06f4fc49ec2942ebda0972d2f1ab521": {
      "label": "AaveV3EthereumHorizon.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.USTB.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.USCC.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.USYC.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.JTRSY.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.JAAA.INTEREST_RATE_STRATEGY, AaveV3EthereumHorizon.ASSETS.VBILL.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x447dca2401334c9e987c05155fd1fb39e56fe81ff5ff8981882cb6038ac1adfa": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000000026ac"
        }
      }
    },
    "0x898e245d83ad255dc57b04978d0b4a12b94a557f": {
      "label": "AaveV3EthereumHorizon.POOL_CONFIGURATOR_IMPL",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 21,
        "newValue": 23
      },
      "stateDiff": {}
    },
    "0x985bcfab7e0f4ef2606cc5b64fc1a16311880442": {
      "label": "AaveV3EthereumHorizon.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x447dca2401334c9e987c05155fd1fb39e56fe81ff5ff8981882cb6038ac1adfa": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b92a68763b2f83e094595c7b41a7fb9d0f8da193"
        }
      }
    },
    "0xae05cd22df81871bc7cc2a04becfb516bfe332c8": {
      "label": "AaveV3EthereumHorizon.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000a0000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000b0000000000000000"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000284622c42134",
          "newValue": "0x000000000000000000000000000000000000000000000000040029681f401d4c"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6d474c4f42414c20537461626c65636f696e7300000000000000000000000026"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000006"
        },
        "0x76aacc2028d991243e90f9a326795e305ddcc7830dc0c1d3a776810a5954c285": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007433806912eae67919e66aea853d46fa0aef98a8"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x10000000000000000000000000002faf080000000000000001122968000a0005"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45002": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45003": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000a000000000000000000000000000000000000000000"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45004": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000049d3cde03813ee32dfd47f6aa3957d5f9cbab985"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45006": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000040606ce958e14ad6ba575b00402d07438c3d58ac"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45007": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000087593272c06f4fc49ec2942ebda0972d2f1ab521"
        },
        "0xb8b11b42f14bd8c450ab0cf5dc493bc59a3f2f9ec09daceae1db9473a3c45009": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    }
  }
}
```