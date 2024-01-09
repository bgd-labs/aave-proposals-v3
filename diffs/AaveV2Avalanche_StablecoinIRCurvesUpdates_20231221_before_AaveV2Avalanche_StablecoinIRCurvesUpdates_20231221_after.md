## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowtrace.io/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowtrace.io/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) | ![after](/.assets/0840a59c8c432cbe6f37694bbe31a2d331363c7b.svg) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowtrace.io/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) | ![after](/.assets/0840a59c8c432cbe6f37694bbe31a2d331363c7b.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowtrace.io/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowtrace.io/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/62f021f36d53e9ea17053e69d91919a485630b05.svg) | ![after](/.assets/0840a59c8c432cbe6f37694bbe31a2d331363c7b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "interestRateStrategy": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "interestRateStrategy": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "interestRateStrategy": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      }
    }
  },
  "strategies": {
    "0xa7C0f85c626761eDD0875549aD09E8d3f5446695": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```