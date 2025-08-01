## Reserve changes

### Reserves added

#### ezETH ([0xbf5495Efe5DB9ce00f80364C8B423567e58d2110](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000 ezETH |
| borrowCap | 0 ezETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C](https://etherscan.io/address/0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C) |
| oracleDecimals | 8 |
| oracleDescription | Capped ezETH / ezETH(ETH) / USD |
| oracleLatestAnswer | 3853.16057099 |
| usageAsCollateralEnabled | true |
| ltv | 0.05 % [5] |
| liquidationThreshold | 0.1 % [10] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0x481a2acf3A72ffDc602A9541896Ca1DB87f86cf7](https://etherscan.io/address/0x481a2acf3A72ffDc602A9541896Ca1DB87f86cf7) |
| variableDebtToken | [0x7EC9Afe70f8FD603282eBAcbc9058A83623E2899](https://etherscan.io/address/0x7EC9Afe70f8FD603282eBAcbc9058A83623E2899) |
| borrowingEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum ezETH |
| aTokenSymbol | aEthezETH |
| aTokenUnderlyingBalance | 0 ezETH [0] |
| id | 50 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt ezETH |
| variableDebtTokenSymbol | variableDebtEthezETH |
| virtualBalance | 0 ezETH [0] |
| optimalUsageRatio | 80 % |
| maxVariableBorrowRate | 0 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 0 % |
| variableRateSlope2 | 0 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=0&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=0) |


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



### EMode: PT-sUSDe USDe September 2025(id: 18)



### EMode: PT-USDe Stablecoins September 2025(id: 19)



### EMode: PT-USDe USDe September 2025(id: 20)



### EMode: ezETH/stablecoins(id: 21)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH/stablecoins |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | USDC, USDT |
| eMode.collateralBitmap | - | ezETH |


### EMode: ezETH/wstETH(id: 22)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH/wstETH |
| eMode.ltv | - | 92 % |
| eMode.liquidationThreshold | - | 94 % |
| eMode.liquidationBonus | - | 2 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | ezETH |


## Raw diff

```json
{
  "eModes": {
    "21": {
      "from": null,
      "to": {
        "borrowableBitmap": "264",
        "collateralBitmap": "1125899906842624",
        "eModeCategory": 21,
        "label": "ezETH/stablecoins",
        "liquidationBonus": 10300,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    },
    "22": {
      "from": null,
      "to": {
        "borrowableBitmap": "2",
        "collateralBitmap": "1125899906842624",
        "eModeCategory": 22,
        "label": "ezETH/wstETH",
        "liquidationBonus": 10200,
        "liquidationThreshold": 9400,
        "ltv": 9200
      }
    }
  },
  "reserves": {
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "aToken": "0x481a2acf3A72ffDc602A9541896Ca1DB87f86cf7",
        "aTokenName": "Aave Ethereum ezETH",
        "aTokenSymbol": "aEthezETH",
        "aTokenUnderlyingBalance": "0",
        "borrowCap": 0,
        "borrowingEnabled": false,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 50,
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
        "oracle": "0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ezETH / ezETH(ETH) / USD",
        "oracleLatestAnswer": "385316057099",
        "reserveFactor": 1500,
        "supplyCap": 50000,
        "symbol": "ezETH",
        "underlying": "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x7EC9Afe70f8FD603282eBAcbc9058A83623E2899",
        "variableDebtTokenName": "Aave Ethereum Variable Debt ezETH",
        "variableDebtTokenSymbol": "variableDebtEthezETH",
        "virtualBalance": "0"
      }
    }
  },
  "strategies": {
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "0",
        "optimalUsageRatio": "800000000000000000000000000",
        "variableRateSlope1": "0",
        "variableRateSlope2": "0"
      }
    }
  },
  "raw": {
    "0x481a2acf3a72ffdc602a9541896ca1db87f86cf7": {
      "label": null,
      "balanceDiff": null,
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
          "newValue": "0x4161766520457468657265756d20657a45544800000000000000000000000026"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61457468657a4554480000000000000000000000000000000000000000000012"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xd606f29c741d6c6e915bb83b73ee74b890f7e77c5750e1b2af07e45ea0ecfdea"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bf5495efe5db9ce00f80364c8b423567e58d2110"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000097f5b96c7dac8547251330b63760951a4fab448d",
          "label": "Implementation slot"
        }
      }
    },
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xdac6437dacbb7cd7f4be454beb1f150c3dd9e2c30718a52f444c7e340f12f6a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f3d49021ff3bbbfdfc1992a4b09e5d1d141d044c"
        }
      }
    },
    "0x7ec9afe70f8fd603282ebacbc9058a83623e2899": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000000": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000003"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000035": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0b4bfafa8fb5c437ae4177feda44cdb31b382fac1f713de0963a9705d44e17eb"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000037": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bf5495efe5db9ce00f80364c8b423567e58d2110"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7661726961626c6544656274457468657a455448000000000000000000000028"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000012"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b58ed8ec66e43de3fecd27e351485e7efe006f38",
          "label": "Implementation slot"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4161766520457468657265756d205661726961626c65204465627420657a4554"
        },
        "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4800000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000003200000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000003300000000000009c4"
        },
        "0x174bfcac418d313240a60c90a60ef30998dc3532dc3f813e7d899b7e535632ce": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bf5495efe5db9ce00f80364c8b423567e58d2110"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316ee": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e800000c35000000000005dc811229fe000a0005"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316ef": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000003200688cb2e700000000000000000000000000000000"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000481a2acf3a72ffdc602a9541896ca1db87f86cf7"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007ec9afe70f8fd603282ebacbc9058a83623e2899"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x79c6e29436490262cb24ee8bc0beb79364a1b588e1732d1098b1d9c2838ed8ac": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000004000000000000283c23f02328"
        },
        "0x79c6e29436490262cb24ee8bc0beb79364a1b588e1732d1098b1d9c2838ed8ad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554482f737461626c65636f696e73000000000000000000000000000022"
        },
        "0x79c6e29436490262cb24ee8bc0beb79364a1b588e1732d1098b1d9c2838ed8ae": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000108"
        },
        "0xc41b4a359cb27641212875221810eb6d8e79d1a2806792a4e2a528d39ef7de28": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000400000000000027d824b823f0"
        },
        "0xc41b4a359cb27641212875221810eb6d8e79d1a2806792a4e2a528d39ef7de29": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554482f7773744554480000000000000000000000000000000000000018"
        },
        "0xc41b4a359cb27641212875221810eb6d8e79d1a2806792a4e2a528d39ef7de2a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.eBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RLUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_eUSDE_29MAY2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PT_sUSDE_31JUL2025.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDtb.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xdac6437dacbb7cd7f4be454beb1f150c3dd9e2c30718a52f444c7e340f12f6a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001f40"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x7f6764beb2e7bda5d37196dccaaf19eedcfd75069c8ae61ff739b58f0245c006": {
          "previousValue": "0x00688cb2e6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00688cb2e6000000000003000000000000000000000000000000000000000000"
        },
        "0x7f6764beb2e7bda5d37196dccaaf19eedcfd75069c8ae61ff739b58f0245c007": {
          "previousValue": "0x000000000000000000093a8000000000000068bad76700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068bad767000000000000688cb2e7"
        }
      }
    }
  }
}
```