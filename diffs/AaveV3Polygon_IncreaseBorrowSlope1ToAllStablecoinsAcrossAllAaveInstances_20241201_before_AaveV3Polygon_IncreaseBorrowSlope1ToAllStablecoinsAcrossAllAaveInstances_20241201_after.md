## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 90 % | 53.5 % |
| variableRateSlope1 | 10 % | 13.5 % |
| variableRateSlope2 | 80 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=900000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=135000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=535000000000000000000000000) |

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 65.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 60 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=655000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 75 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 62.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 75 % | 50 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=625000000000000000000000000) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

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
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "maxVariableBorrowRate": {
        "from": "900000000000000000000000000",
        "to": "535000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "100000000000000000000000000",
        "to": "135000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "800000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "maxVariableBorrowRate": {
        "from": "655000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "600000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
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
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
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
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
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