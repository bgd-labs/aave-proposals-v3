## Reserve changes

### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80 % [8000] | 82 % [8200] |
| liquidationThreshold | 81 % [8100] | 83 % [8300] |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 82 % [8200] | 84 % [8400] |
| liquidationThreshold | 83 % [8300] | 85 % [8500] |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93.5 % | 93.5 % |
| eMode.liquidationThreshold (unchanged) | 95.5 % | 95.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH |  |
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


### EMode: wstETH/WETH(id: 7)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | wstETH/WETH |
| eMode.ltv | - | 95 % |
| eMode.liquidationThreshold | - | 96.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - |  |
| eMode.collateralBitmap | - |  |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "2",
        "to": "0"
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
    },
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "0",
        "collateralBitmap": "0",
        "eModeCategory": 7,
        "label": "wstETH/WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9650,
        "ltv": 9500
      }
    }
  },
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "liquidationThreshold": {
        "from": 8100,
        "to": 8300
      },
      "ltv": {
        "from": 8000,
        "to": 8200
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "liquidationThreshold": {
        "from": 8300,
        "to": 8500
      },
      "ltv": {
        "from": 8200,
        "to": 8400
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
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000277425b2251c"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554482f57455448000000000000000000000000000000000000000016"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000012774254e2486",
          "newValue": "0x00000000000000000000000000000000000000000000000000012774254e2486"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000002",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2": {
          "previousValue": "0x100000000000000000000103e800009eb100000445c001f4851229681fa41f40",
          "newValue": "0x100000000000000000000103e800009eb100000445c001f485122968206c2008"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ebf": {
          "previousValue": "0x100000000000000000000103e80000dbba00000c5c1003e885122904206c2008",
          "newValue": "0x100000000000000000000103e80000dbba00000c5c1003e885122904213420d0"
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