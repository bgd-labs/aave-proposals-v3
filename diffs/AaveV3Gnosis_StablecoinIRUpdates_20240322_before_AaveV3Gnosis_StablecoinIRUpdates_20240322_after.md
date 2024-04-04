## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) | [0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e](https://gnosisscan.io/address/0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 7 % | 13 % |
| interestRate | ![before](/.assets/f4b1b8f3a89d9f171e1de97ae32be0c4decc7291.svg) | ![after](/.assets/63d85ef2aae018346bf4ae5d47f0f379ee834a81.svg) |

#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x6c3b7e7B8b9609D57C70C3F630228F979EAbb450](https://gnosisscan.io/address/0x6c3b7e7B8b9609D57C70C3F630228F979EAbb450) | [0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3](https://gnosisscan.io/address/0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3) |
| variableRateSlope1 | 4 % | 12 % |
| baseStableBorrowRate | 5 % | 13 % |
| interestRate | ![before](/.assets/79d2d01632de8f7a1295d120d64fe0b8930a59f2.svg) | ![after](/.assets/f2f95a4b4513a29b7ce19c748925854dd8f0c741.svg) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) | [0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e](https://gnosisscan.io/address/0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 7 % | 13 % |
| interestRate | ![before](/.assets/f4b1b8f3a89d9f171e1de97ae32be0c4decc7291.svg) | ![after](/.assets/63d85ef2aae018346bf4ae5d47f0f379ee834a81.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "interestRateStrategy": {
        "from": "0xE74CD4ADF9103370144c327457bd294753E2E856",
        "to": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "interestRateStrategy": {
        "from": "0x6c3b7e7B8b9609D57C70C3F630228F979EAbb450",
        "to": "0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "interestRateStrategy": {
        "from": "0xE74CD4ADF9103370144c327457bd294753E2E856",
        "to": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e"
      }
    }
  },
  "strategies": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "address": {
        "from": "0xE74CD4ADF9103370144c327457bd294753E2E856",
        "to": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e"
      },
      "baseStableBorrowRate": {
        "from": "70000000000000000000000000",
        "to": "130000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "address": {
        "from": "0x6c3b7e7B8b9609D57C70C3F630228F979EAbb450",
        "to": "0x5c5eC8bf67a83d9d703DCB755B1e8D1e72Fa89E3"
      },
      "baseStableBorrowRate": {
        "from": "50000000000000000000000000",
        "to": "130000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "40000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "address": {
        "from": "0xE74CD4ADF9103370144c327457bd294753E2E856",
        "to": "0xBAbaB9202855F1c3FC943F0d032eAb4847A92D7e"
      },
      "baseStableBorrowRate": {
        "from": "70000000000000000000000000",
        "to": "130000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    }
  }
}
```