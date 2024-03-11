## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E](https://polygonscan.com/address/0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E) | [0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7](https://polygonscan.com/address/0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/b0ed4aca5ea297679807c0e2dea664093c28af3d.svg) | ![after](/.assets/9fdcab76edd6660f763ee400838c013faa920e39.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x283Df7893eF10F729890017F57d76B8D78e18915](https://polygonscan.com/address/0x283Df7893eF10F729890017F57d76B8D78e18915) | [0xa966adA364E0491520a1235aAA9cf15E08c1Db05](https://polygonscan.com/address/0xa966adA364E0491520a1235aAA9cf15E08c1Db05) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/b393c4daa90e91fe2d2d328a1363acfcbe27b915.svg) | ![after](/.assets/b8393c809f8dfba89d4623793fa1650416ce5b8b.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39](https://polygonscan.com/address/0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39) | [0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447](https://polygonscan.com/address/0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447) |
| variableRateSlope1 | 5 % | 6 % |
| interestRate | ![before](/.assets/e5f4849f0e23cb31e923fa4ba60d4c3638979c16.svg) | ![after](/.assets/7b1a62c7a431a1f0b3ef48d0c3eb32be510352d0.svg) |

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
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "address": {
        "from": "0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E",
        "to": "0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "address": {
        "from": "0x283Df7893eF10F729890017F57d76B8D78e18915",
        "to": "0xa966adA364E0491520a1235aAA9cf15E08c1Db05"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "address": {
        "from": "0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39",
        "to": "0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    }
  }
}
```