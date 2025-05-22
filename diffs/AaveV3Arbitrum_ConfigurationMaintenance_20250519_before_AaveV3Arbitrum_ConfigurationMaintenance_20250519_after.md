## Reserve changes

### Reserves altered

#### FRAX ([0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | DAI, USDC, USD₮0, EURS, USDC |  |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USD₮0, EURS, USDC | DAI, USDC, USD₮0, EURS, USDC |


### EMode: ETH correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH, weETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, weETH | WETH, wstETH, weETH |


### EMode: ezETH wstETH(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH wstETH(id: 5)



### EMode: rsETH/Stablecoins(id: 6)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "4261",
        "to": "0"
      }
    },
    "2": {
      "borrowableBitmap": {
        "from": "33040",
        "to": "16"
      }
    }
  },
  "reserves": {
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x231517525e76b52ef0565e25ae6e726ef61fa7481dd09cfc0b1bb129c697db69": {
          "previousValue": "0x10005f5e1000000000000003e80001627e000011690807d0851229681c200000",
          "newValue": "0x10005f5e1000000000000003e80001627e000011690807d0811229681c200000"
        },
        "0x67dcc86da9aaaf40a183002157e56801115aa6057705e43279b4c1c90942d6b4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000008110",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000010"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000000010a5",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xca1941ffd2876354dca11a76468fb85895321380bff6312dcbd61b110f22031e": {
          "previousValue": "0x00682b223d000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b223d000000000003000000000000000000000000000000000000000000"
        },
        "0xca1941ffd2876354dca11a76468fb85895321380bff6312dcbd61b110f22031f": {
          "previousValue": "0x000000000000000000093a80000000000000685946be00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000685946be000000000000682b223e"
        }
      }
    }
  }
}
```