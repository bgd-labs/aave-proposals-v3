## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd00655ED65edE44354F54A23d46DCbd7ba0727dD](https://optimistic.etherscan.io/address/0xd00655ED65edE44354F54A23d46DCbd7ba0727dD) | [0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f](https://optimistic.etherscan.io/address/0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f) |
| variableRateSlope1 | 3.3 % | 3 % |
| baseStableBorrowRate | 6.3 % | 6 % |
| interestRate | ![before](/.assets/ca6b2aa74895f1fc2926cdd88b0b86033580d616.svg) | ![after](/.assets/4e91bd04e654729df4b59d001423aed83e6d6759.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD",
        "to": "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f"
      }
    }
  },
  "strategies": {
    "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f": {
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