## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowtrace.io/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xD96B68638bdbb625A49F5BAC0dC3B66764569d30](https://snowtrace.io/address/0xD96B68638bdbb625A49F5BAC0dC3B66764569d30) | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/c415a8c57745a62d63e11134fe8acf5059377542.svg) | ![after](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xD96B68638bdbb625A49F5BAC0dC3B66764569d30](https://snowtrace.io/address/0xD96B68638bdbb625A49F5BAC0dC3B66764569d30) | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/c415a8c57745a62d63e11134fe8acf5059377542.svg) | ![after](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xD96B68638bdbb625A49F5BAC0dC3B66764569d30](https://snowtrace.io/address/0xD96B68638bdbb625A49F5BAC0dC3B66764569d30) | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/c415a8c57745a62d63e11134fe8acf5059377542.svg) | ![after](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "interestRateStrategy": {
        "from": "0xD96B68638bdbb625A49F5BAC0dC3B66764569d30",
        "to": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "interestRateStrategy": {
        "from": "0xD96B68638bdbb625A49F5BAC0dC3B66764569d30",
        "to": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "interestRateStrategy": {
        "from": "0xD96B68638bdbb625A49F5BAC0dC3B66764569d30",
        "to": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2"
      }
    }
  },
  "strategies": {
    "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```