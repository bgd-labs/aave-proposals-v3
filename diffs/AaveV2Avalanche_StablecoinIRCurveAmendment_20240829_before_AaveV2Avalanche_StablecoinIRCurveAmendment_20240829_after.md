## Reserve changes

### Reserve altered

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowtrace.io/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 9 % | 5.5 % |
| interestRate | ![before](/.assets/98c2411f2477e6bdf780a851943fb60548498e8f.svg) | ![after](/.assets/a7e1d9cbd28e5095f34b408a31e31e36a127ecea.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowtrace.io/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 9 % | 5.5 % |
| interestRate | ![before](/.assets/98c2411f2477e6bdf780a851943fb60548498e8f.svg) | ![after](/.assets/a7e1d9cbd28e5095f34b408a31e31e36a127ecea.svg) |

## Raw diff

```json
{
  "reserves": {
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
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "address": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "address": {
        "from": "0xd814D29bBd27b97d58255632C498c34b25DC72bD",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    }
  }
}
```