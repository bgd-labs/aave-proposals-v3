## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9205B37978aC983A297dFB53b3f3D2cCC7DDDADa](https://scrollscan.com/address/0x9205B37978aC983A297dFB53b3f3D2cCC7DDDADa) | [0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2](https://scrollscan.com/address/0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 7 % | 13 % |
| interestRate | ![before](/.assets/3dae2b4f6923d155de327323b76840893e8fe017.svg) | ![after](/.assets/71713b8fe82177533a16dd37178324b412bce932.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "interestRateStrategy": {
        "from": "0x9205B37978aC983A297dFB53b3f3D2cCC7DDDADa",
        "to": "0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2"
      }
    }
  },
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "address": {
        "from": "0x9205B37978aC983A297dFB53b3f3D2cCC7DDDADa",
        "to": "0x39FA62444F4716f64253aEAc4509Ad32DE8D67B2"
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