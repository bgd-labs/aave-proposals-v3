## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://arbiscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514](https://arbiscan.io/address/0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/3d8eed0f38805dea3da835c8c9505d09e57e6996.svg) | ![after](/.assets/4870b62e3dee98639241facda7590d661b69fb62.svg) |

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
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "address": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514"
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