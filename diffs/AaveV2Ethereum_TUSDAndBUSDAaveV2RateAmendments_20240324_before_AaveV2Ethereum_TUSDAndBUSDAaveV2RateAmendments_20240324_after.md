## Reserve changes

### Reserve altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xb70e28437Aec70a8cfE5240F54c463cF849bE17C](https://etherscan.io/address/0xb70e28437Aec70a8cfE5240F54c463cF849bE17C) | [0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3](https://etherscan.io/address/0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3) |
| baseVariableBorrowRate | 100 % | 10 % |
| variableRateSlope1 | 70 % | 0 % |
| variableRateSlope2 | 300 % | 0 % |
| interestRate | ![before](/.assets/d69f0cab381b4ff866de6d1c0dc645b3afd67e08.svg) | ![after](/.assets/80791cfe2abed7f5faf97608dd1eeaed58a4c5b4.svg) |

#### BUSD ([0x4Fabb145d64652a948d72533023f6E7A623C7C53](https://etherscan.io/address/0x4Fabb145d64652a948d72533023f6E7A623C7C53))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69](https://etherscan.io/address/0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69) | [0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3](https://etherscan.io/address/0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3) |
| baseVariableBorrowRate | 100 % | 10 % |
| variableRateSlope1 | 70 % | 0 % |
| variableRateSlope2 | 300 % | 0 % |
| interestRate | ![before](/.assets/bb162a9c7a263b6483fdb55e9dd2eccec4bfaa97.svg) | ![after](/.assets/80791cfe2abed7f5faf97608dd1eeaed58a4c5b4.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "interestRateStrategy": {
        "from": "0xb70e28437Aec70a8cfE5240F54c463cF849bE17C",
        "to": "0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3"
      }
    },
    "0x4Fabb145d64652a948d72533023f6E7A623C7C53": {
      "interestRateStrategy": {
        "from": "0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69",
        "to": "0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3"
      }
    }
  },
  "strategies": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "address": {
        "from": "0xb70e28437Aec70a8cfE5240F54c463cF849bE17C",
        "to": "0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3"
      },
      "baseVariableBorrowRate": {
        "from": "1000000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "700000000000000000000000000",
        "to": 0
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": 0
      }
    },
    "0x4Fabb145d64652a948d72533023f6E7A623C7C53": {
      "address": {
        "from": "0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69",
        "to": "0x65A3De6d805c2A25A8E53e69da6A5a11848f25b3"
      },
      "baseVariableBorrowRate": {
        "from": "1000000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "700000000000000000000000000",
        "to": 0
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": 0
      }
    }
  }
}
```