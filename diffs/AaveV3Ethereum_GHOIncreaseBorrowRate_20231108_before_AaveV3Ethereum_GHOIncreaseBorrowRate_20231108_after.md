## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x1255fC8DC8E76761995aCF544eea54f1B7fB0459](https://etherscan.io/address/0x1255fC8DC8E76761995aCF544eea54f1B7fB0459) | [0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27](https://etherscan.io/address/0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27) |
| baseVariableBorrowRate | 3 % | 4.72 % |
| interestRate | ![before](/.assets/014307f374497fc89005a570ba007728a33c0203.svg) | ![after](/.assets/b88e72716b27c4283bf4287c6417a41bc5b4a2b4.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x1255fC8DC8E76761995aCF544eea54f1B7fB0459",
        "to": "0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27"
      }
    }
  },
  "strategies": {
    "0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "47200000000000000000000000",
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