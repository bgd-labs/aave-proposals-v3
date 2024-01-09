## Reserve changes

### Reserves altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x50eC656Ba67885D0937b5f549f3104ea15E75588](https://basescan.org/address/0x50eC656Ba67885D0937b5f549f3104ea15E75588) | [0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA](https://basescan.org/address/0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/efc214f63e0c80895bc42d351a69ea2281997d59.svg) | ![after](/.assets/1bf7f5ea4bc4131bb00d0f8615d2e561b91b50c3.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "interestRateStrategy": {
        "from": "0x50eC656Ba67885D0937b5f549f3104ea15E75588",
        "to": "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA"
      }
    }
  },
  "strategies": {
    "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```