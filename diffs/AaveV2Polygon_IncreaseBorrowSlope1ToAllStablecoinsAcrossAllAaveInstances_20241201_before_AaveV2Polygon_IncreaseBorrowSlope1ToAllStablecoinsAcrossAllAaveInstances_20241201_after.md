## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x4309B0d719a0Dfb526EE9C0E58b77635B2971cC4](https://polygonscan.com/address/0x4309B0d719a0Dfb526EE9C0E58b77635B2971cC4) | [0xA78F3bc07035422f6f69c3f2B72fcCd0487348FA](https://polygonscan.com/address/0xA78F3bc07035422f6f69c3f2B72fcCd0487348FA) |
| variableRateSlope1 | 15 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=770000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=770000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xDa6b70b725404A0c6bb116B1584fb88Eb7d7ED6d](https://polygonscan.com/address/0xDa6b70b725404A0c6bb116B1584fb88Eb7d7ED6d) | [0xfe72F0c532c4E7cfA65FCbd3B92D926d26Fb73a9](https://polygonscan.com/address/0xfe72F0c532c4E7cfA65FCbd3B92D926d26Fb73a9) |
| variableRateSlope1 | 15 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=710000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=710000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xAb85FD7DCBFdD40e822321DAc4D5fD3cf08b2542](https://polygonscan.com/address/0xAb85FD7DCBFdD40e822321DAc4D5fD3cf08b2542) | [0xe80CDBb7115004064BDD62aEe89666d6b4B75921](https://polygonscan.com/address/0xe80CDBb7115004064BDD62aEe89666d6b4B75921) |
| variableRateSlope1 | 15 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=150000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=520000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=1340000000000000000000000000&optimalUsageRatio=520000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0x4309B0d719a0Dfb526EE9C0E58b77635B2971cC4",
        "to": "0xA78F3bc07035422f6f69c3f2B72fcCd0487348FA"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xDa6b70b725404A0c6bb116B1584fb88Eb7d7ED6d",
        "to": "0xfe72F0c532c4E7cfA65FCbd3B92D926d26Fb73a9"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xAb85FD7DCBFdD40e822321DAc4D5fD3cf08b2542",
        "to": "0xe80CDBb7115004064BDD62aEe89666d6b4B75921"
      }
    }
  },
  "strategies": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "address": {
        "from": "0x4309B0d719a0Dfb526EE9C0E58b77635B2971cC4",
        "to": "0xA78F3bc07035422f6f69c3f2B72fcCd0487348FA"
      },
      "variableRateSlope1": {
        "from": "150000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "address": {
        "from": "0xDa6b70b725404A0c6bb116B1584fb88Eb7d7ED6d",
        "to": "0xfe72F0c532c4E7cfA65FCbd3B92D926d26Fb73a9"
      },
      "variableRateSlope1": {
        "from": "150000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "address": {
        "from": "0xAb85FD7DCBFdD40e822321DAc4D5fD3cf08b2542",
        "to": "0xe80CDBb7115004064BDD62aEe89666d6b4B75921"
      },
      "variableRateSlope1": {
        "from": "150000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  }
}
```