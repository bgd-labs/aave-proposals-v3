## Reserve changes

### Reserve altered

#### USDC ([0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8](https://arbiscan.io/address/0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 150,000,000 USDC | 26,000,000 USDC |
| borrowCap | 100,000,000 USDC | 24,000,000 USDC |
| ltv | 81 % | 77 % |
| liquidationThreshold | 86 % | 80 % |
| reserveFactor | 10 % | 20 % |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://arbiscan.io/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://arbiscan.io/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| variableRateSlope1 | 5 % | 7 % |
| variableRateSlope2 | 60 % | 80 % |
| baseStableBorrowRate | 6 % | 8 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/08d9252b4f8f8c9e59638a9a35a34e736f126166.svg) |

#### USDC ([0xaf88d065e77c8cC2239327C5EDb3A432268e5831](https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831))

| description | value before | value after |
| --- | --- | --- |
| ltv | 81 % | 77 % |
| liquidationThreshold | 86 % | 80 % |


## Raw diff

```json
{
  "reserves": {
    "0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8": {
      "borrowCap": {
        "from": 100000000,
        "to": 24000000
      },
      "interestRateStrategy": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      },
      "liquidationThreshold": {
        "from": 8600,
        "to": 8000
      },
      "ltv": {
        "from": 8100,
        "to": 7700
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      },
      "supplyCap": {
        "from": 150000000,
        "to": 26000000
      }
    },
    "0xaf88d065e77c8cC2239327C5EDb3A432268e5831": {
      "liquidationThreshold": {
        "from": 8600,
        "to": 8000
      },
      "ltv": {
        "from": 8100,
        "to": 7700
      }
    }
  },
  "strategies": {
    "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```