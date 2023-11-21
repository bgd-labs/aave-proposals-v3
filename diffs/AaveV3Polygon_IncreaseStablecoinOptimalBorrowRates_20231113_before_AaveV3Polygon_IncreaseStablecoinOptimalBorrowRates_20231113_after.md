## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xC82dF96432346cFb632473eB619Db3B8AC280234](https://polygonscan.com/address/0xC82dF96432346cFb632473eB619Db3B8AC280234) | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://polygonscan.com/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) |
| variableRateSlope1 | 3.5 % | 5 % |
| baseStableBorrowRate | 4.5 % | 6 % |
| interestRate | ![before](/.assets/0372907d0b2f3da48f7adcaed3b1452230cd5c2b.svg) | ![after](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA9F3C3caE095527061e6d270DBE163693e6fda9D](https://polygonscan.com/address/0xA9F3C3caE095527061e6d270DBE163693e6fda9D) | [0xD87974E8ED49AB16d5053ba793F4e17078Be0426](https://polygonscan.com/address/0xD87974E8ED49AB16d5053ba793F4e17078Be0426) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| variableRateSlope1 | 4 % | 5 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/8d9de32bf30b1c9dcf71f07a13b228c69a71a4ce.svg) | ![after](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) |

#### miMATIC ([0xa3Fa99A148fA48D14Ed51d610c367C61876997F1](https://polygonscan.com/address/0xa3Fa99A148fA48D14Ed51d610c367C61876997F1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA9F3C3caE095527061e6d270DBE163693e6fda9D](https://polygonscan.com/address/0xA9F3C3caE095527061e6d270DBE163693e6fda9D) | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://polygonscan.com/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) |
| variableRateSlope1 | 4 % | 5 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/8d9de32bf30b1c9dcf71f07a13b228c69a71a4ce.svg) | ![after](/.assets/9ed0ac5bda0d6aea5b627325dd757aab5a706122.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA9F3C3caE095527061e6d270DBE163693e6fda9D](https://polygonscan.com/address/0xA9F3C3caE095527061e6d270DBE163693e6fda9D) | [0xD87974E8ED49AB16d5053ba793F4e17078Be0426](https://polygonscan.com/address/0xD87974E8ED49AB16d5053ba793F4e17078Be0426) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| variableRateSlope1 | 4 % | 5 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/8d9de32bf30b1c9dcf71f07a13b228c69a71a4ce.svg) | ![after](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0xC82dF96432346cFb632473eB619Db3B8AC280234",
        "to": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xA9F3C3caE095527061e6d270DBE163693e6fda9D",
        "to": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426"
      }
    },
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "interestRateStrategy": {
        "from": "0xA9F3C3caE095527061e6d270DBE163693e6fda9D",
        "to": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xA9F3C3caE095527061e6d270DBE163693e6fda9D",
        "to": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426"
      }
    }
  },
  "strategies": {
    "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    },
    "0xD87974E8ED49AB16d5053ba793F4e17078Be0426": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    },
    "0xdef8F50155A6cf21181E29E400E8CffAE2d50968": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```