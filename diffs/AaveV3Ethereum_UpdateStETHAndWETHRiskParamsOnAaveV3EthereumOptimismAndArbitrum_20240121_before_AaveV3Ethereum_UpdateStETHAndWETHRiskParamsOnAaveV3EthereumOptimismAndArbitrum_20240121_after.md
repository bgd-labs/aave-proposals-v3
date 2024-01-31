## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://etherscan.io/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) | [0x06B1Ec378618EA736a65395eA5CAB69A2410493B](https://etherscan.io/address/0x06B1Ec378618EA736a65395eA5CAB69A2410493B) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/cf503516adca0ef2b3e859f702e54d27d132edf2.svg) | ![after](/.assets/266cb15d48681d72fe262fbf1e9a82effed54078.svg) |

## Raw diff

```json
{
  "eModes": {
    "1": {
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
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "interestRateStrategy": {
        "from": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276",
        "to": "0x06B1Ec378618EA736a65395eA5CAB69A2410493B"
      }
    }
  },
  "strategies": {
    "0x06B1Ec378618EA736a65395eA5CAB69A2410493B": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "58000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "28000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```