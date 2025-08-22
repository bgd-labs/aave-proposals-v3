## Emodes changed

### EMode: wstETH/WETH(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | ETH correlated | wstETH/WETH |
| eMode.ltv | 93.5 % | 95 % |
| eMode.liquidationThreshold | 95.5 % | 96.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH | WETH |
| eMode.collateralBitmap (unchanged) | wstETH | wstETH |


### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)



### EMode: rsETH/Stablecoins(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/Stablecoins |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDS, USDC, GHO |
| eMode.collateralBitmap | - | rsETH |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "label": {
        "from": "ETH correlated",
        "to": "wstETH/WETH"
      },
      "liquidationThreshold": {
        "from": 9550,
        "to": 9650
      },
      "ltv": {
        "from": 9350,
        "to": 9500
      }
    },
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "76",
        "collateralBitmap": "128",
        "eModeCategory": 6,
        "label": "rsETH/Stablecoins",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
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
          "newValue": "0x000000000000000000000000000000000000000000000000008029fe1d4c1c20"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f537461626c65636f696e73000000000000000000000000000022"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000004c"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000012774254e2486",
          "newValue": "0x0000000000000000000000000000000000000000000000000001277425b2251c"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb1": {
          "previousValue": "0x45544820636f7272656c6174656400000000000000000000000000000000001c",
          "newValue": "0x7773744554482f57455448000000000000000000000000000000000000000016"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x57c0d0964870c24387de1cb96a1c0d1e031544394130654a48994b8a35b62a81": {
          "previousValue": "0x0068114f4a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068114f4a000000000003000000000000000000000000000000000000000000"
        },
        "0x57c0d0964870c24387de1cb96a1c0d1e031544394130654a48994b8a35b62a82": {
          "previousValue": "0x000000000000000000093a80000000000000683f73cb00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683f73cb00000000000068114f4b"
        }
      }
    }
  }
}
```