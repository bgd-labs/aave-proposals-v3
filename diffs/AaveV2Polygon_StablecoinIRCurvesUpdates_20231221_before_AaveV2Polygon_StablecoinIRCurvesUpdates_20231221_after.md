## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E](https://polygonscan.com/address/0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E) | [0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7](https://polygonscan.com/address/0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/d0ce1d7b0f30792388a361ffa100ec476087d905.svg) | ![after](/.assets/7eddb42a5587c5b4d0022e8e5b3ef6a6d19fccab.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x283Df7893eF10F729890017F57d76B8D78e18915](https://polygonscan.com/address/0x283Df7893eF10F729890017F57d76B8D78e18915) | [0xa966adA364E0491520a1235aAA9cf15E08c1Db05](https://polygonscan.com/address/0xa966adA364E0491520a1235aAA9cf15E08c1Db05) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/e4bd0b47b6f0a753cd3286f1a05fa61c8781f53c.svg) | ![after](/.assets/fce467d9fda400691f6d21c94c08036d955dcf85.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39](https://polygonscan.com/address/0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39) | [0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447](https://polygonscan.com/address/0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/fed28c8fca229c5bb66e0ae2b4ce72db46b36da2.svg) | ![after](/.assets/6cb44a769e468e84b3d7c4e737a6f0e449d82146.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E",
        "to": "0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0x283Df7893eF10F729890017F57d76B8D78e18915",
        "to": "0xa966adA364E0491520a1235aAA9cf15E08c1Db05"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39",
        "to": "0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447"
      }
    }
  },
  "strategies": {
    "0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "230000000000000000000000000",
        "optimalUsageRatio": "770000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1340000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "1340000000000000000000000000"
      }
    },
    "0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "480000000000000000000000000",
        "optimalUsageRatio": "520000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "2360000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "2360000000000000000000000000"
      }
    },
    "0xa966adA364E0491520a1235aAA9cf15E08c1Db05": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "290000000000000000000000000",
        "optimalUsageRatio": "710000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1050000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "1050000000000000000000000000"
      }
    }
  }
}
```