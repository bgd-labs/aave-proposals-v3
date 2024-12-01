## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowtrace.io/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716](https://snowtrace.io/address/0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 10 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowtrace.io/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 9 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowtrace.io/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 9 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

## Raw diff

```json
{
  "reserves": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "interestRateStrategy": {
        "from": "0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "interestRateStrategy": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "interestRateStrategy": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      }
    }
  },
  "strategies": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "address": {
        "from": "0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "100000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "address": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "address": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```