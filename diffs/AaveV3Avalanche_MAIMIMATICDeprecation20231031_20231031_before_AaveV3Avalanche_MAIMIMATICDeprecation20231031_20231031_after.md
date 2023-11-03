## Reserve changes

### Reserves altered

#### MAI ([0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b](https://snowtrace.io/address/0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % | 95 % |
| interestRateStrategy | [0xfab05a6aF585da2F96e21452F91E812452996BD3](https://snowtrace.io/address/0xfab05a6aF585da2F96e21452F91E812452996BD3) | [0x04daBC3C1c052AB94AA2ca80140f2b978d2F6E17](https://snowtrace.io/address/0x04daBC3C1c052AB94AA2ca80140f2b978d2F6E17) |
| optimalUsageRatio | 80 % | 45 % |
| maxExcessUsageRatio | 20 % | 55 % |
| variableRateSlope2 | 75 % | 300 % |
| interestRate | ![before](/.assets/8d9de32bf30b1c9dcf71f07a13b228c69a71a4ce.svg) | ![after](/.assets/4422a290bbbd57f615385e22c6be99ae91417cb5.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b": {
      "interestRateStrategy": {
        "from": "0xfab05a6aF585da2F96e21452F91E812452996BD3",
        "to": "0x04daBC3C1c052AB94AA2ca80140f2b978d2F6E17"
      },
      "reserveFactor": {
        "from": 2000,
        "to": 9500
      }
    }
  },
  "strategies": {
    "0x04daBC3C1c052AB94AA2ca80140f2b978d2F6E17": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```