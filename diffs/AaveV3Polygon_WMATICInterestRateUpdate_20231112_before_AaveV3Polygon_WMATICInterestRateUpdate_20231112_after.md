## Reserve changes

### Reserves altered

#### WMATIC ([0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xFB0898dCFb69DF9E01DBE625A5988D6542e5BdC5](https://polygonscan.com/address/0xFB0898dCFb69DF9E01DBE625A5988D6542e5BdC5) | [0xD87974E8ED49AB16d5053ba793F4e17078Be0426](https://polygonscan.com/address/0xD87974E8ED49AB16d5053ba793F4e17078Be0426) |
| variableRateSlope1 | 6.1 % | 5 % |
| baseStableBorrowRate | 8.1 % | 7 % |
| interestRate | ![before](/.assets/5bbaf463ca5ee6f64b55fc3341caa8cbcee3dfaa.svg) | ![after](/.assets/6edfdcf65d8ca27f3382d649e6163990008780db.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270": {
      "interestRateStrategy": {
        "from": "0xFB0898dCFb69DF9E01DBE625A5988D6542e5BdC5",
        "to": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426"
      }
    }
  },
  "strategies": {
    "0xD87974E8ED49AB16d5053ba793F4e17078Be0426": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "250000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "750000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    }
  }
}
```