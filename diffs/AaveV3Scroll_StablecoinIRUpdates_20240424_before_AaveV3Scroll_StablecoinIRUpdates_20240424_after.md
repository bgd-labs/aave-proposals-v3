## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2](https://scrollscan.com/address/0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2) | [0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5](https://scrollscan.com/address/0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/71713b8fe82177533a16dd37178324b412bce932.svg) | ![after](/.assets/a47328fc7b24fdcc5b0874aea1c9aa52e00b8238.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "interestRateStrategy": {
        "from": "0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2",
        "to": "0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5"
      }
    }
  },
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "address": {
        "from": "0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2",
        "to": "0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5"
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