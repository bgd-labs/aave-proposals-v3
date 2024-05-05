## Reserve changes

### Reserves altered

#### weETH ([0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee](https://etherscan.io/address/0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 48,000 weETH | 84,000 weETH |
| borrowCap | 3,200 weETH | 29,500 weETH |
| reserveFactor | 15 % | 45 % |
| interestRateStrategy | [0x48AF11111764E710fcDcE2750db848C63edab57B](https://etherscan.io/address/0x48AF11111764E710fcDcE2750db848C63edab57B) | [0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f](https://etherscan.io/address/0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f) |
| optimalUsageRatio | 45 % | 35 % |
| maxExcessUsageRatio | 55 % | 65 % |
| interestRate | ![before](/.assets/aa2e8a5322392ad3d4ae80453f4e281a8da627cc.svg) | ![after](/.assets/0a3dc0cae180a27f87076f3f146ac84c1e5dae43.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
      "borrowCap": {
        "from": 3200,
        "to": 29500
      },
      "interestRateStrategy": {
        "from": "0x48AF11111764E710fcDcE2750db848C63edab57B",
        "to": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f"
      },
      "reserveFactor": {
        "from": 1500,
        "to": 4500
      },
      "supplyCap": {
        "from": 48000,
        "to": 84000
      }
    }
  },
  "strategies": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
      "address": {
        "from": "0x48AF11111764E710fcDcE2750db848C63edab57B",
        "to": "0x0fc12Ad84210695dE8C0D5D8B6f720C37cEaB02f"
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