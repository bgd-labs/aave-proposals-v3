## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowscan.xyz/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowscan.xyz/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/5781644c11b53524a5fd5b616bf70812c97303d9.svg) | ![after](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowscan.xyz/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowscan.xyz/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/5781644c11b53524a5fd5b616bf70812c97303d9.svg) | ![after](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2](https://snowscan.xyz/address/0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2) | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/5781644c11b53524a5fd5b616bf70812c97303d9.svg) | ![after](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) |

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
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "address": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "address": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "address": {
        "from": "0x116EFD5652A9993A5984055B2da7eb9acfB48Fd2",
        "to": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    }
  }
}
```