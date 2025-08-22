## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 2 % | 2 % |
| eMode.borrowableBitmap | WETH, cbETH, wstETH, weETH | WETH |
| eMode.collateralBitmap (unchanged) | WETH, cbETH, wstETH, weETH | WETH, cbETH, wstETH, weETH |


### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)



### EMode: rsETH/USDC(id: 6)



### EMode: weETH/WETH(id: 7)



### EMode: wstETH/WETH(id: 8)



### EMode: cbETH/WETH(id: 9)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "43",
        "to": "1"
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a5": {
          "previousValue": "0x00682b22ac000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b22ac000000000003000000000000000000000000000000000000000000"
        },
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a6": {
          "previousValue": "0x000000000000000000093a800000000000006859472d00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006859472d000000000000682b22ad"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000002b",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    }
  }
}
```