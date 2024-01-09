## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7](https://etherscan.io/address/0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7) | [0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0](https://etherscan.io/address/0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0) |
| baseVariableBorrowRate | 5.22 % | 6.22 % |
| interestRate | ![before](/.assets/936d41702486b0b1a932c2191e3bd4ac30b0280f.svg) | ![after](/.assets/005b16eaa54199269ae451836387895a28c5d76e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7",
        "to": "0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0"
      }
    }
  },
  "strategies": {
    "0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "62200000000000000000000000",
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