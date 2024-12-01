## Reserve changes

### Reserve altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 65.5 % | 69.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=655000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=695000000000000000000000000) |

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 82 % | 85.25 % |
| variableRateSlope1 | 6.25 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=62500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=820000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=852500000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "maxVariableBorrowRate": {
        "from": "655000000000000000000000000",
        "to": "695000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "maxVariableBorrowRate": {
        "from": "820000000000000000000000000",
        "to": "852500000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "62500000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```