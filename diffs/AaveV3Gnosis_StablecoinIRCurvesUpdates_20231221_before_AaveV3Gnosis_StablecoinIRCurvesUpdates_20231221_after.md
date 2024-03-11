## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x345f7fcd88207fe060AD03c2656A23A3Ab596479](https://gnosisscan.io/address/0x345f7fcd88207fe060AD03c2656A23A3Ab596479) | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/92fbd418c607b9cb56062699ddd084e46f70649a.svg) | ![after](/.assets/f4b1b8f3a89d9f171e1de97ae32be0c4decc7291.svg) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x345f7fcd88207fe060AD03c2656A23A3Ab596479](https://gnosisscan.io/address/0x345f7fcd88207fe060AD03c2656A23A3Ab596479) | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/92fbd418c607b9cb56062699ddd084e46f70649a.svg) | ![after](/.assets/f4b1b8f3a89d9f171e1de97ae32be0c4decc7291.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "interestRateStrategy": {
        "from": "0x345f7fcd88207fe060AD03c2656A23A3Ab596479",
        "to": "0xE74CD4ADF9103370144c327457bd294753E2E856"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "interestRateStrategy": {
        "from": "0x345f7fcd88207fe060AD03c2656A23A3Ab596479",
        "to": "0xE74CD4ADF9103370144c327457bd294753E2E856"
      }
    }
  },
  "strategies": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "address": {
        "from": "0x345f7fcd88207fe060AD03c2656A23A3Ab596479",
        "to": "0xE74CD4ADF9103370144c327457bd294753E2E856"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "address": {
        "from": "0x345f7fcd88207fe060AD03c2656A23A3Ab596479",
        "to": "0xE74CD4ADF9103370144c327457bd294753E2E856"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    }
  }
}
```