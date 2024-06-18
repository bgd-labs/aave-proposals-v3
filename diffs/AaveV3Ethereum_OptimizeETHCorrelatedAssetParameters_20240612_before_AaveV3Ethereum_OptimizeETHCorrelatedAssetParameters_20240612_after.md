## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x06B1Ec378618EA736a65395eA5CAB69A2410493B](https://etherscan.io/address/0x06B1Ec378618EA736a65395eA5CAB69A2410493B) | [0x42ec99A020B78C449d17d93bC4c89e0189B5811d](https://etherscan.io/address/0x42ec99A020B78C449d17d93bC4c89e0189B5811d) |
| variableRateSlope1 | 2.8 % | 2.7 % |
| baseStableBorrowRate | 5.8 % | 5.7 % |
| interestRate | ![before](/.assets/6daf9269f48389f432568255131ebe0f742fa53b.svg) | ![after](/.assets/6b6d7d3b24423799c0cb5cc8c539f10b55adce0b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "interestRateStrategy": {
        "from": "0x06B1Ec378618EA736a65395eA5CAB69A2410493B",
        "to": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d"
      }
    }
  },
  "strategies": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "address": {
        "from": "0x06B1Ec378618EA736a65395eA5CAB69A2410493B",
        "to": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d"
      },
      "baseStableBorrowRate": {
        "from": "58000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "28000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```