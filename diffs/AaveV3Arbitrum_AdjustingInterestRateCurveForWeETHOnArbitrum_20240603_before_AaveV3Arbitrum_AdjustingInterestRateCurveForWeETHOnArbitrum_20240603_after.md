## Reserve changes

### Reserves altered

#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 15 % | 45 % |
| interestRateStrategy | [0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f](https://arbiscan.io/address/0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f) | [0x4011fcd421b9E90f131B164EC1d162DBE269621C](https://arbiscan.io/address/0x4011fcd421b9E90f131B164EC1d162DBE269621C) |
| optimalUsageRatio | 45 % | 35 % |
| baseStableBorrowRate | 9 % | 7 % |
| maxExcessStableToTotalDebtRatio | 80 % | 100 % |
| maxExcessUsageRatio | 55 % | 65 % |
| optimalStableToTotalDebtRatio | 20 % | 0 % |
| interestRate | ![before](/.assets/859e8f346e62fa5dc8eed4d223ca2a8d1c9fc80c.svg) | ![after](/.assets/3aaaf674e060809c81e8e6b0316631fac3bf3376.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "interestRateStrategy": {
        "from": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f",
        "to": "0x4011fcd421b9E90f131B164EC1d162DBE269621C"
      },
      "reserveFactor": {
        "from": 1500,
        "to": 4500
      }
    }
  },
  "strategies": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "address": {
        "from": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f",
        "to": "0x4011fcd421b9E90f131B164EC1d162DBE269621C"
      },
      "baseStableBorrowRate": {
        "from": "90000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "maxExcessStableToTotalDebtRatio": {
        "from": "800000000000000000000000000",
        "to": "1000000000000000000000000000"
      },
      "maxExcessUsageRatio": {
        "from": "550000000000000000000000000",
        "to": "650000000000000000000000000"
      },
      "optimalStableToTotalDebtRatio": {
        "from": "200000000000000000000000000",
        "to": 0
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "350000000000000000000000000"
      }
    }
  }
}
```