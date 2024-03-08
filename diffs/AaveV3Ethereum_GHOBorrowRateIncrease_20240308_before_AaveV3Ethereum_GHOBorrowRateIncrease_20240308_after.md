## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x3a4D5316ec79622686a19f69CE546997cC8e8514](https://etherscan.io/address/0x3a4D5316ec79622686a19f69CE546997cC8e8514) | [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f](https://etherscan.io/address/0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f) |
| baseVariableBorrowRate | 7.22 % | 7.92 % |
| interestRate | ![before](/.assets/4986872b45a9cd8b31a38113050f5481468cb333.svg) | ![after](/.assets/8b50edb3973992d1e7ab80f66ab3d34635608456.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x3a4D5316ec79622686a19f69CE546997cC8e8514",
        "to": "0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f"
      }
    }
  },
  "strategies": {
    "0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "79200000000000000000000000",
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