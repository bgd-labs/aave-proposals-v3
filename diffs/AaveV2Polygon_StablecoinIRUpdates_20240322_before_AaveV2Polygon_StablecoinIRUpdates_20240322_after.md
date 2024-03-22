## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7](https://polygonscan.com/address/0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7) | [0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76](https://polygonscan.com/address/0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76) |
| optimalUsageRatio | 77 % | 92 % |
| variableRateSlope1 | 6 % | 12 % |
| maxExcessUsageRatio | 23 % | 8 % |
| interestRate | ![before](/.assets/9fdcab76edd6660f763ee400838c013faa920e39.svg) | ![after](/.assets/b262ffb8e1738773ae155739d430077a79451a55.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xa966adA364E0491520a1235aAA9cf15E08c1Db05](https://polygonscan.com/address/0xa966adA364E0491520a1235aAA9cf15E08c1Db05) | [0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966](https://polygonscan.com/address/0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966) |
| optimalUsageRatio | 71 % | 92 % |
| variableRateSlope1 | 6 % | 12 % |
| maxExcessUsageRatio | 29 % | 8 % |
| interestRate | ![before](/.assets/b8393c809f8dfba89d4623793fa1650416ce5b8b.svg) | ![after](/.assets/2b34895d95baff287d2b0c64761d38faae833777.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447](https://polygonscan.com/address/0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447) | [0x1233847129541c166ad585FaC0727CcBF6cf28eC](https://polygonscan.com/address/0x1233847129541c166ad585FaC0727CcBF6cf28eC) |
| optimalUsageRatio | 52 % | 92 % |
| variableRateSlope1 | 6 % | 12 % |
| maxExcessUsageRatio | 48 % | 8 % |
| interestRate | ![before](/.assets/7b1a62c7a431a1f0b3ef48d0c3eb32be510352d0.svg) | ![after](/.assets/7298d269e8a08139605b2434246d84d4bb597ec1.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7",
        "to": "0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xa966adA364E0491520a1235aAA9cf15E08c1Db05",
        "to": "0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447",
        "to": "0x1233847129541c166ad585FaC0727CcBF6cf28eC"
      }
    }
  },
  "strategies": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "address": {
        "from": "0x2ad5a608a920E7061ccE38955C89A7c3F4c0aba7",
        "to": "0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76"
      },
      "maxExcessUsageRatio": {
        "from": "230000000000000000000000000",
        "to": "80000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "770000000000000000000000000",
        "to": "920000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "address": {
        "from": "0xa966adA364E0491520a1235aAA9cf15E08c1Db05",
        "to": "0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966"
      },
      "maxExcessUsageRatio": {
        "from": "290000000000000000000000000",
        "to": "80000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "710000000000000000000000000",
        "to": "920000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "address": {
        "from": "0x7892E4Db4C172e7Af389677c04c42eE3F8Fd5447",
        "to": "0x1233847129541c166ad585FaC0727CcBF6cf28eC"
      },
      "maxExcessUsageRatio": {
        "from": "480000000000000000000000000",
        "to": "80000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "520000000000000000000000000",
        "to": "920000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    }
  }
}
```