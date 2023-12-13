## Reserve changes

### Reserves altered

#### GNO ([0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb](https://blockscout.com/xdai/mainnet/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 0 GNO | 1,100 GNO |
| reserveFactor | 15 % | 20 % |
| borrowingEnabled | false | true |
| interestRateStrategy | [0x9E57695Dab0DCdb42BC220ff1E9eb2e22a31209b](https://blockscout.com/xdai/mainnet/address/0x9E57695Dab0DCdb42BC220ff1E9eb2e22a31209b) | [0x777fDAB3C03aA63d7d7CbCbaB22724cEe50F1731](https://blockscout.com/xdai/mainnet/address/0x777fDAB3C03aA63d7d7CbCbaB22724cEe50F1731) |
| optimalUsageRatio | 45 % | 80 % |
| maxExcessUsageRatio | 55 % | 20 % |
| variableRateSlope1 | 7 % | 15 % |
| variableRateSlope2 | 300 % | 80 % |
| baseStableBorrowRate | 9 % | 17 % |
| interestRate | ![before](/.assets/b5cb0fd07fde8594230045982589445fc02ace52.svg) | ![after](/.assets/33720c1c65dbe523de979598d779bc55b6e09a4a.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb": {
      "borrowCap": {
        "from": 0,
        "to": 1100
      },
      "borrowingEnabled": {
        "from": false,
        "to": true
      },
      "interestRateStrategy": {
        "from": "0x9E57695Dab0DCdb42BC220ff1E9eb2e22a31209b",
        "to": "0x777fDAB3C03aA63d7d7CbCbaB22724cEe50F1731"
      },
      "reserveFactor": {
        "from": 1500,
        "to": 2000
      }
    }
  },
  "strategies": {
    "0x777fDAB3C03aA63d7d7CbCbaB22724cEe50F1731": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "170000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "150000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```