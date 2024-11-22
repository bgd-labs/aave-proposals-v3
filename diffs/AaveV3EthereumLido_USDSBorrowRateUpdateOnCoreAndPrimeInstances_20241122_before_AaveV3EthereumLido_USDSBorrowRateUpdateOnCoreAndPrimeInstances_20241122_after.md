## Reserve changes

### Reserve altered

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 0.05 % [5] | 0 % [0] |


#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 82 % | 84 % |
| variableRateSlope1 | 6.25 % | 8.25 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=62500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=820000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=82500000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=840000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 5,
        "to": 0
      }
    }
  },
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "maxVariableBorrowRate": {
        "from": "820000000000000000000000000",
        "to": "840000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "62500000000000000000000000",
        "to": "82500000000000000000000000"
      }
    }
  }
}
```