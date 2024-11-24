## Reserve changes

### Reserves altered

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 87.5 % | 82 % |
| variableRateSlope1 | 6.25 % | 0.75 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=62500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=62500000000000000000000000&maxVariableBorrowRate=875000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=62500000000000000000000000&maxVariableBorrowRate=820000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "maxVariableBorrowRate": {
        "from": "875000000000000000000000000",
        "to": "820000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "62500000000000000000000000",
        "to": "7500000000000000000000000"
      }
    }
  }
}
```