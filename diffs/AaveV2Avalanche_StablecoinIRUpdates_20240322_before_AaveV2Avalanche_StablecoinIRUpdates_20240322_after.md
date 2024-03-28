## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowscan.xyz/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) | [0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4](https://snowscan.xyz/address/0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4) |
| variableRateSlope1 | 6 % | 12 % |
| interestRate | ![before](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) | ![after](/.assets/857e4e2fbb6d6dc9100be9ba3b6b134c59ad974b.svg) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowscan.xyz/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) | [0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4](https://snowscan.xyz/address/0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4) |
| variableRateSlope1 | 6 % | 12 % |
| interestRate | ![before](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) | ![after](/.assets/857e4e2fbb6d6dc9100be9ba3b6b134c59ad974b.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xa7C0f85c626761eDD0875549aD09E8d3f5446695](https://snowscan.xyz/address/0xa7C0f85c626761eDD0875549aD09E8d3f5446695) | [0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4](https://snowscan.xyz/address/0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4) |
| variableRateSlope1 | 6 % | 12 % |
| interestRate | ![before](/.assets/ae7612ca9dd768ff3aee2f745910dc0a19e5fa71.svg) | ![after](/.assets/857e4e2fbb6d6dc9100be9ba3b6b134c59ad974b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "interestRateStrategy": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "interestRateStrategy": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "interestRateStrategy": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      }
    }
  },
  "strategies": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "address": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "address": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "address": {
        "from": "0xa7C0f85c626761eDD0875549aD09E8d3f5446695",
        "to": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    }
  }
}
```