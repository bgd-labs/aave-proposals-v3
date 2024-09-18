## Reserve changes

### Reserves altered

#### weETH ([0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee](https://etherscan.io/address/0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 35 % | 30 % |
| maxVariableBorrowRate | 307 % | 308 % |
| baseVariableBorrowRate | 0 % | 1 % |
| interestRate | ![before](/.assets/c1690b11066430bfb069e06227cc53f8654a7b5a.svg) | ![after](/.assets/80a5ac377b9266be7636eb4f242e5817d4de031d.svg) |

## Raw diff

```json
{
  "strategies": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
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