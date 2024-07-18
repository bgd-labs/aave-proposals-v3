## Reserve changes

### Reserves altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9](https://basescan.org/address/0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9) | [0x8d09558a46178E28FC9703787c164C829De3FfF3](https://basescan.org/address/0x8d09558a46178E28FC9703787c164C829De3FfF3) |
| variableRateSlope1 | 9 % | 6.5 % |
| baseStableBorrowRate | 9 % | 6.5 % |
| interestRate | ![before](/.assets/f5485a1f322764552b7a360d6d4890b45801d1dc.svg) | ![after](/.assets/2fce62a2023bb2dd5daf3cf1afe59089cd546450.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "interestRateStrategy": {
        "from": "0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9",
        "to": "0x8d09558a46178E28FC9703787c164C829De3FfF3"
      }
    }
  },
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "address": {
        "from": "0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9",
        "to": "0x8d09558a46178E28FC9703787c164C829De3FfF3"
      },
      "baseStableBorrowRate": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  }
}
```