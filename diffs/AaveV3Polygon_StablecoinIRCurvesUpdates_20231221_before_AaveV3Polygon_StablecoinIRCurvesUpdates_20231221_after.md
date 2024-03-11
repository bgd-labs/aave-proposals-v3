## Reserve changes

### Reserve altered

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://polygonscan.com/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://polygonscan.com/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/5c916bd4a4f8cdafb497248e4b80704e95d2c2f5.svg) | ![after](/.assets/72490a8918cee95a56717e7d3753cce611ac1805.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://polygonscan.com/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://polygonscan.com/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/9e095249e48bd804aaedf478236657a01de602ab.svg) | ![after](/.assets/9b7be685a38f661247e12c171aa7c6e605f7a547.svg) |

#### miMATIC ([0xa3Fa99A148fA48D14Ed51d610c367C61876997F1](https://polygonscan.com/address/0xa3Fa99A148fA48D14Ed51d610c367C61876997F1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://polygonscan.com/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) | [0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4](https://polygonscan.com/address/0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/4e7bbf631220ce3b40f53423477c6be3a8b8dfd2.svg) | ![after](/.assets/c0ca34be405c22dc36ffd20c54b1dc8cf5ac741b.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://polygonscan.com/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://polygonscan.com/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/9e095249e48bd804aaedf478236657a01de602ab.svg) | ![after](/.assets/9b7be685a38f661247e12c171aa7c6e605f7a547.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "interestRateStrategy": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
      }
    },
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "interestRateStrategy": {
        "from": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276",
        "to": "0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
      }
    }
  },
  "strategies": {
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "address": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      },
      "baseStableBorrowRate": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "address": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
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
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "address": {
        "from": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276",
        "to": "0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4"
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
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "address": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
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