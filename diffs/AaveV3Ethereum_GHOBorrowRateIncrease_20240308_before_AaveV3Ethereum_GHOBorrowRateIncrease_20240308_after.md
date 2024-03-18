## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x3a4D5316ec79622686a19f69CE546997cC8e8514](https://etherscan.io/address/0x3a4D5316ec79622686a19f69CE546997cC8e8514) | [0x3E49cfe26aaAB501b093AF72A7e5F0152D9D2e76](https://etherscan.io/address/0x3E49cfe26aaAB501b093AF72A7e5F0152D9D2e76) |
| baseVariableBorrowRate | 7.22 % | 7.92 % |
| interestRate | ![before](/.assets/078d4fa16841aad11aa6c8fee811f71297d1fecd.svg) | ![after](/.assets/f81c6249674188eb7c7b4dc65d0841e8424af694.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x3a4D5316ec79622686a19f69CE546997cC8e8514",
        "to": "0x3E49cfe26aaAB501b093AF72A7e5F0152D9D2e76"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "address": {
        "from": "0x3a4D5316ec79622686a19f69CE546997cC8e8514",
        "to": "0x3E49cfe26aaAB501b093AF72A7e5F0152D9D2e76"
      },
      "baseVariableBorrowRate": {
        "from": "72200000000000000000000000",
        "to": "79200000000000000000000000"
      }
    }
  }
}
```