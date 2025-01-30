## Reserve changes

### Reserves altered

#### wstETH ([0x703b52F2b28fEbcB60E1372858AF5b18849FE867](https://era.zksync.network//address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 90 % |
| maxVariableBorrowRate | 84.5 % | 85.75 % |
| variableRateSlope1 | 4.5 % | 0.75 % |
| variableRateSlope2 | 80 % | 85 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=45000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=857500000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x703b52F2b28fEbcB60E1372858AF5b18849FE867": {
      "maxVariableBorrowRate": {
        "from": "845000000000000000000000000",
        "to": "857500000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "45000000000000000000000000",
        "to": "7500000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "800000000000000000000000000",
        "to": "850000000000000000000000000"
      }
    }
  }
}
```