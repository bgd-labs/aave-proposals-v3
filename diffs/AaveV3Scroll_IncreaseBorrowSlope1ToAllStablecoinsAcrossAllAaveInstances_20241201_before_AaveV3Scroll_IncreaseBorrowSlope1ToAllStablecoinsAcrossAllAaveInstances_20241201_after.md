## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 65.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 60 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=655000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "maxVariableBorrowRate": {
        "from": "655000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "600000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  }
}
```