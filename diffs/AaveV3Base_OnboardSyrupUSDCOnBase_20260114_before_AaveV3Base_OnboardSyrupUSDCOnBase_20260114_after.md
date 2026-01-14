## Reserve changes

### Reserves added

#### syrupUSDC ([0x660975730059246A68521a3e2FBD4740173100f5](https://basescan.org/address/0x660975730059246A68521a3e2FBD4740173100f5))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 syrupUSDC |
| borrowCap | 1 syrupUSDC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397](https://basescan.org/address/0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397) |
| oracleDecimals | 8 |
| oracleDescription | Capped SyrupUSDC / USDC / USD |
| oracleLatestAnswer | 1.14634502 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 50 % [5000] |
| aToken | [0xD7424238CcbE7b7198Ab3cFE232e0271E22da7bd](https://basescan.org/address/0xD7424238CcbE7b7198Ab3cFE232e0271E22da7bd) |
| variableDebtToken | [0x57B8C05ee2cD9d0143eBC21FBD9288C39B9F716c](https://basescan.org/address/0x57B8C05ee2cD9d0143eBC21FBD9288C39B9F716c) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base syrupUSDC |
| aTokenSymbol | aBassyrupUSDC |
| aTokenUnderlyingBalance | 100 syrupUSDC [100000000] |
| id | 14 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt syrupUSDC |
| variableDebtTokenSymbol | variableDebtBassyrupUSDC |
| virtualBalance | 100 syrupUSDC [100000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)



### EMode: rsETH/USDC(id: 6)



### EMode: weETH/WETH(id: 7)



### EMode: wstETH/WETH(id: 8)



### EMode: cbETH/WETH(id: 9)



### EMode: cbBTC Stablecoins(id: 10)



### EMode: SyrupUSDC__USDC_GHO(id: 11)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | SyrupUSDC__USDC_GHO |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | WETH |


## Raw diff

```json
{
  "eModes": {
    "11": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "1",
        "eModeCategory": 11,
        "label": "SyrupUSDC__USDC_GHO",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0x660975730059246A68521a3e2FBD4740173100f5": {
      "from": null,
      "to": {
        "aToken": "0xD7424238CcbE7b7198Ab3cFE232e0271E22da7bd",
        "aTokenName": "Aave Base syrupUSDC",
        "aTokenSymbol": "aBassyrupUSDC",
        "aTokenUnderlyingBalance": "100000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 6,
        "id": 14,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
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
        "oracle": "0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397",
        "oracleDecimals": 8,
        "oracleDescription": "Capped SyrupUSDC / USDC / USD",
        "oracleLatestAnswer": "114634502",
        "reserveFactor": 5000,
        "supplyCap": 50000000,
        "symbol": "syrupUSDC",
        "underlying": "0x660975730059246A68521a3e2FBD4740173100f5",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x57B8C05ee2cD9d0143eBC21FBD9288C39B9F716c",
        "variableDebtTokenName": "Aave Base Variable Debt syrupUSDC",
        "variableDebtTokenSymbol": "variableDebtBassyrupUSDC",
        "virtualBalance": "100000000"
      }
    }
  },
  "strategies": {
    "0x660975730059246A68521a3e2FBD4740173100f5": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": "AaveV3Base.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2b16cf7a21b66b0cc219a4a8f8e9402369c97f6ec8061fbd338a58b579f042de": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000a61f10bb2f05a94728734a8a95673adbca9b8397"
        }
      }
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2023c3bd05b942cf6cbd5cd645de4d3fea19926fd4838b16303d2ed627508472": {
          "previousValue": "0x00696711a8000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00696711a8000000000003000000000000000000000000000000000000000000"
        },
        "0x2023c3bd05b942cf6cbd5cd645de4d3fea19926fd4838b16303d2ed627508473": {
          "previousValue": "0x000000000000000000093a800000000000006995362900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069953629000000000000696711a9"
        }
      }
    },
    "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
      "label": "AaveV3Base.POOL_CONFIGURATOR",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 36,
        "newValue": 38
      },
      "stateDiff": {}
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": "AaveV3Base.POOL_CONFIGURATOR_IMPL",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 36,
        "newValue": 38
      },
      "stateDiff": {}
    },
    "0x57b8c05ee2cd9d0143ebc21fbd9288c39b9f716c": {
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
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000005"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000035": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5da0052463da5416fc197036e27cb1dc9986455c344e94231975c60b17ab0db9"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000660975730059246a68521a3e2fbd4740173100f5"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c65446562744261737379727570555344430000000000000030"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000006"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007354dc700a1a2ab9622f2292b60ca1ced5b204d0",
          "label": "Implementation slot"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652042617365205661726961626c652044656274207379727570555344"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4300000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x6533a273f3ac84df91dcd654d6ebaba73687e246": {
      "label": "AaveV3Base.EMISSION_MANAGER",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2a16797294797cebee9f530b9fb91703d28e19a2e7774e74a6df057eeb0d69c6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x7ae3374e37083fdb642f0ee6183cc858f3d02867990684d7431ae0447141945b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x660975730059246a68521a3e2fbd4740173100f5": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x10b5362173766a80d4cfe3e4dddffbd4fbc967f380e2122f66780b1510aed004": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x6ce9c23738708422c08a86b8ba018b845fb92a4682ab9454d0aee4ffaaa43c98": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x880f7664da400568495a954fbe31c0ddf37769c8a6de63fe69089496eb097a69": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100"
        }
      }
    },
    "0x6e2afd57a161d12f34f416c29619bfeacac8aa18": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 36,
        "newValue": 38
      },
      "stateDiff": {}
    },
    "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
      "label": "AaveV3Base.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDbC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.ezETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.wrsETH.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.EURC.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Base.ASSETS.tBTC.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2b16cf7a21b66b0cc219a4a8f8e9402369c97f6ec8061fbd338a58b579f042de": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000003e8000000001194"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000e00000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000000f00000000000009c4"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec00": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x10000000000000000000000000002faf08000000000113888106000000000000"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec01": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec02": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec03": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000e00696711a900000000000000000000000000000000"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec04": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000d7424238ccbe7b7198ab3cfe232e0271e22da7bd"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec06": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000057b8c05ee2cd9d0143ebc21fbd9288c39b9f716c"
        },
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec08": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000005f5e10000000000000000000000000000000000"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000128a023f02328"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5379727570555344435f5f555344435f47484f00000000000000000000000026"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12be": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x229f20bcd3cc05a7ee68bb1632cc35b79bb8c7425622671f3831d7287f10cb53": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000660975730059246a68521a3e2fbd4740173100f5"
        }
      }
    },
    "0xd7424238ccbe7b7198ab3cfe232e0271e22da7bd": {
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
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000005"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520426173652073797275705553444300000000000000000000000026"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x614261737379727570555344430000000000000000000000000000000000001a"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000006"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xb2dc2f4fe87547913256fbe710f3b84f2d4aa3f891f1191d57aae854f35737e8"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000660975730059246a68521a3e2fbd4740173100f5"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000273e4b97c3f5280aff4949aa19a27ff54968458d",
          "label": "Implementation slot"
        },
        "0xe02ba9fe3fe72fe4457de0f0f3000b7de04e0ed037bd90e34d6d4182590c700d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000000000000005f5e100"
        }
      }
    }
  }
}
```