## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x345f7fcd88207fe060AD03c2656A23A3Ab596479](https://gnosisscan.io/address/0x345f7fcd88207fe060AD03c2656A23A3Ab596479) | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/541043868751fc5ea1344f681b00906bdf734fdf.svg) | ![after](/.assets/d517c4d73c8c4c237817be708d72658850ccc974.svg) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x345f7fcd88207fe060AD03c2656A23A3Ab596479](https://gnosisscan.io/address/0x345f7fcd88207fe060AD03c2656A23A3Ab596479) | [0xE74CD4ADF9103370144c327457bd294753E2E856](https://gnosisscan.io/address/0xE74CD4ADF9103370144c327457bd294753E2E856) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/541043868751fc5ea1344f681b00906bdf734fdf.svg) | ![after](/.assets/d517c4d73c8c4c237817be708d72658850ccc974.svg) |

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
    "0xE74CD4ADF9103370144c327457bd294753E2E856": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```