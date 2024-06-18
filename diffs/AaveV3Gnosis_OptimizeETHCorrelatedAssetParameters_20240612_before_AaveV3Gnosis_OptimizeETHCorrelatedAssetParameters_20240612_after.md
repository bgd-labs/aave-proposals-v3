## Reserve changes

### Reserves altered

#### WETH ([0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1](https://gnosisscan.io/address/0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xD84d86083010FB683f1e8fA3809ee8DC90A4C4DB](https://gnosisscan.io/address/0xD84d86083010FB683f1e8fA3809ee8DC90A4C4DB) | [0xD3120200c339f608C394CCF9cBAD4bABab63B5dD](https://gnosisscan.io/address/0xD3120200c339f608C394CCF9cBAD4bABab63B5dD) |
| variableRateSlope1 | 3.3 % | 2.7 % |
| baseStableBorrowRate | 5.3 % | 4.7 % |
| interestRate | ![before](/.assets/1a2d00464fd0707711f315bbce0579c505aef532.svg) | ![after](/.assets/df5063c94fec0289ac8349d5c84e5a33a4a6ccf6.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1": {
      "interestRateStrategy": {
        "from": "0xD84d86083010FB683f1e8fA3809ee8DC90A4C4DB",
        "to": "0xD3120200c339f608C394CCF9cBAD4bABab63B5dD"
      }
    }
  },
  "strategies": {
    "0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1": {
      "address": {
        "from": "0xD84d86083010FB683f1e8fA3809ee8DC90A4C4DB",
        "to": "0xD3120200c339f608C394CCF9cBAD4bABab63B5dD"
      },
      "baseStableBorrowRate": {
        "from": "53000000000000000000000000",
        "to": "47000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "33000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```