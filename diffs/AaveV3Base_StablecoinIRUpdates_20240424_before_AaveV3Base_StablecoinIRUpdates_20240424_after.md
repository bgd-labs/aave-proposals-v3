## Reserve changes

### Reserve altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A](https://basescan.org/address/0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A) | [0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9](https://basescan.org/address/0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 12 % | 9 % |
| interestRate | ![before](/.assets/2dd6d84168e4068a40122f647020c27ee3e36ed1.svg) | ![after](/.assets/f5485a1f322764552b7a360d6d4890b45801d1dc.svg) |

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x64163263753A9610a391A5D0276ae94B0d42fB75](https://basescan.org/address/0x64163263753A9610a391A5D0276ae94B0d42fB75) | [0x992ff76913Db79eCA51666D1e09b4F5Cf078dF7D](https://basescan.org/address/0x992ff76913Db79eCA51666D1e09b4F5Cf078dF7D) |
| variableRateSlope1 | 13 % | 10 % |
| baseStableBorrowRate | 14 % | 11 % |
| interestRate | ![before](/.assets/830c41eadf476da561594683a69e91e3a5f6862f.svg) | ![after](/.assets/1fcc1b0751c3b07af596103ceace9c8c3c9b63ea.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "interestRateStrategy": {
        "from": "0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A",
        "to": "0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "interestRateStrategy": {
        "from": "0x64163263753A9610a391A5D0276ae94B0d42fB75",
        "to": "0x992ff76913Db79eCA51666D1e09b4F5Cf078dF7D"
      }
    }
  },
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "address": {
        "from": "0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A",
        "to": "0xA802E6c96572f4C7efbf1e611d161CF63ad74Ef9"
      },
      "baseStableBorrowRate": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "address": {
        "from": "0x64163263753A9610a391A5D0276ae94B0d42fB75",
        "to": "0x992ff76913Db79eCA51666D1e09b4F5Cf078dF7D"
      },
      "baseStableBorrowRate": {
        "from": "140000000000000000000000000",
        "to": "110000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      }
    }
  }
}
```