## Reserve changes

### Reserves added

#### wrsETH ([0xEDfa23602D0EC14714057867A78d01e94176BEA0](https://basescan.org/address/0xEDfa23602D0EC14714057867A78d01e94176BEA0))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 400 wrsETH |
| borrowCap | 1 wrsETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x567E7f3DB2CD4C81872F829C8ab6556616818580](https://basescan.org/address/0x567E7f3DB2CD4C81872F829C8ab6556616818580) |
| oracleDecimals | 8 |
| oracleDescription | Capped rsETH / ETH / USD |
| oracleLatestAnswer | 2551.42984954 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 20 % [2000] |
| aToken | [0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1](https://basescan.org/address/0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1) |
| variableDebtToken | [0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb](https://basescan.org/address/0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base wrsETH |
| aTokenSymbol | aBaswrsETH |
| aTokenUnderlyingBalance | 0.05 wrsETH [50000000000000000] |
| id | 9 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt wrsETH |
| variableDebtTokenSymbol | variableDebtBaswrsETH |
| virtualAccountingActive | true |
| virtualBalance | 0.05 wrsETH [50000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 308 % |
| baseVariableBorrowRate | 1 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=10000000000000000000000000&maxVariableBorrowRate=3080000000000000000000000000) |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: rsETH/wstETH emode(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/wstETH emode |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | wrsETH |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "8",
        "collateralBitmap": "512",
        "eModeCategory": 4,
        "label": "rsETH/wstETH emode",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0xEDfa23602D0EC14714057867A78d01e94176BEA0": {
      "from": null,
      "to": {
        "aToken": "0x80a94C36747CF51b2FbabDfF045f6D22c1930eD1",
        "aTokenName": "Aave Base wrsETH",
        "aTokenSymbol": "aBaswrsETH",
        "aTokenUnderlyingBalance": "50000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 9,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
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
        "oracle": "0x567E7f3DB2CD4C81872F829C8ab6556616818580",
        "oracleDecimals": 8,
        "oracleDescription": "Capped rsETH / ETH / USD",
        "oracleLatestAnswer": "255142984954",
        "reserveFactor": 2000,
        "supplyCap": 400,
        "symbol": "wrsETH",
        "underlying": "0xEDfa23602D0EC14714057867A78d01e94176BEA0",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xe9541C77a111bCAa5dF56839bbC50894eba7aFcb",
        "variableDebtTokenName": "Aave Base Variable Debt wrsETH",
        "variableDebtTokenSymbol": "variableDebtBaswrsETH",
        "virtualAccountingActive": true,
        "virtualBalance": "50000000000000000"
      }
    }
  },
  "strategies": {
    "0xEDfa23602D0EC14714057867A78d01e94176BEA0": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "10000000000000000000000000",
        "maxVariableBorrowRate": "3080000000000000000000000000",
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
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e694": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e695": {
          "previousValue": "0x0000000000084595161401484a00000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000084595161401484a00000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e69c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000b1a2bc2ec5000000000000000000000000000000000000"
        },
        "0xf60bd2f8d5629b1ce9ca6d5bea0e6b3ab9f3c734a2034e2e6b1d8767604fc2b5": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000aa80",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000008aa80"
        }
      }
    },
    "0x2425a746911128c2eaa7bebdc9bc452ee52208a1": {
      "label": null,
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
          "newValue": "0x44f5ab9111f4322266edf9885af3572bf554e5522c2898c684b62a50630466ea"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000edfa23602d0ec14714057867a78d01e94176bea0"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x416176652042617365205661726961626c65204465627420777273455448003c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274426173777273455448000000000000000000002a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
        }
      }
    },
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x00946451196bb13f828ad850e9f3c7153a06a899d8af170a8bc48f4ff4bec25f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000567e7f3db2cd4c81872f829c8ab6556616818580"
        }
      }
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x319d156ea750b20d5370ef7b348b6ff1ab5d0256": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x7328c223b526ac18a2ca34e3cc928d22c174fde8c81d65ae5d17c01763d134b1": {
          "previousValue": "0x0067bf0b30000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067bf0b30000000000003000000000000000000000000000000000000000000"
        },
        "0x7328c223b526ac18a2ca34e3cc928d22c174fde8c81d65ae5d17c01763d134b2": {
          "previousValue": "0x000000000000000000093a8000000000000067ed2fb100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ed2fb100000000000067bf0b31"
        }
      }
    },
    "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4d0109d509e66df298257ffdd55f94a3814343aa": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x567e7f3db2cd4c81872f829c8ab6556616818580": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x57d2d46fc7ff2a7142d479f2f59e1e3f95447077": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6533a273f3ac84df91dcd654d6ebaba73687e246": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0cd8b138ec71684b5b65f6240bb9b685aba9fabf3d97bc10e8b205307d8952c2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x6bd36dd4fd75d52ae6d66619df7b9b0ac63a9d188d97ae0d10d9c9b4e4065eb6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x6ef6b6176091f94a8ad52c08e571f81598b226a2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000200277424ea2422"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f77737445544820656d6f64650000000000000000000000000024"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000008"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e693": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e800000019000000000107d0811229fe000a0005"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e694": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e695": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000084595161401484a00000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e696": {
          "previousValue": "0x0000000000000000000009000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000090067bf0b3100000000000000000000000000000000"
        }
      }
    },
    "0x71041dddad3595f9ced3dccfbe3d1f4b0a16bb70": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x80a94c36747cf51b2fbabdff045f6d22c1930ed1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000098f409fc4a42f34ae3c326c7f48ed01ae8caec69"
        }
      }
    },
    "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x00946451196bb13f828ad850e9f3c7153a06a899d8af170a8bc48f4ff4bec25f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000002bc000000641194"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x98f409fc4a42f34ae3c326c7f48ed01ae8caec69": {
      "label": null,
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
          "newValue": "0x00000000000000000000000000000000000000000000000000b1a2bc2ec50000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520426173652077727345544800000000000000000000000000000020"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x6142617377727345544800000000000000000000000000000000000000000014"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5f0d62ad97381b03aed07ce9f5fe6f8a4539c713cfee9635c362529943e6bb12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ba9424d650a4f5c80a0da641254d1acce2a37057"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000edfa23602d0ec14714057867a78d01e94176bea0"
        },
        "0x1af823d5498ee5188dde77af72b64836646560ae54176a8be5169b32412a211c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce8000000000000000000000000b1a2bc2ec50000"
        }
      }
    },
    "0x99daf760d2cfb770cc17e883df45454fe421616b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc3eacf0612346366db554c991d7858716db09f58": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0ddb2aa73249ebc485a9ad2992dc3fc615385f32871f28a7d38b9d3ca2311ffa": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x2b78f5116aef326f69cf016a7da752d77b0619f771660a055dfc4b1bb09b2239": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000b1a2bc2ec50000"
        },
        "0x9b8a597cd6826493ccbadba5a03145c87357f723e15f1f3434e83a10b63fd38f": {
          "previousValue": "0x000000000000000000000000000000000000000000000000012dfb0cb5e88000",
          "newValue": "0x000000000000000000000000000000000000000000000000007c585087238000"
        }
      }
    },
    "0xc73b7635630a94a3e9a595741cbb8a3845c27826": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe9541c77a111bcaa5df56839bbc50894eba7afcb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000002425a746911128c2eaa7bebdc9bc452ee52208a1"
        }
      }
    },
    "0xedfa23602d0ec14714057867a78d01e94176bea0": {
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
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e694": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e695": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e696": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000009000000000000000000000000000000000000000000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e697": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000080a94c36747cf51b2fbabdff045f6d22c1930ed1"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e699": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000e9541c77a111bcaa5df56839bbc50894eba7afcb"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e69a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000086ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e69c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x748ad6d0c5a24a04515706b6da6a7b0cb9e1a9408b9f3a5672a42f933d02d13e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000edfa23602d0ec14714057867a78d01e94176bea0"
        }
      }
    },
    "0xf9cc4f0d883f1a1eb2c253bdb46c254ca51e1f44": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```