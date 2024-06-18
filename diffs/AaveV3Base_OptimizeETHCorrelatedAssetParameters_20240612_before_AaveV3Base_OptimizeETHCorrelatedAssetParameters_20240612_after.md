## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://basescan.org/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xC1F6588f4A1145D0B7F94c86a773bB47F0eC0759](https://basescan.org/address/0xC1F6588f4A1145D0B7F94c86a773bB47F0eC0759) | [0x0D9e605d77Ea2ADe3eEAfa86cE353899E9D3d72C](https://basescan.org/address/0x0D9e605d77Ea2ADe3eEAfa86cE353899E9D3d72C) |
| variableRateSlope1 | 3.8 % | 2.7 % |
| baseStableBorrowRate | 6.8 % | 5.7 % |
| interestRate | ![before](/.assets/4a9f82e7b5325d9604ebfd4eef29bb41a0ec2f45.svg) | ![after](/.assets/95e717662ee38643eaedf29c7ecf9494cf135da3.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0xC1F6588f4A1145D0B7F94c86a773bB47F0eC0759",
        "to": "0x0D9e605d77Ea2ADe3eEAfa86cE353899E9D3d72C"
      }
    }
  },
  "strategies": {
    "0x4200000000000000000000000000000000000006": {
      "address": {
        "from": "0xC1F6588f4A1145D0B7F94c86a773bB47F0eC0759",
        "to": "0x0D9e605d77Ea2ADe3eEAfa86cE353899E9D3d72C"
      },
      "baseStableBorrowRate": {
        "from": "68000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "38000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```