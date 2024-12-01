## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 65.5 % | 69.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=655000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=695000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "maxVariableBorrowRate": {
        "from": "655000000000000000000000000",
        "to": "695000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```