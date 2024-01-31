## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://explorer.optimism.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326](https://explorer.optimism.io/address/0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326) | [0xd00655ED65edE44354F54A23d46DCbd7ba0727dD](https://explorer.optimism.io/address/0xd00655ED65edE44354F54A23d46DCbd7ba0727dD) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/715cbb89cad22db0c20f074df5ed4b41cd5a2327.svg) | ![after](/.assets/ca6b2aa74895f1fc2926cdd88b0b86033580d616.svg) |

## Raw diff

```json
{
  "eModes": {
    "2": {
      "liquidationThreshold": {
        "from": 9300,
        "to": 9500
      },
      "ltv": {
        "from": 9000,
        "to": 9300
      }
    }
  },
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326",
        "to": "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD"
      }
    }
  },
  "strategies": {
    "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "63000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "33000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```