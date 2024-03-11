## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://etherscan.io/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) | [0x06B1Ec378618EA736a65395eA5CAB69A2410493B](https://etherscan.io/address/0x06B1Ec378618EA736a65395eA5CAB69A2410493B) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/fb9a10bdacab14a10bdb79ed7c595485bd4216d5.svg) | ![after](/.assets/6daf9269f48389f432568255131ebe0f742fa53b.svg) |

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
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "address": {
        "from": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276",
        "to": "0x06B1Ec378618EA736a65395eA5CAB69A2410493B"
      },
      "maxExcessUsageRatio": {
        "from": "200000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "800000000000000000000000000",
        "to": "900000000000000000000000000"
      }
    }
  }
}
```