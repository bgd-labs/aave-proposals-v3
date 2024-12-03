## Reserve changes

### Reserves altered

#### WBTC ([0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| optimalUsageRatio | 45 % | 80 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |

## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: MATIC correlated(id: 2)



### EMode: ETH correlated(id: 3)



## Raw diff

```json
{
  "reserves": {
    "0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6": {
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      }
    }
  }
}
```