## Reserve changes

### Reserve altered

#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 82 % | 84.5 % |
| variableRateSlope1 | 7 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=820000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66 % | 69.5 % |
| variableRateSlope1 | 6 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=60000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=660000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=695000000000000000000000000) |

#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81 % | 84.5 % |
| variableRateSlope1 | 6 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=60000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=810000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "maxVariableBorrowRate": {
        "from": "820000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "maxVariableBorrowRate": {
        "from": "660000000000000000000000000",
        "to": "695000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "maxVariableBorrowRate": {
        "from": "810000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```