## Reserve changes

### Reserve altered

#### WBTC ([0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % | 99 % |
| interestRateStrategy | [0x8d02bac65cd84343eF8239d277794bad455cE889](https://etherscan.io/address/0x8d02bac65cd84343eF8239d277794bad455cE889) | [0xd102F58BF7B2509A2d8664be7C4A90102526B5c6](https://etherscan.io/address/0xd102F58BF7B2509A2d8664be7C4A90102526B5c6) |
| baseVariableBorrowRate | 0 % | 5 % |
| interestRate | ![before](/.assets/9ec14174f670884ad26c4e60158597a3ea46106e.svg) | ![after](/.assets/ae40eb9e5a19ec740fbcf7618e1a89e287803ba7.svg) |

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0xA57cDBfE9FA29Ad842f53100d68789999c04AA36](https://etherscan.io/address/0xA57cDBfE9FA29Ad842f53100d68789999c04AA36) |
| baseVariableBorrowRate | 0 % | 4 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/fb6c6adb04bffc12e5b75a6e30c81de7f9ea04a1.svg) | ![after](/.assets/856903063d3cc6003230aea391bcdd7080ae884e.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0xA57cDBfE9FA29Ad842f53100d68789999c04AA36](https://etherscan.io/address/0xA57cDBfE9FA29Ad842f53100d68789999c04AA36) |
| baseVariableBorrowRate | 0 % | 4 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/fb6c6adb04bffc12e5b75a6e30c81de7f9ea04a1.svg) | ![after](/.assets/856903063d3cc6003230aea391bcdd7080ae884e.svg) |

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x8d02bac65cd84343eF8239d277794bad455cE889](https://etherscan.io/address/0x8d02bac65cd84343eF8239d277794bad455cE889) | [0xdb838A27f91b112D722c854636F2c23720ea007E](https://etherscan.io/address/0xdb838A27f91b112D722c854636F2c23720ea007E) |
| baseVariableBorrowRate | 0 % | 6 % |
| interestRate | ![before](/.assets/9ec14174f670884ad26c4e60158597a3ea46106e.svg) | ![after](/.assets/ed92e8398b27ac9c7c1d23461804e0a36d9ba830.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab](https://etherscan.io/address/0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab) |
| baseVariableBorrowRate | 0 % | 6 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/fb6c6adb04bffc12e5b75a6e30c81de7f9ea04a1.svg) | ![after](/.assets/b2e6e45c0df35c14497c2de70f69481e8b9f59b2.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599": {
      "interestRateStrategy": {
        "from": "0x8d02bac65cd84343eF8239d277794bad455cE889",
        "to": "0xd102F58BF7B2509A2d8664be7C4A90102526B5c6"
      },
      "reserveFactor": {
        "from": 2000,
        "to": 9900
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0xA57cDBfE9FA29Ad842f53100d68789999c04AA36"
      },
      "reserveFactor": {
        "from": 1000,
        "to": 9900
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0xA57cDBfE9FA29Ad842f53100d68789999c04AA36"
      },
      "reserveFactor": {
        "from": 1000,
        "to": 9900
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "interestRateStrategy": {
        "from": "0x8d02bac65cd84343eF8239d277794bad455cE889",
        "to": "0xdb838A27f91b112D722c854636F2c23720ea007E"
      },
      "reserveFactor": {
        "from": 1000,
        "to": 9900
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab"
      },
      "reserveFactor": {
        "from": 1000,
        "to": 9900
      }
    }
  },
  "strategies": {
    "0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "60000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    },
    "0xA57cDBfE9FA29Ad842f53100d68789999c04AA36": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "40000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "100000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    },
    "0xd102F58BF7B2509A2d8664be7C4A90102526B5c6": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "50000000000000000000000000",
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "100000000000000000000000000",
        "stableRateSlope2": "1000000000000000000000000000",
        "variableRateSlope1": "80000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    },
    "0xdb838A27f91b112D722c854636F2c23720ea007E": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "60000000000000000000000000",
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "100000000000000000000000000",
        "stableRateSlope2": "1000000000000000000000000000",
        "variableRateSlope1": "80000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    }
  }
}
```