## Reserve changes

### Reserve altered

#### WBTC ([0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % | 99 % |
| interestRateStrategy | [0x8d02bac65cd84343eF8239d277794bad455cE889](https://etherscan.io/address/0x8d02bac65cd84343eF8239d277794bad455cE889) | [0xd102F58BF7B2509A2d8664be7C4A90102526B5c6](https://etherscan.io/address/0xd102F58BF7B2509A2d8664be7C4A90102526B5c6) |
| baseVariableBorrowRate | 0 % | 5 % |
| interestRate | ![before](/.assets/17fde8c4c743d3b880e9ce606966811d558db12c.svg) | ![after](/.assets/83797fa85ad44b3d859b8f7ee4c8132fef352ba0.svg) |

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0xA57cDBfE9FA29Ad842f53100d68789999c04AA36](https://etherscan.io/address/0xA57cDBfE9FA29Ad842f53100d68789999c04AA36) |
| baseVariableBorrowRate | 0 % | 4 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/91b87729e304c62d52a6a140b1ebd8dffffa9c58.svg) | ![after](/.assets/9064429ce67d1de535eb77d22b1f300805ae14ac.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0xA57cDBfE9FA29Ad842f53100d68789999c04AA36](https://etherscan.io/address/0xA57cDBfE9FA29Ad842f53100d68789999c04AA36) |
| baseVariableBorrowRate | 0 % | 4 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/91b87729e304c62d52a6a140b1ebd8dffffa9c58.svg) | ![after](/.assets/9064429ce67d1de535eb77d22b1f300805ae14ac.svg) |

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x8d02bac65cd84343eF8239d277794bad455cE889](https://etherscan.io/address/0x8d02bac65cd84343eF8239d277794bad455cE889) | [0xdb838A27f91b112D722c854636F2c23720ea007E](https://etherscan.io/address/0xdb838A27f91b112D722c854636F2c23720ea007E) |
| baseVariableBorrowRate | 0 % | 6 % |
| interestRate | ![before](/.assets/17fde8c4c743d3b880e9ce606966811d558db12c.svg) | ![after](/.assets/43e5be641d9be4440848e65ee58c23e8a8ec133e.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 99 % |
| interestRateStrategy | [0x79F40CDF9f491f148E522D7845c3fBF61E56c33F](https://etherscan.io/address/0x79F40CDF9f491f148E522D7845c3fBF61E56c33F) | [0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab](https://etherscan.io/address/0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab) |
| baseVariableBorrowRate | 0 % | 6 % |
| variableRateSlope1 | 4 % | 10 % |
| interestRate | ![before](/.assets/91b87729e304c62d52a6a140b1ebd8dffffa9c58.svg) | ![after](/.assets/df20c061a799bbdc5909ab03884459554673dfd1.svg) |

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
    "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599": {
      "address": {
        "from": "0x8d02bac65cd84343eF8239d277794bad455cE889",
        "to": "0xd102F58BF7B2509A2d8664be7C4A90102526B5c6"
      },
      "baseVariableBorrowRate": {
        "from": 0,
        "to": "50000000000000000000000000"
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0xA57cDBfE9FA29Ad842f53100d68789999c04AA36"
      },
      "baseVariableBorrowRate": {
        "from": 0,
        "to": "40000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "40000000000000000000000000",
        "to": "100000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0xA57cDBfE9FA29Ad842f53100d68789999c04AA36"
      },
      "baseVariableBorrowRate": {
        "from": 0,
        "to": "40000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "40000000000000000000000000",
        "to": "100000000000000000000000000"
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "address": {
        "from": "0x8d02bac65cd84343eF8239d277794bad455cE889",
        "to": "0xdb838A27f91b112D722c854636F2c23720ea007E"
      },
      "baseVariableBorrowRate": {
        "from": 0,
        "to": "60000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0x79F40CDF9f491f148E522D7845c3fBF61E56c33F",
        "to": "0x2223cd25f60F3e4035fcEfE44612773AFEbFd8ab"
      },
      "baseVariableBorrowRate": {
        "from": 0,
        "to": "60000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "40000000000000000000000000",
        "to": "100000000000000000000000000"
      }
    }
  }
}
```