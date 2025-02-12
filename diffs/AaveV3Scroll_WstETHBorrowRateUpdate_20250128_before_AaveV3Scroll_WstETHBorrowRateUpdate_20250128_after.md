## Reserve changes

### Reserves altered

#### wstETH ([0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32](https://scrollscan.com/address/0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 90 % |
| maxVariableBorrowRate | 307 % | 85.75 % |
| variableRateSlope1 | 7 % | 0.75 % |
| variableRateSlope2 | 300 % | 85 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=857500000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32": {
      "maxVariableBorrowRate": {
        "from": "3070000000000000000000000000",
        "to": "857500000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "7500000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "850000000000000000000000000"
      }
    }
  }
}
```