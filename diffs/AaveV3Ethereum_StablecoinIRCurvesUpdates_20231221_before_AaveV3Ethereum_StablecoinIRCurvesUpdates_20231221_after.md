## Reserve changes

### Reserve altered

#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://etherscan.io/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) | [0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260](https://etherscan.io/address/0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/73cbf1aae04d2063059bb0a9bc283ef7a4332ac4.svg) | ![after](/.assets/463b4c710a9b305cac1e136801dfbb5d2264a078.svg) |

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://etherscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237](https://etherscan.io/address/0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) | ![after](/.assets/5f02ea67e5ba53eee2797379ac1cd619db8b194e.svg) |

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://etherscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) | [0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237](https://etherscan.io/address/0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) | ![after](/.assets/5f02ea67e5ba53eee2797379ac1cd619db8b194e.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://etherscan.io/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://etherscan.io/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/8b9515dda0fdf5496345adff34aae7cf15e131cd.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x588b62C84533232E3A881e096E5D639Fa754F093](https://etherscan.io/address/0x588b62C84533232E3A881e096E5D639Fa754F093) | [0xc77576b02D74BBF9CdC26F3B86FD09d134416df2](https://etherscan.io/address/0xc77576b02D74BBF9CdC26F3B86FD09d134416df2) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/8062d95ddc9e1bec6e4a6b53fca46e335385d902.svg) | ![after](/.assets/118a7baee62d4a7a19fe360ffed3127b5a690301.svg) |

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
    "0x2402C25e7E45b1466c53Ef7766AAd878A4CbC237": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    },
    "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    },
    "0xC0B875907514131C2Fd43f0FBf59EdaB84C7e260": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "870000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "870000000000000000000000000"
      }
    },
    "0xc77576b02D74BBF9CdC26F3B86FD09d134416df2": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "720000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```