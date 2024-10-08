## Reserve changes

### Reserves altered

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 10,000,000 $ [1000000000] | 0 $ [0] |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 72 % [7200] | 78 % [7800] |
| liquidationBonus | 6 % | 4.5 % |
| liquidationProtocolFee | 10 % [1000] | 20 % [2000] |
| reserveFactor | 20 % [2000] | 15 % [1500] |
| optimalUsageRatio | 90 % | 92 % |
| maxVariableBorrowRate | 80.5 % | 65.5 % |
| variableRateSlope2 | 75 % | 60 % |
| interestRate | ![before](/.assets/a05225d2527d0291dbe4574aa3ce9f1f7d877630.svg) | ![after](/.assets/b0acfa5411927b1e11f45e03da6fe62446569b2d.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "debtCeiling": {
        "from": 1000000000,
        "to": 0
      },
      "liquidationBonus": {
        "from": 10600,
        "to": 10450
      },
      "liquidationProtocolFee": {
        "from": 1000,
        "to": 2000
      },
      "liquidationThreshold": {
        "from": 7200,
        "to": 7800
      },
      "ltv": {
        "from": 0,
        "to": 7500
      },
      "reserveFactor": {
        "from": 2000,
        "to": 1500
      }
    }
  },
  "strategies": {
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "900000000000000000000000000",
        "to": "920000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "600000000000000000000000000"
      }
    }
  }
}
```