## Reserve changes

### Reserve altered

#### USDC ([0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4](https://era.zksync.network//address/0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDT ([0x493257fD37EDB34451f62EDf8D2a0C418852bA4C](https://era.zksync.network//address/0x493257fD37EDB34451f62EDf8D2a0C418852bA4C))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0x493257fD37EDB34451f62EDf8D2a0C418852bA4C": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {}
  }
}
```