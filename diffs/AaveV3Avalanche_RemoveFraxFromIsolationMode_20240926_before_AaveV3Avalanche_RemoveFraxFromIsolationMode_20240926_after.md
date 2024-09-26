## Reserve changes

### Reserves altered

#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 1,000,000 $ [100000000] | 0 $ [0] |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 77 % [7700] | 81 % [8100] |
| liquidationBonus | 5 % | 4 % |
| reserveFactor | 20 % [2000] | 15 % [1500] |
| maxVariableBorrowRate | 80.5 % | 65.5 % |
| variableRateSlope2 | 75 % | 60 % |
| interestRate | ![before](/.assets/8501d8a163c1631c522dfa4e690ece4f705e1e75.svg) | ![after](/.assets/c460bdc5514185b4dbe953a444830fa62df1e05b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "debtCeiling": {
        "from": 100000000,
        "to": 0
      },
      "liquidationBonus": {
        "from": 10500,
        "to": 10400
      },
      "liquidationThreshold": {
        "from": 7700,
        "to": 8100
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
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "750000000000000000000000000",
        "to": "600000000000000000000000000"
      }
    }
  }
}
```