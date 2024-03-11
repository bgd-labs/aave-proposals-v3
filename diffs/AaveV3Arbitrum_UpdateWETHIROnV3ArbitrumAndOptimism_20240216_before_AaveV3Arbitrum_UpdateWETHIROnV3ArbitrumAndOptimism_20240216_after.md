## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514](https://arbiscan.io/address/0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514) | [0xd56eE97960b1b2953e751151Fd84888cF3F3b521](https://arbiscan.io/address/0xd56eE97960b1b2953e751151Fd84888cF3F3b521) |
| variableRateSlope1 | 3.3 % | 3 % |
| baseStableBorrowRate | 6.3 % | 6 % |
| interestRate | ![before](/.assets/ca6b2aa74895f1fc2926cdd88b0b86033580d616.svg) | ![after](/.assets/4e91bd04e654729df4b59d001423aed83e6d6759.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "interestRateStrategy": {
        "from": "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514",
        "to": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521"
      }
    }
  },
  "strategies": {
    "0xd56eE97960b1b2953e751151Fd84888cF3F3b521": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "30000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```