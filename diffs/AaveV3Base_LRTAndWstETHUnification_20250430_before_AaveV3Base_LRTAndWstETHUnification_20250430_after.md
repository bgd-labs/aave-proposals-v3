## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH/wstETH | rsETH/wstETH |
| eMode.ltv | 92.5 % | 93 % |
| eMode.liquidationThreshold | 94.5 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | wrsETH | wrsETH |


### EMode: rsETH/USDC(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/USDC |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDC |
| eMode.collateralBitmap | - | wrsETH |


### EMode: weETH/WETH(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH/WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1.25 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | weETH |


### EMode: wstETH/WETH(id: 8)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH/WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wstETH |


### EMode: cbETH/WETH(id: 9)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | cbETH/WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 2 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | cbETH |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "liquidationThreshold": {
        "from": 9450,
        "to": 9500
      },
      "ltv": {
        "from": 9250,
        "to": 9300
      }
    },
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "512",
        "eModeCategory": 6,
        "label": "rsETH/USDC",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
      }
    },
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "32",
        "eModeCategory": 7,
        "label": "weETH/WETH",
        "liquidationBonus": 10125,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "8": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "8",
        "eModeCategory": 8,
        "label": "wstETH/WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "9": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "2",
        "eModeCategory": 9,
        "label": "cbETH/WETH",
        "liquidationBonus": 10200,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xd5310f85f4460a57771b0ba7c922e1273458411836157e863377c3ceba09ccc5": {
          "previousValue": "0x0068114f54000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068114f54000000000003000000000000000000000000000000000000000000"
        },
        "0xd5310f85f4460a57771b0ba7c922e1273458411836157e863377c3ceba09ccc6": {
          "previousValue": "0x000000000000000000093a80000000000000683f73d500000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683f73d500000000000068114f55"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000020029fe1d4c1c20"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f5553444300000000000000000000000000000000000000000014"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000020278d251c2454"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554482f5745544800000000000000000000000000000000000000000014"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000200277424ea2422",
          "newValue": "0x00000000000000000000000000000000000000000000000002002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x72734554482f7773744554480000000000000000000000000000000000000018",
          "newValue": "0x72734554482f7773744554480000000000000000000000000000000000000018"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481917": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000082774251c2454"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481918": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554482f57455448000000000000000000000000000000000000000016"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481919": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000227d8251c2454"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x63624554482f5745544800000000000000000000000000000000000000000014"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    }
  }
}
```