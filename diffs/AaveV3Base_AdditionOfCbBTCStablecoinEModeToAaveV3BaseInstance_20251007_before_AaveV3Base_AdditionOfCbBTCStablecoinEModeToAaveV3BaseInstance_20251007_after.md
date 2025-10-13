## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)



### EMode: rsETH/USDC(id: 6)



### EMode: weETH/WETH(id: 7)



### EMode: wstETH/WETH(id: 8)



### EMode: cbETH/WETH(id: 9)



### EMode: cbBTC Stablecoins(id: 10)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | cbBTC Stablecoins |
| eMode.ltv | - | 80 % |
| eMode.liquidationThreshold | - | 83 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | cbBTC |


## Raw diff

```json
{
  "eModes": {
    "10": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "64",
        "eModeCategory": 10,
        "label": "cbBTC Stablecoins",
        "liquidationBonus": 10400,
        "liquidationThreshold": 8300,
        "ltv": 8000
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xca1941ffd2876354dca11a76468fb85895321380bff6312dcbd61b110f22031e": {
          "previousValue": "0x0068e55790000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068e55790000000000003000000000000000000000000000000000000000000"
        },
        "0xca1941ffd2876354dca11a76468fb85895321380bff6312dcbd61b110f22031f": {
          "previousValue": "0x000000000000000000093a8000000000000069137c1100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069137c1100000000000068e55791"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000004028a0206c1f40"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x636242544320537461626c65636f696e73000000000000000000000000000022"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        }
      }
    }
  }
}
```