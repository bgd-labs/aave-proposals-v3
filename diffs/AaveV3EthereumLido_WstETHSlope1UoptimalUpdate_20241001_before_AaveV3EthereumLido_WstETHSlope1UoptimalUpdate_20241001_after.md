## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 88.5 % | 87.25 % |
| variableRateSlope1 | 3.5 % | 2.25 % |
| interestRate | ![before](/.assets/4f278d3e1c4335b98c92585fbeb92d263bdb8569.svg) | ![after](/.assets/5e92a6663aeee25254a2740f3a545f211faeacbf.svg) |

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