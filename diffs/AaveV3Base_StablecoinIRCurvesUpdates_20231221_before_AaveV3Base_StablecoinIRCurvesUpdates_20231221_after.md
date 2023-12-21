## Reserve changes

### Reserves altered

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3](https://basescan.org/address/0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3) | [0x50eC656Ba67885D0937b5f549f3104ea15E75588](https://basescan.org/address/0x50eC656Ba67885D0937b5f549f3104ea15E75588) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/8b9515dda0fdf5496345adff34aae7cf15e131cd.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "interestRateStrategy": {
        "from": "0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3",
        "to": "0x50eC656Ba67885D0937b5f549f3104ea15E75588"
      }
    }
  },
  "strategies": {
    "0x50eC656Ba67885D0937b5f549f3104ea15E75588": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```