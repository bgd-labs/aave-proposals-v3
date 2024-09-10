## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/e5ed2ed6768425fa4d6a23fc1e9108aa39506079.svg) | ![after](/.assets/994b70ffe8e97eef41ddd82f6d7bbcc62f19f899.svg) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66.5 % | 65.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/c31244b35151ba88ee39a0d6cb7c37ba71cc2b53.svg) | ![after](/.assets/1927d87f08a02013cbc2cc83f90edb2bd3121ae9.svg) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/e5ed2ed6768425fa4d6a23fc1e9108aa39506079.svg) | ![after](/.assets/994b70ffe8e97eef41ddd82f6d7bbcc62f19f899.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "maxVariableBorrowRate": {
        "from": "665000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    }
  }
}
```