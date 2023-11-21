## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27](https://etherscan.io/address/0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27) | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://etherscan.io/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) |
| maxExcessUsageRatio | 0 % | 100 % |
| baseVariableBorrowRate | 4.72 % | 5.22 % |
| optimalStableToTotalDebtRatio | 0 % | 1 % |
| maxExcessStableToTotalDebtRatio | 0 % | 99 % |
| interestRate | ![before](/.assets/b88e72716b27c4283bf4287c6417a41bc5b4a2b4.svg) | ![after](/.assets/779fb4cfdc8fd6024046d5f1bcff7dd31ce7907e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27",
        "to": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9"
      }
    }
  },
  "strategies": {
    "0x53b13a6D43F647D788411Abfd28D229C274AfBF9": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "52200000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "990000000000000000000000000",
        "maxExcessUsageRatio": "1000000000000000000000000000",
        "optimalStableToTotalDebtRatio": "10000000000000000000000000",
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