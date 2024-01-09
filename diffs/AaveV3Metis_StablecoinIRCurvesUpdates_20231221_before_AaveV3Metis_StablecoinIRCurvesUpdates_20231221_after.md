## Reserve changes

### Reserve altered

#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://andromeda-explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x3c8DF161A59F2a3ed4D40F073395d6a0f14290C0](https://andromeda-explorer.metis.io/address/0x3c8DF161A59F2a3ed4D40F073395d6a0f14290C0) | [0x463F3F7F0eD356703A9bF2Da3FB95AECBEfe60ce](https://andromeda-explorer.metis.io/address/0x463F3F7F0eD356703A9bF2Da3FB95AECBEfe60ce) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/8b9515dda0fdf5496345adff34aae7cf15e131cd.svg) |

#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://andromeda-explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x082612269926F85741E6c2B0447D000469880c1C](https://andromeda-explorer.metis.io/address/0x082612269926F85741E6c2B0447D000469880c1C) | [0xEDeA87920826abfE28C2D57AC7665B7031f64EfF](https://andromeda-explorer.metis.io/address/0xEDeA87920826abfE28C2D57AC7665B7031f64EfF) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 6 % | 7 % |
| interestRate | ![before](/.assets/ebd346a83b729edecf1938b8cdd0528700c8b9fd.svg) | ![after](/.assets/5f02ea67e5ba53eee2797379ac1cd619db8b194e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "interestRateStrategy": {
        "from": "0x3c8DF161A59F2a3ed4D40F073395d6a0f14290C0",
        "to": "0x463F3F7F0eD356703A9bF2Da3FB95AECBEfe60ce"
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "interestRateStrategy": {
        "from": "0x082612269926F85741E6c2B0447D000469880c1C",
        "to": "0xEDeA87920826abfE28C2D57AC7665B7031f64EfF"
      }
    }
  },
  "strategies": {
    "0x463F3F7F0eD356703A9bF2Da3FB95AECBEfe60ce": {
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
    "0xEDeA87920826abfE28C2D57AC7665B7031f64EfF": {
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