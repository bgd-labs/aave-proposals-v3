## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH_wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | rsETH LST main | rsETH_wstETH |
| eMode.ltv | 92.5 % | 93 % |
| eMode.liquidationThreshold | 94.5 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


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
      "label": {
        "from": "rsETH LST main",
        "to": "rsETH_wstETH"
      },
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
        "borrowableBitmap": "2",
        "collateralBitmap": "1",
        "eModeCategory": 6,
        "label": "wstETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9450
      }
    }
  },
  "raw": {
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000012774258024ea"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554485f57455448000000000000000000000000000000000000000016"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000002"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000080277424ea2422",
          "newValue": "0x00000000000000000000000000000000000000000000000000802774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c",
          "newValue": "0x72734554485f7773744554480000000000000000000000000000000000000018"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x58cd54139f015db710156397d4286964226d102c8555db119384b5a83cf95bce": {
          "previousValue": "0x0067e16b0a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067e16b0a000000000003000000000000000000000000000000000000000000"
        },
        "0x58cd54139f015db710156397d4286964226d102c8555db119384b5a83cf95bcf": {
          "previousValue": "0x000000000000000000093a80000000000000680f8f8b00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000680f8f8b00000000000067e16b0b"
        }
      }
    }
  }
}
```