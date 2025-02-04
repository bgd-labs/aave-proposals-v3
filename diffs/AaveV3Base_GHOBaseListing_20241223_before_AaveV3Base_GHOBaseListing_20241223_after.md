## Reserve changes

### Reserves added

#### GHO ([0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee](https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 2,500,000 GHO |
| borrowCap | 2,250,000 GHO |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://basescan.org/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
| oracleDecimals | 8 |
| oracleLatestAnswer | 1 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 10 % [1000] |
| aToken | [0x067ae75628177FD257c2B1e500993e1a0baBcBd1](https://basescan.org/address/0x067ae75628177FD257c2B1e500993e1a0baBcBd1) |
| variableDebtToken | [0x38e59ADE183BbEb94583d44213c8f3297e9933e9](https://basescan.org/address/0x38e59ADE183BbEb94583d44213c8f3297e9933e9) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://basescan.org/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave Base GHO |
| aTokenSymbol | aBasGHO |
| aTokenUnderlyingBalance | 1 GHO [1000000000000000000] |
| id | 8 |
| isPaused | false |
| variableDebtTokenName | Aave Base Variable Debt GHO |
| variableDebtTokenSymbol | variableDebtBasGHO |
| virtualAccountingActive | true |
| virtualBalance | 1 GHO [1000000000000000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 59.5 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9.5 % |
| variableRateSlope2 | 50 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=595000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee": {
      "from": null,
      "to": {
        "aToken": "0x067ae75628177FD257c2B1e500993e1a0baBcBd1",
        "aTokenName": "Aave Base GHO",
        "aTokenSymbol": "aBasGHO",
        "aTokenUnderlyingBalance": "1000000000000000000",
        "borrowCap": 2250000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 8,
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
        "oracle": "0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73",
        "oracleDecimals": 8,
        "oracleLatestAnswer": "100000000",
        "reserveFactor": 1000,
        "supplyCap": 2500000,
        "symbol": "GHO",
        "underlying": "0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x38e59ADE183BbEb94583d44213c8f3297e9933e9",
        "variableDebtTokenName": "Aave Base Variable Debt GHO",
        "variableDebtTokenSymbol": "variableDebtBasGHO",
        "virtualAccountingActive": true,
        "virtualBalance": "1000000000000000000"
      }
    }
  },
  "strategies": {
    "0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "595000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "95000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x067ae75628177fd257c2b1e500993e1a0babcbd1": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000098f409fc4a42f34ae3c326c7f48ed01ae8caec69"
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
            "newValue": "0xafadae5f174ce8792f064102d9c7825f700733e1922a8ccc1351982f24441141"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000037": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000006bb7a212910682dcfdbd5bcbb3e28fb4e8da10ee"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x416176652042617365205661726961626c6520446562742047484f0000000036"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003c": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x7661726961626c654465627442617347484f0000000000000000000000000024"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
          }
        }
      },
      "0x2b22e425c1322fba0dbf17bb1da25d71811ee7ba": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40e": {
            "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40f": {
            "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f416": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000de0b6b3a764000000000000000000000000000000000000"
          }
        }
      },
      "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xc982d0ced1f8c746631cfe3f49173ca3ba25fe902be9cce56024300ebb89fd7a": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000fc421ad3c883bf9e7c4f42de845c4e4405799e73"
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
          "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc5": {
            "previousValue": "0x006798fdca000000000002000000000000000000000000000000000000000000",
            "newValue": "0x006798fdca000000000003000000000000000000000000000000000000000000"
          },
          "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc6": {
            "previousValue": "0x000000000000000000093a8000000000000067c7224b00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067c7224b0000000000006798fdcb"
          }
        }
      },
      "0x38e59ade183bbeb94583d44213c8f3297e9933e9": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000002425a746911128c2eaa7bebdc9bc452ee52208a1"
          }
        }
      },
      "0x3a9c471f13c9ca1ebdf440cf713c8404e498f9c3": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x100000000000000000000000000002625a000022551003e88512000000000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40e": {
            "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40f": {
            "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f410": {
            "previousValue": "0x0000000000000000000008000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000008006798fdcb00000000000000000000000000000000"
          }
        }
      },
      "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4d0109d509e66df298257ffdd55f94a3814343aa": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x6533a273f3ac84df91dcd654d6ebaba73687e246": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x34912faa3b94f6260811dc90a5fcd80ba8bbd27a331cfb3ec427d39ba71b94ab": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
          },
          "0xf944e233e6a975ddc399fd33c6934da7dc0e17700dea63dc462b634655557be1": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
          }
        }
      },
      "0x6bb7a212910682dcfdbd5bcbb3e28fb4e8da10ee": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xc982d0ced1f8c746631cfe3f49173ca3ba25fe902be9cce56024300ebb89fd7a": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000000000000000000001388000003b6000000002328"
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
            "newValue": "0x0000000000000000000000000000000000000000000000000de0b6b3a7640000"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000037": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x4161766520426173652047484f0000000000000000000000000000000000001a"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000038": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x6142617347484f0000000000000000000000000000000000000000000000000e"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000039": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000f9cc4f0d883f1a1eb2c253bdb46c254ca51e1f4412"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0xd95ff480dfea0a7d204013fdf8d80bacff144fe289b39887d7b8fffc54fa187e"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003c": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000ba9424d650a4f5c80a0da641254d1acce2a37057"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000006bb7a212910682dcfdbd5bcbb3e28fb4e8da10ee"
          },
          "0x2dc2afdad33a5feea586a9545052327b65d28efb10d11fa69e77da986a1031cd": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000000de0b6b3a7640000"
          }
        }
      },
      "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa58fb47be9074828215a173564c0cd10f6f249bf": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x00000000000000000000000000000000000000000000000800000000000009c4",
            "newValue": "0x00000000000000000000000000000000000000000000000900000000000009c4"
          },
          "0x05725f7419f52ac606bc65a60e5ab85095522694ed898882d2777964ee382600": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000006bb7a212910682dcfdbd5bcbb3e28fb4e8da10ee"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40e": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f40f": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f410": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000008000000000000000000000000000000000000000000"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f411": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000067ae75628177fd257c2b1e500993e1a0babcbd1"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f413": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000038e59ade183bbeb94583d44213c8f3297e9933e9"
          },
          "0x3fc949ca89c9af8f3bf977ace52c826b7b79c9f52b6c2a1a960c0b4f1387f414": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000086ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5"
          }
        }
      },
      "0xb0e1c7830aa781362f79225559aa068e6bdaf1d1": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x153355011b7d7d042d97174072318f29dbc50882f47ebb07d64ddb67538aea5d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000de0b6b3a7640000"
          },
          "0x618b6524a63db141c6ec50e3099a7bb2a245c9f2f08057a6ca507f1a6edc4b3a": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xb80f08d50aa0366243778050783b5dd4d04222561c98abe78842dedaf9ce8580": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000de0b6b3a7640000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          }
        }
      },
      "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xf9cc4f0d883f1a1eb2c253bdb46c254ca51e1f44": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```