## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326](https://optimistic.etherscan.io/address/0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326) | [0xd00655ED65edE44354F54A23d46DCbd7ba0727dD](https://optimistic.etherscan.io/address/0xd00655ED65edE44354F54A23d46DCbd7ba0727dD) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| interestRate | ![before](/.assets/44f8b63555df7a9d81101549741bd958deb27588.svg) | ![after](/.assets/4518db8827287a0e0bddbe470c885ab6fa67cf74.svg) |

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
    "0x4200000000000000000000000000000000000006": {
      "address": {
        "from": "0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326",
        "to": "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD"
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