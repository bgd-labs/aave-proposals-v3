## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 80 % | 90 % |
| maxVariableBorrowRate | 87.25 % | 86.75 % |
| variableRateSlope1 | 2.25 % | 1.75 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=22500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=872500000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=17500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=867500000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "maxVariableBorrowRate": {
        "from": "872500000000000000000000000",
        "to": "867500000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "800000000000000000000000000",
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "22500000000000000000000000",
        "to": "17500000000000000000000000"
      }
    }
  }
}
```