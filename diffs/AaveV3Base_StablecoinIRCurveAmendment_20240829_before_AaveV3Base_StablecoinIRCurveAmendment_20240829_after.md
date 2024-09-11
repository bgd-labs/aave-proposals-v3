## Reserve changes

### Reserves altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66.5 % | 65.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/a3d85c79489fe0154b545232de234ff8b5b26977.svg) | ![after](/.assets/b7c1af0d146c8e551ee939f2b5fa07cceab4f7e5.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "maxVariableBorrowRate": {
        "from": "665000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    }
  }
}
```