## Reserve changes

### Reserves altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x50eC656Ba67885D0937b5f549f3104ea15E75588](https://basescan.org/address/0x50eC656Ba67885D0937b5f549f3104ea15E75588) | [0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA](https://basescan.org/address/0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA) |
| variableRateSlope1 | 5 % | 6 % |
| baseStableBorrowRate | 5 % | 6 % |
| interestRate | ![before](/.assets/2e2f72b59c8aed1f3554ada1f52a792a7f5846c0.svg) | ![after](/.assets/44bd6c5258c27248fabcd09a99dec757454c2a7e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "interestRateStrategy": {
        "from": "0x50eC656Ba67885D0937b5f549f3104ea15E75588",
        "to": "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA"
      }
    }
  },
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "address": {
        "from": "0x50eC656Ba67885D0937b5f549f3104ea15E75588",
        "to": "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA"
      },
      "baseStableBorrowRate": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "50000000000000000000000000",
        "to": "60000000000000000000000000"
      }
    }
  }
}
```