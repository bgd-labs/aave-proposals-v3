## Reserve changes

### Reserves altered

#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 35 % | 30 % |
| maxVariableBorrowRate | 307 % | 308 % |
| baseVariableBorrowRate | 0 % | 1 % |
| interestRate | ![before](/.assets/f92553fdc4d7f4240a8aafba03874d7bc98ef332.svg) | ![after](/.assets/2084128da4fb9059c8224e1af5b855f4aaa36ba4.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "10000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "3070000000000000000000000000",
        "to": "3080000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "350000000000000000000000000",
        "to": "300000000000000000000000000"
      }
    }
  }
}
```