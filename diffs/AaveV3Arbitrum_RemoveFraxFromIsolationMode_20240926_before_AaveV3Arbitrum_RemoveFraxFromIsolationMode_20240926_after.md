## Reserve changes

### Reserves altered

#### FRAX ([0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 1,000,000 $ [100000000] | 0 $ [0] |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 72 % [7200] | 78 % [7800] |
| liquidationBonus | 6 % | 5 % |
| reserveFactor | 20 % [2000] | 15 % [1500] |
| maxVariableBorrowRate | 80.5 % | 65.5 % |
| variableRateSlope2 | 75 % | 60 % |
| interestRate | ![before](/.assets/a6c0aceaa49e1b7b29b7ac5bfdef770548c468d6.svg) | ![after](/.assets/d7c18f984b71e5f66cebf23ccf14dfe374c5aea5.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
      "debtCeiling": {
        "from": 100000000,
        "to": 0
      },
      "liquidationBonus": {
        "from": 10600,
        "to": 10500
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
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
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