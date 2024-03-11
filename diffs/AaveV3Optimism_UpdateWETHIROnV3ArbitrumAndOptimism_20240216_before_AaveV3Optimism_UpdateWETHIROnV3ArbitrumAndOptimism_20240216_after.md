## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd00655ED65edE44354F54A23d46DCbd7ba0727dD](https://optimistic.etherscan.io/address/0xd00655ED65edE44354F54A23d46DCbd7ba0727dD) | [0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f](https://optimistic.etherscan.io/address/0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f) |
| variableRateSlope1 | 3.3 % | 3 % |
| baseStableBorrowRate | 6.3 % | 6 % |
| interestRate | ![before](/.assets/4518db8827287a0e0bddbe470c885ab6fa67cf74.svg) | ![after](/.assets/5a987481fcd21ac926a7663682a9aa4ac8703d67.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD",
        "to": "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f"
      }
    }
  },
  "strategies": {
    "0x4200000000000000000000000000000000000006": {
      "address": {
        "from": "0xd00655ED65edE44354F54A23d46DCbd7ba0727dD",
        "to": "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f"
      },
      "baseStableBorrowRate": {
        "from": "63000000000000000000000000",
        "to": "60000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "33000000000000000000000000",
        "to": "30000000000000000000000000"
      }
    }
  }
}
```