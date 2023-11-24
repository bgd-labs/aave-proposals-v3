## Reserve changes

### Reserves altered

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://explorer.optimism.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 80 % | 65 % |
| reserveFactor | 20 % | 95 % |
| interestRateStrategy | [0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398](https://explorer.optimism.io/address/0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398) | [0x6D6D3b7FC50999bf20dE5CC8e0F63AFD18B95f0e](https://explorer.optimism.io/address/0x6D6D3b7FC50999bf20dE5CC8e0F63AFD18B95f0e) |
| optimalUsageRatio | 80 % | 45 % |
| maxExcessUsageRatio | 20 % | 55 % |
| variableRateSlope2 | 75 % | 300 % |
| interestRate | ![before](/.assets/6328b8017499aaa1d67053e893c4dc04fca7def7.svg) | ![after](/.assets/ea5b7a01297938e46e8a311bf8a452b147d325a3.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xdFA46478F9e5EA86d57387849598dbFB2e964b02": {
      "interestRateStrategy": {
        "from": "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398",
        "to": "0x6D6D3b7FC50999bf20dE5CC8e0F63AFD18B95f0e"
      },
      "liquidationThreshold": {
        "from": 8000,
        "to": 6500
      },
      "reserveFactor": {
        "from": 2000,
        "to": 9500
      }
    }
  },
  "strategies": {
    "0x6D6D3b7FC50999bf20dE5CC8e0F63AFD18B95f0e": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```