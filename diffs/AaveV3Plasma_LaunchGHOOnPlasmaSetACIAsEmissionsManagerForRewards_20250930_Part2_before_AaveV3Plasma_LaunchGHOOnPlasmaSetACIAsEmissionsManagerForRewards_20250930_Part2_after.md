## Reserve changes

### Reserves added

#### GHO ([0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3](https://plasmascan.to/address/0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 GHO |
| borrowCap | 20,000,000 GHO |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1](https://plasmascan.to/address/0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1) |
| oracleDecimals | 8 |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 4.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 5 % [500] |
| aToken | [0x53349cBeD7A3F851f0722Bf3Fa8f1b93fA939BeF](https://plasmascan.to/address/0x53349cBeD7A3F851f0722Bf3Fa8f1b93fA939BeF) |
| variableDebtToken | [0xA4408E7C8b5D4481a2D8aD7Aa89f3576a6A4a5D6](https://plasmascan.to/address/0xA4408E7C8b5D4481a2D8aD7Aa89f3576a6A4a5D6) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC](https://plasmascan.to/address/0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC) |
| aTokenName | Aave Plasma GHO |
| aTokenSymbol | aPlaGHO |
| aTokenUnderlyingBalance | 10 GHO [10000000000000000000] |
| id | 12 |
| isPaused | false |
| variableDebtTokenName | Aave Plasma Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtPlaGHO |
| virtualBalance | 10 GHO [10000000000000000000] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 21.25 % |
| baseVariableBorrowRate | 1.25 % |
| variableRateSlope1 | 3.5 % |
| variableRateSlope2 | 16.5 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=35000000000000000000000000&variableRateSlope2=165000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=12500000000000000000000000&maxVariableBorrowRate=212500000000000000000000000) |


## Emodes changed

### EMode: USDe Stablecoins(id: 1)



### EMode: sUSDe Stablecoins(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | sUSDe Stablecoins | sUSDe Stablecoins |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 92 % | 92 % |
| eMode.liquidationBonus (unchanged) | 4 % | 4 % |
| eMode.borrowableBitmap | USDT0 | USDT0, GHO |
| eMode.collateralBitmap (unchanged) | USDe, sUSDe | USDe, sUSDe |


### EMode: weETH WETH(id: 3)



### EMode: weETH Stablecoins(id: 4)



### EMode: PT-USDe Stablecoins Jan 2026(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PT-USDe Stablecoins Jan 2026 | PT-USDe Stablecoins Jan 2026 |
| eMode.ltv | 88.6 % | 85.9 % |
| eMode.liquidationThreshold | 90.6 % | 87.9 % |
| eMode.liquidationBonus | 4 % | 4.9 % |
| eMode.borrowableBitmap | USDT0, USDe | USDT0, USDe, GHO |
| eMode.collateralBitmap (unchanged) | PT-USDe-15JAN2026 | PT-USDe-15JAN2026 |


### EMode: PT-USDe USDe Jan 2026(id: 6)



### EMode: PT-sUSDe Stablecoins Jan 2026(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PT-sUSDe Stablecoins Jan 2026 | PT-sUSDe Stablecoins Jan 2026 |
| eMode.ltv | 87.2 % | 84.4 % |
| eMode.liquidationThreshold | 89.2 % | 86.4 % |
| eMode.liquidationBonus | 5.4 % | 6 % |
| eMode.borrowableBitmap | USDT0, USDe | USDT0, USDe, GHO |
| eMode.collateralBitmap (unchanged) | PT-sUSDE-15JAN2026 | PT-sUSDE-15JAN2026 |


### EMode: PT-sUSDe USDe Jan 2026(id: 8)



### EMode: wrsETH/WETH(id: 9)



### EMode: wstETH/WETH(id: 10)



### EMode: syrupUSDT/USDT0(id: 11)



### EMode: WXPL Stablecoins(id: 12)



### EMode: GHO/USDT0(id: 13)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | GHO/USDT0 |
| eMode.ltv | - | 94 % |
| eMode.liquidationThreshold | - | 96 % |
| eMode.liquidationBonus | - | 2 % |
| eMode.borrowableBitmap | - | USDT0 |
| eMode.collateralBitmap | - | syrupUSDT |


### EMode: syrupUSDT/GHO(id: 14)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | syrupUSDT/GHO |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDT0 |
| eMode.collateralBitmap | - | syrupUSDT |


### EMode: syrupUSDT Stables(id: 15)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | syrupUSDT Stables |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDT0 |
| eMode.collateralBitmap | - | syrupUSDT, GHO |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "borrowableBitmap": {
        "from": "1",
        "to": "4097"
      }
    },
    "5": {
      "borrowableBitmap": {
        "from": "3",
        "to": "4099"
      },
      "liquidationBonus": {
        "from": 10400,
        "to": 10490
      },
      "liquidationThreshold": {
        "from": 9060,
        "to": 8790
      },
      "ltv": {
        "from": 8860,
        "to": 8590
      }
    },
    "7": {
      "borrowableBitmap": {
        "from": "3",
        "to": "4099"
      },
      "liquidationBonus": {
        "from": 10540,
        "to": 10600
      },
      "liquidationThreshold": {
        "from": 8920,
        "to": 8640
      },
      "ltv": {
        "from": 8720,
        "to": 8440
      }
    },
    "13": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "1024",
        "eModeCategory": 13,
        "label": "GHO/USDT0",
        "liquidationBonus": 10200,
        "liquidationThreshold": 9600,
        "ltv": 9400
      }
    },
    "14": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "1024",
        "eModeCategory": 14,
        "label": "syrupUSDT/GHO",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    },
    "15": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "5120",
        "eModeCategory": 15,
        "label": "syrupUSDT Stables",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3": {
      "from": null,
      "to": {
        "aToken": "0x53349cBeD7A3F851f0722Bf3Fa8f1b93fA939BeF",
        "aTokenName": "Aave Plasma GHO",
        "aTokenSymbol": "aPlaGHO",
        "aTokenUnderlyingBalance": "10000000000000000000",
        "borrowCap": 20000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 12,
        "interestRateStrategy": "0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10450,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1",
        "oracleDecimals": 8,
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 500,
        "supplyCap": 50000000,
        "symbol": "GHO",
        "underlying": "0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xA4408E7C8b5D4481a2D8aD7Aa89f3576a6A4a5D6",
        "variableDebtTokenName": "Aave Plasma Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtPlaGHO",
        "virtualBalance": "10000000000000000000"
      }
    }
  },
  "strategies": {
    "0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3": {
      "from": null,
      "to": {
        "address": "0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC",
        "baseVariableBorrowRate": "12500000000000000000000000",
        "maxVariableBorrowRate": "212500000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "35000000000000000000000000",
        "variableRateSlope2": "165000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x186f45b6e33fcf531c1542509b199646eb7fa968": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 25,
        "newValue": 27
      },
      "stateDiff": {}
    },
    "0x2b16e93bdb1897f517881b3c388babd0c62c6cdc": {
      "label": "AaveV3Plasma.ASSETS.USDT0.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.XAUt0.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.PT_USDe_15JAN2026.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.PT_sUSDE_15JAN2026.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.wrsETH.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.syrupUSDT.INTEREST_RATE_STRATEGY, AaveV3Plasma.ASSETS.WXPL.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2946f03ada64466b4e53a11bb68fb38d2e2ddd5250c0baafaee99496b6fc0a38": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000006720000015e0000007d23f0"
        }
      }
    },
    "0x33e0b3fc976dc9c516926ba48cfc0a9e10a2aaa5": {
      "label": "AaveV3Plasma.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2946f03ada64466b4e53a11bb68fb38d2e2ddd5250c0baafaee99496b6fc0a38": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b0e1c7830aa781362f79225559aa068e6bdaf1d1"
        }
      }
    },
    "0x360d8aa8f6b09b7bc57af34db2eb84dd87bf4d12": {
      "label": "GhoPlasma.GHO_CCIP_TOKEN_POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xc43d59e5cc2bf8f1b992795c27c2d5bb31adadefc93354955ac0e2ca9c5be0f7": {
          "previousValue": "0x000000000000000000000001690217ec00000000000000000000000000000000",
          "newValue": "0x0000000000000000000000016916243b0000000000013da329b6336471800000"
        },
        "0xc43d59e5cc2bf8f1b992795c27c2d5bb31adadefc93354955ac0e2ca9c5be0f8": {
          "previousValue": "0x000000000000001043561a88293000000000000000013da329b6336471800000",
          "newValue": "0x000000000000001043561a88293000000000000000013da329b6336471800000"
        },
        "0xc43d59e5cc2bf8f1b992795c27c2d5bb31adadefc93354955ac0e2ca9c5be0f9": {
          "previousValue": "0x00000000000000000000000168fa77930000000000013da31bd57cb0ca1c0000",
          "newValue": "0x0000000000000000000000016916243b0000000000013da329b6336471800000"
        },
        "0xc43d59e5cc2bf8f1b992795c27c2d5bb31adadefc93354955ac0e2ca9c5be0fa": {
          "previousValue": "0x000000000000001043561a88293000000000000000013da329b6336471800000",
          "newValue": "0x000000000000001043561a88293000000000000000013da329b6336471800000"
        }
      }
    },
    "0x39ba8c26fc81e6a37a870115940ab32ed25c9ae7": {
      "label": "AaveV3Plasma.POOL_CONFIGURATOR_IMPL",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 25,
        "newValue": 27
      },
      "stateDiff": {}
    },
    "0x5117f170716eceac8ef63d375bc7416afa6f4497": {
      "label": "AaveV3Plasma.EMISSION_MANAGER",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0e02b2c0482f5046c22f5571248a57158da27a0e7aba9a498664e4aa976ac803": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0xd9d2720178a2f03b44c6816cc5e79ef07ed6f6e081f93599081f86c1429b7a2e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x53349cbed7a3f851f0722bf3fa8f1b93fa939bef": {
      "label": null,
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 0,
        "newValue": 1
      },
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
          "newValue": "0x0000000000000000000000000000000000000000000000008ac7230489e80000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520506c61736d612047484f000000000000000000000000000000001e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61506c6147484f0000000000000000000000000000000000000000000000000e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4c86ec8c6b0bd6e1a6f576ca2d65769ebe43efcd1af76a8b53ea924f3b7a8718"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b77e872a68c62cfc0dfb02c067ecc3da23b4bbf3"
        },
        "0x208dbdea7f47b2b5a177d450774cdf528c89faaec27279171fb7a3b116eacacd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000008ac7230489e80000"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f6dac650da5616bc3206e969d7868e7c25805171",
          "label": "Implementation slot"
        }
      }
    },
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": "AaveV3Plasma.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000c0000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000d0000000000000000"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d6f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000040027d8258024b8"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d70": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x47484f2f55534454300000000000000000000000000000000000000000000012"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d71": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000080292c22d82210",
          "newValue": "0x0000000000000000000000000000000000000000000000000080296821c020f8"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x50542d735553446520537461626c65636f696e73204a616e203230323600003a",
          "newValue": "0x50542d735553446520537461626c65636f696e73204a616e203230323600003a"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000003",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001003"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000040028a023f02328"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7379727570555344542f47484f0000000000000000000000000000000000001a"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5aa": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e8002faf080001312d0001f4851228d2000a0005"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5ab": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5ac": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000a56fa5b99019a5c80000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5ad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000c006916243b00000000000000000000000000000000"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5ae": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000053349cbed7a3f851f0722bf3fa8f1b93fa939bef"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5b0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000a4408e7c8b5d4481a2d8ad7aa89f3576a6a4a5d6"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5b2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000008ac7230489e8000000000000000000000000000000000000"
        },
        "0x4138f036c3ffa28e5a438654f0c2140682f898abe9be8e78a8a4ce94f75bb5b3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x000000000000000000000000000000000000000000000000004028a02364229c",
          "newValue": "0x000000000000000000000000000000000000000000000000004028fa2256218e"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x50542d5553446520537461626c65636f696e73204a616e203230323600000038",
          "newValue": "0x50542d5553446520537461626c65636f696e73204a616e203230323600000038"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000003",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001003"
        },
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b2": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000628a023f02328",
          "newValue": "0x000000000000000000000000000000000000000000000000000628a023f02328"
        },
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000001",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001001"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000140028a023f02328"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x73797275705553445420537461626c6573000000000000000000000000000022"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x92d84fededc02335b4a53878577884cac3dba8d31e2d3d7ceaf95b0eca339acf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b77e872a68c62cfc0dfb02c067ecc3da23b4bbf3"
        },
        "0xf7b916e89ff198a55c9a32d87db68cde6f482de2d189099c6dab6507b6e177ae": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000aaaa2a",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000002aaaa2a"
        }
      }
    },
    "0xa4408e7c8b5d4481a2d8ad7aa89f3576a6a4a5d6": {
      "label": null,
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 0,
        "newValue": 1
      },
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
          "newValue": "0x8ce7e236ce05c533b9ff2782482229d527795d0baaba22d0491828ae2b40ebe4"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b77e872a68c62cfc0dfb02c067ecc3da23b4bbf3"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520506c61736d61205661726961626c6520446562742047484f00003a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274506c6147484f0000000000000000000000000024"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000458d281bffce958e34571b33f1f26bd42aa27c44",
          "label": "Implementation slot"
        }
      }
    },
    "0xa860355f0ccfdc823f7332ac108317b2a1509c06": {
      "label": "AaveV3Plasma.ACL_MANAGER",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xa468be17ccb04a81200cd39fdb6e4ec81e44858b0e7814526f2643905eae614f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0xb77e872a68c62cfc0dfb02c067ecc3da23b4bbf3": {
      "label": "GhoPlasma.GHO_TOKEN",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x6689af251dc0b2943fc392fc8ef86ab234ede24d687011823b8f8b0aede7d219": {
          "previousValue": "0x000000000000000000000000000000000000000000295be9f92b296dfbe80000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x8745960c47bf71bf554325fbbad03c9b5685e46b51cfde2bf2bde8c1b6b659f2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000295be96e64066972000000"
        },
        "0x9ff2999df03f19dda98f7a8abb01d592df96e9d3ba818a81f818be4a10cc0896": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xa2fd85a9b347f1041e91f80427bc02531df11e736b8ac39ce9699066ca5ef08f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xcb72e34ffa495f2e49783f4479a5e1f0d2d04da0253d58025a0866938d8c0a18": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000008ac7230489e80000"
        }
      }
    },
    "0xbada742e7ff54595f9049eef1cc5aaf4364988b9": {
      "label": null,
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x1ec0abbf0635e36499113ff15936f70705c387ddd2e9a57f6c4b41d7163572ad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000295be96e64066972000000"
        },
        "0x4a11f94e20a93c79f6ec743a1954ec4fc2c08429ae2122118bf234b2185c81b8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d06114f714becd6f373e5ce94e07278ef46ebf37"
        },
        "0x528409ae7d19f60e7983a73badac54e7d38d52b21a6f5486bc0450fdc95062fe": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0xc022b6c71c30a8ad52dac504efa132d13d99d2d9": {
      "label": "AaveV3Plasma.POOL_CONFIGURATOR",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 25,
        "newValue": 27
      },
      "stateDiff": {}
    },
    "0xc563fc29dd0a7e56d1b5cc7bbf1dcf044d755303": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x8e98d45570ff3fa69e12ac542fefda790c069ada879027e142a20629e641c04a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d06114f714becd6f373e5ce94e07278ef46ebf37"
        }
      }
    },
    "0xd06114f714becd6f373e5ce94e07278ef46ebf37": {
      "label": null,
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d70be7e6111ea563226cb8e53b1f195da4e566e2"
        },
        "0xd416476fb6e6a1adff89bd6a549896895440a6eb6eb559f8157f82060fee3072": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xee422176155ce30ad5fb06988dabe5f66c217b34ce1729f1ade63e07846cdb3c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xf0ffe599d5370647658fff0ba785eed348fbb3de8f8c11048497c36b9859b2c4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": "GovernanceV3Plasma.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb458": {
          "previousValue": "0x006916243a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006916243a000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb459": {
          "previousValue": "0x000000000000000000093a80000000000000694448bb00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000694448bb0000000000006916243b"
        }
      }
    }
  }
}
```