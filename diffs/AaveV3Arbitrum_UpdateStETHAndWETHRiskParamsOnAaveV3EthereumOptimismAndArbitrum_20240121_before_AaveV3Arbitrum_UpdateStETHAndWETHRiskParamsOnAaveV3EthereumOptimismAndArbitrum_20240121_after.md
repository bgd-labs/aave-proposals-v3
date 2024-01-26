## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://arbiscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514](https://arbiscan.io/address/0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/715cbb89cad22db0c20f074df5ed4b41cd5a2327.svg) | ![after](/.assets/ca6b2aa74895f1fc2926cdd88b0b86033580d616.svg) |

## Raw diff

```json
{
  "eModes": {
    "2": {
      "liquidationBonus": {
        "from": 10200,
        "to": 10100
      },
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
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "interestRateStrategy": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514"
      }
    }
  },
  "strategies": {
    "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514": {
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