## Reserve changes

### Reserve altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 85.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 80 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=855000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 85.5 % | 52.5 % |
| variableRateSlope1 | 5.5 % | 12.5 % |
| variableRateSlope2 | 80 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=855000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66.5 % | 52.5 % |
| variableRateSlope1 | 6.5 % | 12.5 % |
| variableRateSlope2 | 60 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=665000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "maxVariableBorrowRate": {
        "from": "855000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "800000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "maxVariableBorrowRate": {
        "from": "855000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "800000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "maxVariableBorrowRate": {
        "from": "665000000000000000000000000",
        "to": "525000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "125000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "600000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  }
}
```