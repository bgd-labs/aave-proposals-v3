## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5](https://scrollscan.com/address/0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5) | [0x24aB4C31eE3c1F5D86407Aa39a44a5b123b9449A](https://scrollscan.com/address/0x24aB4C31eE3c1F5D86407Aa39a44a5b123b9449A) |
| variableRateSlope1 | 9 % | 6.5 % |
| baseStableBorrowRate | 10 % | 7.5 % |
| interestRate | ![before](/.assets/a47328fc7b24fdcc5b0874aea1c9aa52e00b8238.svg) | ![after](/.assets/65f9bb7cca668e1c36936d2b2aba82142c6bfad8.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "interestRateStrategy": {
        "from": "0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5",
        "to": "0x24aB4C31eE3c1F5D86407Aa39a44a5b123b9449A"
      }
    }
  },
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "address": {
        "from": "0x80E14993fE2cA5c64328B4a8DfC1D95960338bd5",
        "to": "0x24aB4C31eE3c1F5D86407Aa39a44a5b123b9449A"
      },
      "baseStableBorrowRate": {
        "from": "100000000000000000000000000",
        "to": "75000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  }
}
```