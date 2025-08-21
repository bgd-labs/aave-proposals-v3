## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH/wstETH/WETH ETH Correlated(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | ezETH wstETH | ezETH/wstETH/WETH ETH Correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH | WETH, wstETH |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH/wstETH/WETH ETH Correlated(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | rsETH wstETH | rsETH/wstETH/WETH ETH Correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH | WETH, wstETH |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: rsETH/Stablecoins(id: 6)



### EMode: wstETH/WETH ETH Correlated(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH/WETH ETH Correlated |
| eMode.ltv | - | 94 % |
| eMode.liquidationThreshold | - | 96 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | wstETH |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "borrowableBitmap": {
        "from": "256",
        "to": "272"
      },
      "label": {
        "from": "ezETH wstETH",
        "to": "ezETH/wstETH/WETH ETH Correlated"
      }
    },
    "5": {
      "borrowableBitmap": {
        "from": "256",
        "to": "272"
      },
      "label": {
        "from": "rsETH wstETH",
        "to": "rsETH/wstETH/WETH ETH Correlated"
      }
    },
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "16",
        "collateralBitmap": "256",
        "eModeCategory": 7,
        "label": "wstETH/WETH ETH Correlated",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9400
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x05e85fa548a9f2a222f818ee1193565122cf6bc9274cee49692c4c203e260767": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f7773744554482f574554482045544820436f7272656c61746564"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000001002774258024b8"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554482f574554482045544820436f7272656c61746564000000000034"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x496a2f4e085f64cdcb89a122836d82e2eae7b8b34a9d30987b642b406c1179b3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554482f7773744554482f574554482045544820436f7272656c61746564"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x00000000000000000000000000000000000000000000000400002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000000000400002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x7273455448207773744554480000000000000000000000000000000000000018",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000100",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x00000000000000000000000000000000000000000000000200002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000000000200002774251c2454"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x657a455448207773744554480000000000000000000000000000000000000018",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000041"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000100",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2e": {
          "previousValue": "0x0068a4d122000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068a4d122000000000003000000000000000000000000000000000000000000"
        },
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2f": {
          "previousValue": "0x000000000000000000093a8000000000000068d2f5a300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068d2f5a300000000000068a4d123"
        }
      }
    }
  }
}
```