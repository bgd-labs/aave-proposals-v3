## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 82 % [8200] |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93.5 % | 93.5 % |
| eMode.liquidationThreshold (unchanged) | 95.5 % | 95.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH | WETH |
| eMode.collateralBitmap | wstETH, WETH | wstETH |


### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "collateralBitmap": {
        "from": "3",
        "to": "1"
      }
    }
  },
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "ltv": {
        "from": 0,
        "to": 8200
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x013e2c7567b6231e865bb9273f8c7656103611c0": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x342631c6cefc9cfbf97b2fe4aa242a236e1fd517": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7222182cb9c5320587b5148bf03eee107ad64578": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x9721e0a93ede703762dcc4525ca6474236d4824c45a1846547619d4fba36d08f": {
            "previousValue": "0x0067aa0532000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067aa0532000000000003000000000000000000000000000000000000000000"
          },
          "0x9721e0a93ede703762dcc4525ca6474236d4824c45a1846547619d4fba36d090": {
            "previousValue": "0x000000000000000000093a8000000000000067d829b300000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067d829b300000000000067aa0533"
          }
        }
      },
      "0xcfbf336fe147d643b9cb705648500e101504b16d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xf5b4664cb6d13189345119c60a948cdc7785d0fe": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000032774254e2486",
            "newValue": "0x00000000000000000000000000000000000000000000000000012774254e2486"
          },
          "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ebf": {
            "previousValue": "0x100000000000000000000103e80000dbba00000c5c1003e885122904206c0000",
            "newValue": "0x100000000000000000000103e80000dbba00000c5c1003e885122904206c2008"
          }
        }
      }
    }
  }
}
```