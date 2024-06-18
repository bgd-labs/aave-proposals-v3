## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f](https://optimistic.etherscan.io/address/0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f) | [0x129F838C3339f64a026aeb334Ffd5d55C2E94935](https://optimistic.etherscan.io/address/0x129F838C3339f64a026aeb334Ffd5d55C2E94935) |
| variableRateSlope1 | 3 % | 2.7 % |
| baseStableBorrowRate | 6 % | 5.7 % |
| interestRate | ![before](/.assets/5a987481fcd21ac926a7663682a9aa4ac8703d67.svg) | ![after](/.assets/982b4fb6e2527921645edf26069ca5a944a85de5.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f",
        "to": "0x129F838C3339f64a026aeb334Ffd5d55C2E94935"
      }
    }
  },
  "strategies": {
    "0x4200000000000000000000000000000000000006": {
      "address": {
        "from": "0x16F9bBeE415e519F184Fe1c09d653C6567e4eb2f",
        "to": "0x129F838C3339f64a026aeb334Ffd5d55C2E94935"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "30000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```