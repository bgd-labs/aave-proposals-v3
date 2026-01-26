## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH/wstETH | rsETH/wstETH |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH | WETH, wstETH |
| eMode.collateralBitmap (unchanged) | wrsETH | wrsETH |


### EMode: rsETH/USDC(id: 6)



### EMode: weETH/WETH(id: 7)



### EMode: wstETH/WETH(id: 8)



### EMode: cbETH/WETH(id: 9)



### EMode: cbBTC Stablecoins(id: 10)



## Raw diff

```json
{
  "eModes": {
    "5": {
      "borrowableBitmap": {
        "from": "8",
        "to": "9"
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x0913d404e020f0557f3aea1dc8fd0190ea3453f59952e2c41e4746bdfcd39c78": {
          "previousValue": "0x00693bdf58000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693bdf58000000000003000000000000000000000000000000000000000000"
        },
        "0x0913d404e020f0557f3aea1dc8fd0190ea3453f59952e2c41e4746bdfcd39c79": {
          "previousValue": "0x000000000000000000093a80000000000000696a03d900000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000696a03d9000000000000693bdf59"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x00000000000000000000000000000000000000000000000002002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000000000002002774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000008",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000009"
        }
      }
    }
  }
}
```