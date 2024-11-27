## Reserve changes

### Reserves altered

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 82 % | 85 % |
| baseVariableBorrowRate | 6.25 % | 9.25 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=62500000000000000000000000&maxVariableBorrowRate=820000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=92500000000000000000000000&maxVariableBorrowRate=850000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "baseVariableBorrowRate": {
        "from": "62500000000000000000000000",
        "to": "92500000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "820000000000000000000000000",
        "to": "850000000000000000000000000"
      }
    }
  }
}
```