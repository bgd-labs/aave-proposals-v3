## Reserve changes

### Reserve altered

#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://etherscan.io/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) | [0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260](https://etherscan.io/address/0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/df5f8d4e981d7df1fa5125ff64ae540b4c74d29b.svg) | ![after](/.assets/dc936825b052222d6d3ba80110bf44c7c8d27b10.svg) |

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://etherscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237](https://etherscan.io/address/0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/d28259358b2ac4bc13298220f6ea2075acfdad14.svg) | ![after](/.assets/471bf36a0704f0fb8e9dd43041d549e5e7198527.svg) |

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://etherscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237](https://etherscan.io/address/0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/d28259358b2ac4bc13298220f6ea2075acfdad14.svg) | ![after](/.assets/471bf36a0704f0fb8e9dd43041d549e5e7198527.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://etherscan.io/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://etherscan.io/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/f026f669632b38618fe2f5e520b460247c827ccb.svg) | ![after](/.assets/cf8cdad86320a216fb48759e63e01741a6ed442d.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x588b62C84533232E3A881e096E5D639Fa754F093](https://etherscan.io/address/0x588b62C84533232E3A881e096E5D639Fa754F093) | [0xc77576b02D74BBF9CdC26F3B86FD09d134416df2](https://etherscan.io/address/0xc77576b02D74BBF9CdC26F3B86FD09d134416df2) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/de3c0e0ab4fbbbdee53fcc7772fc7d8c66a10e5c.svg) | ![after](/.assets/2278f5a715be21ce4c1a7931f606c4a368fe286b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "interestRateStrategy": {
        "from": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477",
        "to": "0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260"
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237"
      }
    },
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "interestRateStrategy": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0x588b62C84533232E3A881e096E5D639Fa754F093",
        "to": "0xc77576b02D74BBF9CdC26F3B86FD09d134416df2"
      }
    }
  },
  "strategies": {
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "address": {
        "from": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477",
        "to": "0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "address": {
        "from": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3",
        "to": "0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0x588b62C84533232E3A881e096E5D639Fa754F093",
        "to": "0xc77576b02D74BBF9CdC26F3B86FD09d134416df2"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "70000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    }
  }
}
```