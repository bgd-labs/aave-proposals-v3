## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 63 % | 61 % |
| baseVariableBorrowRate | 10.5 % | 8.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=105000000000000000000000000&maxVariableBorrowRate=630000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=85000000000000000000000000&maxVariableBorrowRate=610000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "baseVariableBorrowRate": {
        "from": "105000000000000000000000000",
        "to": "85000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "630000000000000000000000000",
        "to": "610000000000000000000000000"
      }
    }
  }
}
```