## Reserve changes

### Reserves altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 85.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 80 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=855000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "maxVariableBorrowRate": {
        "from": "855000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "800000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  }
}
```