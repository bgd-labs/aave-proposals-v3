## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xb02381b1d27aA9845e5012083CA288c1818884f0](https://etherscan.io/address/0xb02381b1d27aA9845e5012083CA288c1818884f0) | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://etherscan.io/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) |
| optimalUsageRatio | 90 % | 80 % |
| maxExcessUsageRatio | 10 % | 20 % |
| variableRateSlope1 | 3.8 % | 2.8 % |
| baseStableBorrowRate | 6.8 % | 5.8 % |
| interestRate | ![before](/.assets/36935a8fd1d50a51974d60fcb6323e9bc9a95c16.svg) | ![after](/.assets/cf503516adca0ef2b3e859f702e54d27d132edf2.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "interestRateStrategy": {
        "from": "0xb02381b1d27aA9845e5012083CA288c1818884f0",
        "to": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276"
      }
    }
  },
  "strategies": {
    "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "58000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "28000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```