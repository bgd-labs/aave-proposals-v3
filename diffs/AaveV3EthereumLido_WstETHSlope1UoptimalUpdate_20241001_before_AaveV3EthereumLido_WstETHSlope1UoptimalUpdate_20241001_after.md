## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 88.5 % | 87.25 % |
| variableRateSlope1 | 3.5 % | 2.25 % |
| interestRate | ![before](/.assets/20b02c78bc8b99547929074a8d98940dc76ac4e3.svg) | ![after](/.assets/76125e3a0b338875aa6ae2af0ba3fb1ee003880c.svg) |

## Emodes changes

## Raw diff

```json
{
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "maxVariableBorrowRate": {
        "from": "885000000000000000000000000",
        "to": "872500000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "35000000000000000000000000",
        "to": "22500000000000000000000000"
      }
    }
  }
}
```