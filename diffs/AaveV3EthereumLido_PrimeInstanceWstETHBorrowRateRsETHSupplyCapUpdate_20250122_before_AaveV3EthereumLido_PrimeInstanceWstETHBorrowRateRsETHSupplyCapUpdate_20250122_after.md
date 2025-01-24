## Reserve changes

### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 86.75 % | 85.75 % |
| variableRateSlope1 | 1.75 % | 0.75 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=17500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=867500000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=850000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=857500000000000000000000000) |

#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000 rsETH | 65,000 rsETH |


## Raw diff

```json
{
  "reserves": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "supplyCap": {
        "from": 10000,
        "to": 65000
      }
    }
  },
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "maxVariableBorrowRate": {
        "from": "867500000000000000000000000",
        "to": "857500000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "17500000000000000000000000",
        "to": "7500000000000000000000000"
      }
    }
  }
}
```