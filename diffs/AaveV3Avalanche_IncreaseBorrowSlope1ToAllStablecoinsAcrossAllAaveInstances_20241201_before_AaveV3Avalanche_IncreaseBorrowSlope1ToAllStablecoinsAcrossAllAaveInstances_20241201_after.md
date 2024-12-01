## Reserve changes

### Reserve altered

#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowtrace.io/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 84.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowtrace.io/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 65.5 % | 69.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=655000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=695000000000000000000000000) |

#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 84.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 84.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "maxVariableBorrowRate": {
        "from": "655000000000000000000000000",
        "to": "695000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```