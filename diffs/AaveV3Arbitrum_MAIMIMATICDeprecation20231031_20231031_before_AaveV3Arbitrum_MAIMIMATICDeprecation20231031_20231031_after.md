## Reserve changes

### Reserves altered

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 80 % | 1 % |
| reserveFactor | 20 % | 95 % |
| interestRateStrategy | [0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://arbiscan.io/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E) | [0xb02381b1d27aA9845e5012083CA288c1818884f0](https://arbiscan.io/address/0xb02381b1d27aA9845e5012083CA288c1818884f0) |
| optimalUsageRatio | 80 % | 45 % |
| maxExcessUsageRatio | 20 % | 55 % |
| variableRateSlope2 | 75 % | 300 % |
| interestRate | ![before](/.assets/6328b8017499aaa1d67053e893c4dc04fca7def7.svg) | ![after](/.assets/ea5b7a01297938e46e8a311bf8a452b147d325a3.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "interestRateStrategy": {
        "from": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
        "to": "0xb02381b1d27aA9845e5012083CA288c1818884f0"
      },
      "liquidationThreshold": {
        "from": 8000,
        "to": 100
      },
      "reserveFactor": {
        "from": 2000,
        "to": 9500
      }
    }
  },
  "strategies": {
    "0xb02381b1d27aA9845e5012083CA288c1818884f0": {
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