## Reserve changes

### Reserves added

#### WXPL (0x6100E367285b01F48D07953803A2d8dCA5D19873)

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 14,000,000 WXPL |
| borrowCap | 1 WXPL |
| debtCeiling | 1 $ [100] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | 0xF932477C37715aE6657Ab884414Bd9876FE3f750 |
| oracleDecimals | 8 |
| oracleDescription | XPL / USD |
| oracleLatestAnswer | 0.3007002 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 10 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 10 % [1000] |
| aToken | 0x5aA4bc74811D672DA5308019dA4779f673e60B47 |
| variableDebtToken | 0x7ec35d7008682c33dBC6b214E01D919e8d441e48 |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | 0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC |
| aTokenName | Aave Plasma XPL |
| aTokenSymbol | aPlaXPL |
| aTokenUnderlyingBalance | 350 WXPL [350000000000000000000] |
| id | 11 |
| isPaused | false |
| variableDebtTokenName | Aave Plasma Variable Debt XPL |
| variableDebtTokenSymbol | variableDebtPlaXPL |
| virtualBalance | 350 WXPL [350000000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 310 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 10 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) |


## Emodes changed

### EMode: USDe Stablecoins(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: weETH WETH(id: 3)



### EMode: weETH Stablecoins(id: 4)



### EMode: PT-USDe Stablecoins Jan 2026(id: 5)



### EMode: PT-USDe USDe Jan 2026(id: 6)



### EMode: PT-sUSDe Stablecoins Jan 2026(id: 7)



### EMode: PT-sUSDe USDe Jan 2026(id: 8)



### EMode: wrsETH/WETH(id: 9)



### EMode: wstETH/WETH(id: 10)



### EMode: syrupUSDT/USDT0(id: 11)



### EMode: WXPL__Stablecoins(id: 12)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | WXPL__Stablecoins |
| eMode.ltv | - | 50 % |
| eMode.liquidationThreshold | - | 55 % |
| eMode.liquidationBonus | - | 10 % |
| eMode.borrowableBitmap | - | USDT0 |
| eMode.collateralBitmap | - | WXPL |


## Raw diff

```json
{
  "eModes": {
    "12": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "2048",
        "eModeCategory": 12,
        "label": "WXPL__Stablecoins",
        "liquidationBonus": 11000,
        "liquidationThreshold": 5500,
        "ltv": 5000
      }
    }
  },
  "reserves": {
    "0x6100E367285b01F48D07953803A2d8dCA5D19873": {
      "from": null,
      "to": {
        "aToken": "0x5aA4bc74811D672DA5308019dA4779f673e60B47",
        "aTokenName": "Aave Plasma XPL",
        "aTokenSymbol": "aPlaXPL",
        "aTokenUnderlyingBalance": "350000000000000000000",
        "borrowCap": 1,
        "borrowingEnabled": false,
        "debtCeiling": 100,
        "decimals": 18,
        "id": 11,
        "interestRateStrategy": "0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 10,
        "ltv": 5,
        "oracle": "0xF932477C37715aE6657Ab884414Bd9876FE3f750",
        "oracleDecimals": 8,
        "oracleDescription": "XPL / USD",
        "oracleLatestAnswer": "30070020",
        "reserveFactor": 1000,
        "supplyCap": 14000000,
        "symbol": "WXPL",
        "underlying": "0x6100E367285b01F48D07953803A2d8dCA5D19873",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x7ec35d7008682c33dBC6b214E01D919e8d441e48",
        "variableDebtTokenName": "Aave Plasma Variable Debt XPL",
        "variableDebtTokenSymbol": "variableDebtPlaXPL",
        "virtualBalance": "350000000000000000000"
      }
    }
  },
  "strategies": {
    "0x6100E367285b01F48D07953803A2d8dCA5D19873": {
      "from": null,
      "to": {
        "address": "0x2B16E93bdB1897f517881B3c388bABD0C62C6cdC",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3100000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x034fd14b9ae6bb066a1f9f85a55e990b0b25c168": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac861ff": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86200": {
          "previousValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86206": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000012f939c99edab8000000000000000000000000000000000000"
        }
      }
    },
    "0x061d8e131f26512348ee5fa42e2df1ba9d6505e9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2b16e93bdb1897f517881b3c388babd0c62c6cdc": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x705def22ea7a46a388c843f4d41b62315e91dd2b2eb5c4481b1adc45778582c6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000003e8000000001194"
        }
      }
    },
    "0x33e0b3fc976dc9c516926ba48cfc0a9e10a2aaa5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x705def22ea7a46a388c843f4d41b62315e91dd2b2eb5c4481b1adc45778582c6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f932477c37715ae6657ab884414bd9876fe3f750"
        }
      }
    },
    "0x34df8a03ee66b224ded9e4885933cb5a343cc5ce": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x39ba8c26fc81e6a37a870115940ab32ed25c9ae7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3a57eaa3ca3794d66977326af7991eb3f6dd5a5a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x458d281bffce958e34571b33f1f26bd42aa27c44": {
      "label": null,
      "balanceDiff": null,
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
          "newValue": "0xcd38a6464134c943dacaebf02959ae15ba8a6f126bd1ee9bc3d960a0db2cd850"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006100e367285b01f48d07953803a2d8dca5d19873"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520506c61736d61205661726961626c6520446562742058504c00003a"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274506c6158504c0000000000000000000000000024"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        }
      }
    },
    "0x47aadaae1f05c978e6abb7568d11b7f6e0fc4d6a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5117f170716eceac8ef63d375bc7416afa6f4497": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x67d4b00397bd42c0f0f7a025d1054074dfc9fd8453da9d306c9774645968406b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        },
        "0x6a24eec3ea7f5ab213e50c1e4e4999b2ff9cb338a97a4d989bfdaca041ca8cfe": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
        }
      }
    },
    "0x5aa4bc74811d672da5308019da4779f673e60b47": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f6dac650da5616bc3206e969d7868e7c25805171",
          "label": "Implementation slot"
        }
      }
    },
    "0x6100e367285b01f48d07953803a2d8dca5d19873": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x05f8c70a811cb46bf19c569479ad55521c176eff04a54b0d6d42ad8b63cd7677": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x11975ea3f55ba5de40bb8679cab527c336d94a2bff67379936d2fed8ee6b405a": {
          "previousValue": "0x000000000000000000000000000000000000000000000012f939c99edab80000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x3506d9e8d314e5ff746af651f1299edc070db3cedd5cf404ecff771a2d57a306": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000012f939c99edab80000"
        }
      }
    },
    "0x7120b1f8e5b73c0c0dc99c6e52fe4937e7ea11e0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x85aaa47b6dc46495bb8824fad4583769726fea36efd831a35556690b830a8fbe": {
          "previousValue": "0x006904cee8000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006904cee8000000000003000000000000000000000000000000000000000000"
        },
        "0x85aaa47b6dc46495bb8824fad4583769726fea36efd831a35556690b830a8fbf": {
          "previousValue": "0x000000000000000000093a800000000000006932f36900000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006932f3690000000000006904cee9"
        }
      }
    },
    "0x7ec35d7008682c33dbc6b214e01d919e8d441e48": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000458d281bffce958e34571b33f1f26bd42aa27c44",
          "label": "Implementation slot"
        }
      }
    },
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9f9c2126d92f2068180bd6c3fea0e394a19c5fa0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa119f84bc1b8083f5061e4cf53705cbf1065ba27": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000008002af8157c1388"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5758504c5f5f537461626c65636f696e73000000000000000000000000000022"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac861fe": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000640000000000003e8000d59f8000000000103e881122af8000a0005"
        }
      }
    },
    "0xa860355f0ccfdc823f7332ac108317b2a1509c06": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc022b6c71c30a8ad52dac504efa132d13d99d2d9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe51b69e5722bf547866a4d7bc190c6e81b626806": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000b0000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000c0000000000000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac861ff": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86200": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86201": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000b006904cee900000000000000000000000000000000"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86202": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000005aa4bc74811d672da5308019da4779f673e60b47"
        },
        "0x4885f2ce1982f75a7fc1d98b42526f4407d990862fe68bbbba57872e8ac86204": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007ec35d7008682c33dbc6b214e01d919e8d441e48"
        },
        "0xf801cd91f4737d4fcbeb3108ca2da80cf9c1a7a3469221f74308d5bc7ba7610b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006100e367285b01f48d07953803a2d8dca5d19873"
        }
      }
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf6dac650da5616bc3206e969d7868e7c25805171": {
      "label": null,
      "balanceDiff": null,
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
          "newValue": "0x000000000000000000000000000000000000000000000012f939c99edab80000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520506c61736d612058504c000000000000000000000000000000001e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61506c6158504c0000000000000000000000000000000000000000000000000e"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x22ed367b49dc370ac34b1094b921b7e46eab2c56eabb16d7a528b2d88f8f1e3b"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000006100e367285b01f48d07953803a2d8dca5d19873"
        },
        "0x208dbdea7f47b2b5a177d450774cdf528c89faaec27279171fb7a3b116eacacd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce80000000000000000000012f939c99edab80000"
        }
      }
    },
    "0xf932477c37715ae6657ab884414bd9876fe3f750": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```