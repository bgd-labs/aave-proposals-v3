## Reserve changes

### Reserves altered

#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xf6733B9842883BFE0e0a940eA2F572676af31bde](https://polygonscan.com/address/0xf6733B9842883BFE0e0a940eA2F572676af31bde) | [0x48AF11111764E710fcDcE2750db848C63edab57B](https://polygonscan.com/address/0x48AF11111764E710fcDcE2750db848C63edab57B) |
| variableRateSlope1 | 3.3 % | 2.7 % |
| baseStableBorrowRate | 6.3 % | 5.7 % |
| interestRate | ![before](/.assets/bc821e780dbf0cd88aa89ae21f339014e1053ceb.svg) | ![after](/.assets/7fa4b4b2fd917d2cc659935ebf8fc577c2489a8e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "interestRateStrategy": {
        "from": "0xf6733B9842883BFE0e0a940eA2F572676af31bde",
        "to": "0x48AF11111764E710fcDcE2750db848C63edab57B"
      }
    }
  },
  "strategies": {
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "address": {
        "from": "0xf6733B9842883BFE0e0a940eA2F572676af31bde",
        "to": "0x48AF11111764E710fcDcE2750db848C63edab57B"
      },
      "baseStableBorrowRate": {
        "from": "63000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "33000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```