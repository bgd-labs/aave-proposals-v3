## Reserve changes

### Reserves added

#### ezETH ([0xbf5495Efe5DB9ce00f80364C8B423567e58d2110](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 150,000 ezETH |
| borrowCap | 0 ezETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee](https://etherscan.io/address/0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee) |
| oracleDecimals | 8 |
| oracleDescription | Capped ezETH / ezETH(ETH) / USD |
| oracleLatestAnswer | 2175.15939991 |
| usageAsCollateralEnabled | true |
| ltv | 75 % [7500] |
| liquidationThreshold | 78 % [7800] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0x5fefd7069a7D91d01f269DADE14526CCF3487810](https://etherscan.io/address/0x5fefd7069a7D91d01f269DADE14526CCF3487810) |
| variableDebtToken | [0x47eD0509e64615c0d5C6d39AF1B38D02Bc9fE58f](https://etherscan.io/address/0x47eD0509e64615c0d5C6d39AF1B38D02Bc9fE58f) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB](https://etherscan.io/address/0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB) |
| aTokenName | Aave Ethereum ezETH |
| aTokenSymbol | aEthezETH |
| aTokenUnderlyingBalance | 1 ezETH [1000000000000000000] |
| id | 38 |
| isPaused | false |
| variableDebtTokenName | Aave Ethereum Variable Debt ezETH |
| variableDebtTokenSymbol | variableDebtEthezETH |
| virtualAccountingActive | true |
| virtualBalance | 1 ezETH [1000000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


### Reserves altered

#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 480,000 rsETH | 550,000 rsETH |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH LST main | rsETH LST main |
| eMode.ltv (unchanged) | 92.5 % | 92.5 % |
| eMode.liquidationThreshold (unchanged) | 94.5 % | 94.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH, ETHx | ETHx |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: ezETH_WETH(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH_WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | ezETH |


### EMode: ezETH_wstETH(id: 8)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH_wstETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | ezETH |


### EMode: rsETH_WETH(id: 9)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH_WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | rsETH |


### EMode: weETH_WETH(id: 10)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH_WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | weETH |


### EMode: wstETH_WETH(id: 11)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH_WETH |
| eMode.ltv | - | 94.5 % |
| eMode.liquidationThreshold | - | 96 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wstETH |


### EMode: rsETH_wstETH(id: 12)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH_wstETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | rsETH |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "borrowableBitmap": {
        "from": "2147483650",
        "to": "2147483648"
      }
    },
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "274877906944",
        "eModeCategory": 7,
        "label": "ezETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "8": {
      "from": null,
      "to": {
        "borrowableBitmap": "2",
        "collateralBitmap": "274877906944",
        "eModeCategory": 8,
        "label": "ezETH_wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "9": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "68719476736",
        "eModeCategory": 9,
        "label": "rsETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "10": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "268435456",
        "eModeCategory": 10,
        "label": "weETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "11": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "2",
        "eModeCategory": 11,
        "label": "wstETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9450
      }
    },
    "12": {
      "from": null,
      "to": {
        "borrowableBitmap": "2",
        "collateralBitmap": "68719476736",
        "eModeCategory": 12,
        "label": "rsETH_wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "reserves": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "supplyCap": {
        "from": 480000,
        "to": 550000
      }
    },
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "aToken": "0x5fefd7069a7D91d01f269DADE14526CCF3487810",
        "aTokenName": "Aave Ethereum ezETH",
        "aTokenSymbol": "aEthezETH",
        "aTokenUnderlyingBalance": "1000000000000000000",
        "borrowCap": 0,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 38,
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
        "ltv": 7500,
        "oracle": "0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee",
        "oracleDecimals": 8,
        "oracleDescription": "Capped ezETH / ezETH(ETH) / USD",
        "oracleLatestAnswer": "217515939991",
        "reserveFactor": 1500,
        "supplyCap": 150000,
        "symbol": "ezETH",
        "underlying": "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x47eD0509e64615c0d5C6d39AF1B38D02Bc9fE58f",
        "variableDebtTokenName": "Aave Ethereum Variable Debt ezETH",
        "variableDebtTokenSymbol": "variableDebtEthezETH",
        "virtualAccountingActive": true,
        "virtualBalance": "1000000000000000000"
      }
    }
  },
  "strategies": {
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "from": null,
      "to": {
        "address": "0x9ec6F08190DeA04A54f8Afc53Db96134e5E3FdFB",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3070000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x47ed0509e64615c0d5c6d39af1b38d02bc9fe58f": {
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
          "newValue": "0xc13f57da86067152ee6285f936d0240faba0382780ec40b3a0dd604f879732bf"
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
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000ac725cb59d16c81061bdea61041a8a5e73da9ec6",
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
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xdac6437dacbb7cd7f4be454beb1f150c3dd9e2c30718a52f444c7e340f12f6a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000068c9c7bf43dbd0ebab102116bc7c3c9f7d9297ee"
        }
      }
    },
    "0x5fefd7069a7d91d01f269dade14526ccf3487810": {
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
          "newValue": "0x4161766520457468657265756d20657a45544800000000000000000000000026"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000038": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x61457468657a4554480000000000000000000000000000000000000000000012"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000039": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000008164cc65827dcfe994ab23944cbc90e0aa80bfcb12"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0xf098d6f0353793b040a63312ed9514177ed4da2cecf7b81ec7d0c43878f13fe3"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000464c71f6c2f760dda6093dcb91c24c39e5d6e18c"
        },
        "0x000000000000000000000000000000000000000000000000000000000000003d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bf5495efe5db9ce00f80364c8b423567e58d2110"
        },
        "0x14a553e31736f19e3e380cf55bfb2f82dfd6d880cd07235affb68d8d3e0cac4d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000000dbd2fc137a30000"
        },
        "0x2c491f7384cd762770fb659d7290ed7b4da75a7c480a8a5cc401f49c4807de64": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000033b2e3c9fd0803ce80000000000000000000000002386f26fc10000"
        },
        "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000007effd7b47bfd17e52fb7559d3f924201b9dbff3d",
          "label": "Implementation slot"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x000000000000000000000000000000000000000000000000000000000000003b": {
          "previousValue": "0x00000000000000000000000000000000000000000000002600000000000009c4",
          "newValue": "0x00000000000000000000000000000000000000000000002700000000000009c4"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000010000000002774251c2454"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554485f7773744554480000000000000000000000000000000000000018"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000040000000002774251c2454"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554485f5745544800000000000000000000000000000000000000000014"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000022774258024ea"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554485f57455448000000000000000000000000000000000000000016"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12be": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x223231bba097fdaa489ef1edea264b42574a9a3069405d4514f67b43f2328999": {
          "previousValue": "0x000000000000000000000000000000000000000000000aa88a00000000000000",
          "newValue": "0x000000000000000000000000000000000000000000002aa88a00000000000000"
        },
        "0x5d46e6a0b6ce602866577ce57755f7a25c0b12b1bede7a6b95375a6a31d15ed9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000bf5495efe5db9ce00f80364c8b423567e58d2110"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316ee": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x100000000000000000000003e80000249f000000000005dc851229fe1e781d4c"
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
          "newValue": "0x00000000000000000000260067e1689b00000000000000000000000000000000"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000005fefd7069a7d91d01f269dade14526ccf3487810"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000047ed0509e64615c0d5c6d39af1b38d02bc9fe58f"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000009ec6f08190dea04a54f8afc53db96134e5e3fdfb"
        },
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316f7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000de0b6b3a764000000000000000000000000000000000000"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x0000000000000000000000000000000000000000001000000000277424ea2422",
          "newValue": "0x0000000000000000000000000000000000000000001000000000277424ea2422"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000080000002",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000080000000"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000100000002774251c2454"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554485f5745544800000000000000000000000000000000000000000014"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xdacfe7a8adbf8359f41dcfa7c31c6a0f0553b393d1ed6bae9994c90e5024f1da": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000020000000000000000000"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481917": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000040000000002774251c2454"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481918": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554485f7773744554480000000000000000000000000000000000000018"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481919": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000010000000002774251c2454"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554485f5745544800000000000000000000000000000000000000000014"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xed45a05ce0954e645f11725167843283bb37c29952c0335b670d63d10fcad8ef": {
          "previousValue": "0x100000000000000000000003e800007530000000000105dc851229fe1d4c1c20",
          "newValue": "0x100000000000000000000003e800008647000000000105dc851229fe1d4c1c20"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": "AaveV3Ethereum.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.MKR.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.SNX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.UNI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LDO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ENS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ONE_INCH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FRAX.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.GHO.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.RPL.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sDAI.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.STG.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.KNC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.FXS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.crvUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.PYUSD.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.weETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.osETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.ETHx.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.sUSDe.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.tBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.cbBTC.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.USDS.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.rsETH.INTEREST_RATE_STRATEGY, AaveV3Ethereum.ASSETS.LBTC.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {
        "0xdac6437dacbb7cd7f4be454beb1f150c3dd9e2c30718a52f444c7e340f12f6a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000007530000002bc000000001194"
        }
      }
    },
    "0xbf5495efe5db9ce00f80364c8b423567e58d2110": {
      "label": "AaveV3EthereumLido.ASSETS.ezETH.UNDERLYING",
      "balanceDiff": null,
      "stateDiff": {
        "0x144dd7a010f3f6465282bebc9f1fadb88476c0e9abefa8a0865fd9c921c7c369": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000de0b6b3a7640000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xaf1b831f41c344b10b293f9f24770c65c47d37562c35c62aca287300130dac23": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000de0b6b3a7640000"
        },
        "0xd009ec6c13da0b4c89a84e1103e562efc1140ce59c5c395519bc3dbb152852ef": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x58cd54139f015db710156397d4286964226d102c8555db119384b5a83cf95bce": {
          "previousValue": "0x0067e1689a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067e1689a000000000003000000000000000000000000000000000000000000"
        },
        "0x58cd54139f015db710156397d4286964226d102c8555db119384b5a83cf95bcf": {
          "previousValue": "0x000000000000000000093a80000000000000680f8d1b00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000680f8d1b00000000000067e1689b"
        }
      }
    }
  }
}
```