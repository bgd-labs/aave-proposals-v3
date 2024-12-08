## Reserve changes

### Reserve altered

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 84 % | 53.5 % |
| variableRateSlope1 | 9 % | 13.5 % |
| variableRateSlope2 | 75 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=840000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=135000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=535000000000000000000000000) |

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 75 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 62.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 75 % | 50 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=625000000000000000000000000) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 75 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "maxVariableBorrowRate": {
        "from": "840000000000000000000000000",
        "to": "535000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "135000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "625000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "500000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  }
}
```