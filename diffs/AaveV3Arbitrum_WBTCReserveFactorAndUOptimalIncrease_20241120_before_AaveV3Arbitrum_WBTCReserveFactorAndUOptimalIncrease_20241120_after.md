## Reserve changes

### Reserves altered

#### WBTC ([0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f](https://arbiscan.io/address/0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| optimalUsageRatio | 45 % | 80 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |

## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



## Raw diff

```json
{
  "reserves": {
    "0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f": {
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      }
    }
  }
}
```