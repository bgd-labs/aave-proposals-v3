## Reserve changes

### Reserves altered

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x8BAdED77793c340ab79848A09C7F5f7F16007Ab6](https://basescan.org/address/0x8BAdED77793c340ab79848A09C7F5f7F16007Ab6) | [0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3](https://basescan.org/address/0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3) |
| variableRateSlope1 | 4 % | 5 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/ea60696e57315a00b0941d7fe1bd186df779165e.svg) | ![after](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "interestRateStrategy": {
        "from": "0x8BAdED77793c340ab79848A09C7F5f7F16007Ab6",
        "to": "0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3"
      }
    }
  },
  "strategies": {
    "0x8c63A1b0721D5776Ae5ed1Be8dc7f2A1e7312Ed3": {
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