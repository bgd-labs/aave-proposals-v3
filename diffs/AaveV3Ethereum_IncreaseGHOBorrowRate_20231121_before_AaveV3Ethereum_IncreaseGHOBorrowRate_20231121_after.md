## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27](https://etherscan.io/address/0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27) | [0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7](https://etherscan.io/address/0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7) |
| baseVariableBorrowRate | 4.72 % | 5.22 % |
| interestRate | ![before](/.assets/b88e72716b27c4283bf4287c6417a41bc5b4a2b4.svg) | ![after](/.assets/936d41702486b0b1a932c2191e3bd4ac30b0280f.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27",
        "to": "0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7"
      }
    }
  },
  "strategies": {
    "0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "52200000000000000000000000",
        "maxExcessStableToTotalDebtRatio": 0,
        "maxExcessUsageRatio": 0,
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": 0,
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": 0,
        "variableRateSlope2": 0
      }
    }
  }
}
```