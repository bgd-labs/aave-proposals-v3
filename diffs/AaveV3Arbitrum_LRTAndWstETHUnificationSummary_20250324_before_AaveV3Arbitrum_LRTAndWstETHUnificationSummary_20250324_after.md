## Reserve changes

### Reserves altered

#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value before | value after |
| --- | --- | --- |
| ltv | 72.5 % [7250] | 75 % [7500] |
| liquidationThreshold | 75 % [7500] | 77 % [7700] |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH wstETH(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: weETH_WETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH_WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | weETH |


### EMode: wstETH_WETH(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH_WETH |
| eMode.ltv | - | 94.5 % |
| eMode.liquidationThreshold | - | 96 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wstETH |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "32768",
        "eModeCategory": 5,
        "label": "weETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "256",
        "eModeCategory": 6,
        "label": "wstETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9450
      }
    }
  },
  "reserves": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "liquidationThreshold": {
        "from": 7500,
        "to": 7700
      },
      "ltv": {
        "from": 7250,
        "to": 7500
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
          "newValue": "0x00000000000000000000000000000000000000000000000001002774258024ea"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554485f57455448000000000000000000000000000000000000000016"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x4f0da5bca7ea3ed2a5fd7fbf6d310bc05d68502cf438424218eeef530670c853": {
          "previousValue": "0x100000000000000000000203e800001adb00000000011194851229fe1d4c1c52",
          "newValue": "0x100000000000000000000203e800001adb00000000011194851229fe1e141d4c"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000080002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554485f5745544800000000000000000000000000000000000000000014"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x0cc2e7a263101f3ec4cff7d64ef5961ae18d1d70e854cb40c5302bf7c043d7b9": {
          "previousValue": "0x0067e1a74b000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067e1a74b000000000003000000000000000000000000000000000000000000"
        },
        "0x0cc2e7a263101f3ec4cff7d64ef5961ae18d1d70e854cb40c5302bf7c043d7ba": {
          "previousValue": "0x000000000000000000093a80000000000000680fcbcc00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000680fcbcc00000000000067e1a74c"
        }
      }
    }
  }
}
```