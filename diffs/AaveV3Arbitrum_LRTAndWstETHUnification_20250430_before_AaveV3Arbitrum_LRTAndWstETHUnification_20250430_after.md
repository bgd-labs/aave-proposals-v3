## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH wstETH(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH wstETH | rsETH wstETH |
| eMode.ltv | 92.5 % | 93 % |
| eMode.liquidationThreshold | 94.5 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: rsETH/Stablecoins(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/Stablecoins |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDC, USD₮0 |
| eMode.collateralBitmap | - | rsETH |


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
        "borrowableBitmap": "36",
        "collateralBitmap": "262144",
        "eModeCategory": 6,
        "label": "rsETH/Stablecoins",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000004000029fe1d4c1c20"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f537461626c65636f696e73000000000000000000000000000022"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000024"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000040000277424ea2422",
          "newValue": "0x00000000000000000000000000000000000000000000000400002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x7273455448207773744554480000000000000000000000000000000000000018",
          "newValue": "0x7273455448207773744554480000000000000000000000000000000000000018"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xc201016ffcff91372d8b487e0ff78ba4e7738ee54ab48b285b35d26480999112": {
          "previousValue": "0x0068114f54000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068114f54000000000003000000000000000000000000000000000000000000"
        },
        "0xc201016ffcff91372d8b487e0ff78ba4e7738ee54ab48b285b35d26480999113": {
          "previousValue": "0x000000000000000000093a80000000000000683f73d500000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683f73d500000000000068114f55"
        }
      }
    }
  }
}
```