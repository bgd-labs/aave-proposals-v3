## Reserve changes

### Reserves altered

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 200,000,000 USDS | 40,000,000 USDS |
| borrowCap | 180,000,000 USDS | 36,000,000 USDS |
| reserveFactor | 10 % [1000] | 25 % [2500] |


## Emodes changed

### EMode: wstETH/WETH(id: 1)



### EMode: LRT Stablecoins main(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT Stablecoins main | LRT Stablecoins main |
| eMode.ltv (unchanged) | 75 % | 75 % |
| eMode.liquidationThreshold (unchanged) | 78 % | 78 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap | USDS, USDC, GHO | USDC, GHO |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)



### EMode: rsETH/Stablecoins(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH/Stablecoins | rsETH/Stablecoins |
| eMode.ltv (unchanged) | 72 % | 72 % |
| eMode.liquidationThreshold (unchanged) | 75 % | 75 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap | USDS, USDC, GHO | USDC, GHO |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: tETH/wstETH(id: 7)



## Raw diff

```json
{
  "eModes": {
    "2": {
      "borrowableBitmap": {
        "from": "76",
        "to": "72"
      }
    },
    "6": {
      "borrowableBitmap": {
        "from": "76",
        "to": "72"
      }
    }
  },
  "reserves": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "borrowCap": {
        "from": 180000000,
        "to": 36000000
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      },
      "supplyCap": {
        "from": 200000000,
        "to": 40000000
      }
    }
  },
  "raw": {
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000004c",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000048"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c3": {
          "previousValue": "0x1000000000000000000000000000bebc20000aba950003e88512000000000000",
          "newValue": "0x10000000000000000000000000002625a0000225510009c48512000000000000"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c4": {
          "previousValue": "0x000000000014268a1ef47c9def875a840000000003649325231e069a91ddf2cc",
          "newValue": "0x000000000010ce3ff19aab0f02255da2000000000365386af9e2b540d0ed32be"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c5": {
          "previousValue": "0x00000000002a03b4c3ed12cf966cf71b00000000037732ed931e115a1713991d",
          "newValue": "0x00000000002a04980fc371d50d0f0ff5000000000378933042b4bfe24aa5ea14"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c6": {
          "previousValue": "0x0000000000000000000002006921941300000000000000000000000000000000",
          "newValue": "0x000000000000000000000200693042bf00000000000000000000000000000000"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550cb": {
          "previousValue": "0x00000000000019d43b4ef4f5f29bf84c00000000000000000000000000000000",
          "newValue": "0x00000000000019d43b4ef4f5f29bf84c00000000000000011d08aa7ead91f5e8"
        },
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000004c",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000048"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86577": {
          "previousValue": "0x00693042be000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693042be000000000003000000000000000000000000000000000000000000"
        },
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86578": {
          "previousValue": "0x000000000000000000093a80000000000000695e673f00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e673f000000000000693042bf"
        }
      }
    }
  }
}
```