## Reserve changes

### Reserves altered

#### wstETH ([0x5979D7b546E38E414F7E9822514be443A4800529](https://arbiscan.io/address/0x5979D7b546E38E414F7E9822514be443A4800529))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 90 % |
| maxVariableBorrowRate | 84.75 % | 85.75 % |
| baseVariableBorrowRate | 0.25 % | 0 % |
| variableRateSlope1 | 4.5 % | 0.75 % |
| variableRateSlope2 | 80 % | 85 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=45000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=2500000000000000000000000&maxVariableBorrowRate=847500000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=857500000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x5979D7b546E38E414F7E9822514be443A4800529": {
      "baseVariableBorrowRate": {
        "from": "2500000000000000000000000",
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": "847500000000000000000000000",
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