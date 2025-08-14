## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH wstETH(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH wstETH(id: 5)



### EMode: rsETH/Stablecoins(id: 6)



### EMode: wstETH/WETH(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH/WETH |
| eMode.ltv | - | 94 % |
| eMode.liquidationThreshold | - | 96 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wstETH |


### EMode: weETH/wstETH(id: 8)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH/wstETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH, wstETH |
| eMode.collateralBitmap | - | weETH |


## Raw diff

```json
{
  "eModes": {
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "256",
        "eModeCategory": 7,
        "label": "wstETH/WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9400
      }
    },
    "8": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "32768",
        "eModeCategory": 8,
        "label": "weETH/wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000001002774258024b8"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554482f57455448000000000000000000000000000000000000000016"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x00000000000000000000000000000000000000000000000400002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000000000400002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x7273455448207773744554480000000000000000000000000000000000000018",
          "newValue": "0x7273455448207773744554480000000000000000000000000000000000000018"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x00000000000000000000000000000000000000000000000200002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000000000200002774251c2454"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x657a455448207773744554480000000000000000000000000000000000000018",
          "newValue": "0x657a455448207773744554480000000000000000000000000000000000000018"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481917": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000080002774251c2454"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481918": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554482f7773744554480000000000000000000000000000000000000018"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481919": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2e": {
          "previousValue": "0x00689e44bb000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00689e44bb000000000003000000000000000000000000000000000000000000"
        },
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2f": {
          "previousValue": "0x000000000000000000093a8000000000000068cc693c00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068cc693c000000000000689e44bc"
        }
      }
    }
  }
}
```