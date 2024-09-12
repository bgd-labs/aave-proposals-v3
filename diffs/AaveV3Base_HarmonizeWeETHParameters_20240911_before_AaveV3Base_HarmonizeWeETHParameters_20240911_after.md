## Reserve changes

### Reserves altered

#### weETH ([0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A](https://basescan.org/address/0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 35 % | 30 % |
| maxVariableBorrowRate | 307 % | 308 % |
| baseVariableBorrowRate | 0 % | 1 % |
| interestRate | ![before](/.assets/18948e0081ff6de7a89e181cd34be415a7a68ce0.svg) | ![after](/.assets/abf3f4dbe21b49b5a01a454f7cf6c1dff3879949.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A": {
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