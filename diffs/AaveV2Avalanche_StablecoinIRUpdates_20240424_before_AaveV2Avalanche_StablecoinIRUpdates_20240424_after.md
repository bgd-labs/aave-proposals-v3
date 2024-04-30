## Reserve changes

### Reserve altered

#### USDC.e ([0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowscan.xyz/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4](https://snowscan.xyz/address/0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4) | [0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716](https://snowscan.xyz/address/0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716) |
| variableRateSlope1 | 13 % | 10 % |
| interestRate | ![before](/.assets/ebccca66b9c426e3cc1dbbc7f4951b3043ab0eb0.svg) | ![after](/.assets/2633c80d8197b26e77ccf20e99ba7d7d77c645d7.svg) |

#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowscan.xyz/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7](https://snowscan.xyz/address/0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7) | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowscan.xyz/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/28fac0d10e4291c98082d817d0b0f896a2cf8f2b.svg) | ![after](/.assets/cefc020957a48e5032cf475e71d8fc065adbfc61.svg) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7](https://snowscan.xyz/address/0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7) | [0xd814D29bBd27b97d58255632C498c34b25DC72bD](https://snowscan.xyz/address/0xd814D29bBd27b97d58255632C498c34b25DC72bD) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/28fac0d10e4291c98082d817d0b0f896a2cf8f2b.svg) | ![after](/.assets/cefc020957a48e5032cf475e71d8fc065adbfc61.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "interestRateStrategy": {
        "from": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4",
        "to": "0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "interestRateStrategy": {
        "from": "0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7",
        "to": "0xd814D29bBd27b97d58255632C498c34b25DC72bD"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "interestRateStrategy": {
        "from": "0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7",
        "to": "0xd814D29bBd27b97d58255632C498c34b25DC72bD"
      }
    }
  },
  "strategies": {
    "0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664": {
      "address": {
        "from": "0xb1f13B58D6a3B1aEdB211Db58D9e42d28D09DbF4",
        "to": "0x6b410D0d53Efc7d4cAF23b9df2F38558998A1716"
      },
      "variableRateSlope1": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "address": {
        "from": "0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7",
        "to": "0xd814D29bBd27b97d58255632C498c34b25DC72bD"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "address": {
        "from": "0x7e7B8d96C08881c3e1F506E3a81baE759aeFacA7",
        "to": "0xd814D29bBd27b97d58255632C498c34b25DC72bD"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    }
  }
}
```