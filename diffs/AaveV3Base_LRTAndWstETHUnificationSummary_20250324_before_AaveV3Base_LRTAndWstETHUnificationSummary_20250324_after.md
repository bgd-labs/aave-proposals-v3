## Reserve changes

### Reserves altered

#### weETH ([0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A](https://basescan.org/address/0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A))

| description | value before | value after |
| --- | --- | --- |
| ltv | 72.5 % [7250] | 75 % [7500] |
| liquidationThreshold | 75 % [7500] | 77 % [7700] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)



### EMode: weETH_WETH(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH_WETH |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1.25 % |
| eMode.borrowableBitmap | - | WETH |
| eMode.collateralBitmap | - | weETH |


### EMode: wstETH_WETH(id: 7)

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
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "32",
        "eModeCategory": 6,
        "label": "weETH_WETH",
        "liquidationBonus": 10125,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    },
    "7": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "8",
        "eModeCategory": 7,
        "label": "wstETH_WETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9600,
        "ltv": 9450
      }
    }
  },
  "reserves": {
    "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A": {
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
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x163a647ba7edd41caabec3eace9ce83f1a89ebea06fc099aa7fb98088da75131": {
          "previousValue": "0x0067e16d16000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067e16d16000000000003000000000000000000000000000000000000000000"
        },
        "0x163a647ba7edd41caabec3eace9ce83f1a89ebea06fc099aa7fb98088da75132": {
          "previousValue": "0x000000000000000000093a80000000000000680f919700000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000680f919700000000000067e16d17"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000020278d251c2454"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554485f5745544800000000000000000000000000000000000000000014"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0x06511f122a6ecc4dc280e9f39df5119c2e43c998c438a2cdea36d46bbc885187": {
          "previousValue": "0x100000000000000000000103e80000138800000000011194851229fe1d4c1c52",
          "newValue": "0x100000000000000000000103e80000138800000000011194851229fe1e141d4c"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000082774258024ea"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x7773744554485f57455448000000000000000000000000000000000000000016"
        },
        "0x1e4061ed12ce1f4439fe6c7922bd1dce45af754358ce2f94214f93749947e40c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    }
  }
}
```