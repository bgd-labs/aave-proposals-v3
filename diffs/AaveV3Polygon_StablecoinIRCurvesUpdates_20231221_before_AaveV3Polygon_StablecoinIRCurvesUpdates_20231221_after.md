## Reserve changes

### Reserve altered

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x53b13a6D43F647D788411Abfd28D229C274AfBF9](https://polygonscan.com/address/0x53b13a6D43F647D788411Abfd28D229C274AfBF9) | [0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1](https://polygonscan.com/address/0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/84c6523d74f61d0ba00e446918a767fdc26e571b.svg) | ![after](/.assets/318b60b17ede8c1afe32538706766de085a6f3c7.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://polygonscan.com/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://polygonscan.com/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) | ![after](/.assets/5f02ea67e5ba53eee2797379ac1cd619db8b194e.svg) |

#### miMATIC ([0xa3Fa99A148fA48D14Ed51d610c367C61876997F1](https://polygonscan.com/address/0xa3Fa99A148fA48D14Ed51d610c367C61876997F1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://polygonscan.com/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) | [0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4](https://polygonscan.com/address/0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/6d0466e349dc1a41744012a7a6812bbcfcbfdb5e.svg) | ![after](/.assets/24ab0519b4e661fabfd48ccb2fea68b108bfb132.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://polygonscan.com/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) | [0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477](https://polygonscan.com/address/0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) | ![after](/.assets/5f02ea67e5ba53eee2797379ac1cd619db8b194e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "interestRateStrategy": {
        "from": "0x53b13a6D43F647D788411Abfd28D229C274AfBF9",
        "to": "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
      }
    },
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "interestRateStrategy": {
        "from": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276",
        "to": "0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477"
      }
    }
  },
  "strategies": {
    "0x44CaDF6E49895640D9De85ac01d97D44429Ad0A4": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "70000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    },
    "0x642a8DAcC59b73491Dcaa3BCeF046D660901fCc1": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    },
    "0xaDbdb3d6B51151e4CDF32e4050B6F03D2bfB6477": {
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
    }
  }
}
```