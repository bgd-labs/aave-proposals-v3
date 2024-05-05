## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e](https://gnosisscan.io/address/0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e) | [0x7b846F0bE2A2c3434b353130B312Dd978514D04d](https://gnosisscan.io/address/0x7b846F0bE2A2c3434b353130B312Dd978514D04d) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/63d85ef2aae018346bf4ae5d47f0f379ee834a81.svg) | ![after](/.assets/9c6c2ac04f36e8884c02f7bd8e4fedeff98c9211.svg) |

#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3](https://gnosisscan.io/address/0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3) | [0x83506d1B6DC58390Ca52baF0314779c2525BB814](https://gnosisscan.io/address/0x83506d1B6DC58390Ca52baF0314779c2525BB814) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/f2f95a4b4513a29b7ce19c748925854dd8f0c741.svg) | ![after](/.assets/54011ffd1c8f70f6c81bff9e84e73b6caf224f66.svg) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e](https://gnosisscan.io/address/0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e) | [0x7b846F0bE2A2c3434b353130B312Dd978514D04d](https://gnosisscan.io/address/0x7b846F0bE2A2c3434b353130B312Dd978514D04d) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/63d85ef2aae018346bf4ae5d47f0f379ee834a81.svg) | ![after](/.assets/9c6c2ac04f36e8884c02f7bd8e4fedeff98c9211.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "interestRateStrategy": {
        "from": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e",
        "to": "0x7b846F0bE2A2c3434b353130B312Dd978514D04d"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "interestRateStrategy": {
        "from": "0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3",
        "to": "0x83506d1B6DC58390Ca52baF0314779c2525BB814"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "interestRateStrategy": {
        "from": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e",
        "to": "0x7b846F0bE2A2c3434b353130B312Dd978514D04d"
      }
    }
  },
  "strategies": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "address": {
        "from": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e",
        "to": "0x7b846F0bE2A2c3434b353130B312Dd978514D04d"
      },
      "baseStableBorrowRate": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "address": {
        "from": "0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3",
        "to": "0x83506d1B6DC58390Ca52baF0314779c2525BB814"
      },
      "baseStableBorrowRate": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "address": {
        "from": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e",
        "to": "0x7b846F0bE2A2c3434b353130B312Dd978514D04d"
      },
      "baseStableBorrowRate": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    }
  }
}
```