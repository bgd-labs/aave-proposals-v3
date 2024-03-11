## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x3a4D5316ec79622686a19f69CE546997cC8e8514](https://etherscan.io/address/0x3a4D5316ec79622686a19f69CE546997cC8e8514) | [0x9651bD3B008C5C795cA429daA5294dA421d0b315](https://etherscan.io/address/0x9651bD3B008C5C795cA429daA5294dA421d0b315) |
| baseVariableBorrowRate | 7.22 % | 7.92 % |
| interestRate | ![before](/.assets/078d4fa16841aad11aa6c8fee811f71297d1fecd.svg) | ![after](/.assets/04ca1ef2914f4490c0c1d499b7052b43a48c8ace.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x3a4D5316ec79622686a19f69CE546997cC8e8514",
        "to": "0x9651bD3B008C5C795cA429daA5294dA421d0b315"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "address": {
        "from": "0x3a4D5316ec79622686a19f69CE546997cC8e8514",
        "to": "0x9651bD3B008C5C795cA429daA5294dA421d0b315"
      },
      "baseVariableBorrowRate": {
        "from": "72200000000000000000000000",
        "to": "79200000000000000000000000"
      }
    }
  }
}
```