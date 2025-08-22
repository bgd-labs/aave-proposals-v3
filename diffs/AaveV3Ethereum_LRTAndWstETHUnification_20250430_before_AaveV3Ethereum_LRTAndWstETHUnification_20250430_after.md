## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH LST main | rsETH LST main |
| eMode.ltv | 92.5 % | 93 % |
| eMode.liquidationThreshold | 94.5 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH, ETHx | wstETH, ETHx |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: PT-sUSDe Stablecoins Jul 2025(id: 8)



### EMode: PT-eUSDe Stablecoins May 2025(id: 9)



## Raw diff

```json
{
  "eModes": {
    "3": {
      "liquidationThreshold": {
        "from": 9450,
        "to": 9500
      },
      "ltv": {
        "from": 9250,
        "to": 9300
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x0000000000000000000000000000000000000000001000000000277424ea2422",
          "newValue": "0x00000000000000000000000000000000000000000010000000002774251c2454"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c",
          "newValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x64c02d3179204055dad2cccfeeb0b65da6899a4e845aea52a7a0af7337c9130f": {
          "previousValue": "0x00681e138e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00681e138e000000000003000000000000000000000000000000000000000000"
        },
        "0x64c02d3179204055dad2cccfeeb0b65da6899a4e845aea52a7a0af7337c91310": {
          "previousValue": "0x000000000000000000093a80000000000000684c380f00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000684c380f000000000000681e138f"
        }
      }
    }
  }
}
```