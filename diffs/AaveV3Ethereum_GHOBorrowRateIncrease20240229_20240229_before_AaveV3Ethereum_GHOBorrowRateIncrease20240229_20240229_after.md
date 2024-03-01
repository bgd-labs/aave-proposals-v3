## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0](https://etherscan.io/address/0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0) | [0x3a4D5316ec79622686a19f69CE546997cC8e8514](https://etherscan.io/address/0x3a4D5316ec79622686a19f69CE546997cC8e8514) |
| baseVariableBorrowRate | 6.22 % | 7.22 % |
| interestRate | ![before](/.assets/005b16eaa54199269ae451836387895a28c5d76e.svg) | ![after](/.assets/4986872b45a9cd8b31a38113050f5481468cb333.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0",
        "to": "0x3a4D5316ec79622686a19f69CE546997cC8e8514"
      }
    }
  },
  "strategies": {
    "0x3a4D5316ec79622686a19f69CE546997cC8e8514": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "72200000000000000000000000",
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