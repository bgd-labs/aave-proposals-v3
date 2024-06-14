## Reserve changes

### Reserves altered

#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 15 % | 45 % |
| interestRateStrategy | [0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f](https://arbiscan.io/address/0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f) | [0x4011fcd421b9E90f131B164EC1d162DBE269621C](https://arbiscan.io/address/0x4011fcd421b9E90f131B164EC1d162DBE269621C) |
| optimalUsageRatio | 45 % | 35 % |
| maxExcessUsageRatio | 55 % | 65 % |
| interestRate | ![before](/.assets/859e8f346e62fa5dc8eed4d223ca2a8d1c9fc80c.svg) | ![after](/.assets/e18f8e9f35475a5e5187d5baf9a5a10770d874d4.svg) |

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
      "maxExcessUsageRatio": {
        "from": "550000000000000000000000000",
        "to": "650000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "350000000000000000000000000"
      }
    }
  }
}
```