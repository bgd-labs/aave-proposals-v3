## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0](https://etherscan.io/address/0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0) | [0x3a4D5316ec79622686a19f69CE546997cC8e8514](https://etherscan.io/address/0x3a4D5316ec79622686a19f69CE546997cC8e8514) |
| baseVariableBorrowRate | 6.22 % | 7.22 % |
| interestRate | ![before](/.assets/898272e7a6d337ab122e44c7b0607c88bdd551ea.svg) | ![after](/.assets/078d4fa16841aad11aa6c8fee811f71297d1fecd.svg) |

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
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "address": {
        "from": "0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0",
        "to": "0x3a4D5316ec79622686a19f69CE546997cC8e8514"
      },
      "baseVariableBorrowRate": {
        "from": "62200000000000000000000000",
        "to": "72200000000000000000000000"
      }
    }
  }
}
```