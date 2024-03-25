## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x2f6390Ef66B8564C715aF6834361621dda38d816](https://etherscan.io/address/0x2f6390Ef66B8564C715aF6834361621dda38d816) | [0x7123138CB4891E9dA927492ce29c8a2eC4aB433A](https://etherscan.io/address/0x7123138CB4891E9dA927492ce29c8a2eC4aB433A) |
| baseVariableBorrowRate | 7.92 % | 13 % |
| interestRate | ![before](/.assets/8f4bd9d9c75dc060033b9ce1f2681ecb81e1b33f.svg) | ![after](/.assets/233ba99310cd56d74318156592f9f533d1e81dde.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x2f6390Ef66B8564C715aF6834361621dda38d816",
        "to": "0x7123138CB4891E9dA927492ce29c8a2eC4aB433A"
      }
    }
  },
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "address": {
        "from": "0x2f6390Ef66B8564C715aF6834361621dda38d816",
        "to": "0x7123138CB4891E9dA927492ce29c8a2eC4aB433A"
      },
      "baseVariableBorrowRate": {
        "from": "79200000000000000000000000",
        "to": "130000000000000000000000000"
      }
    }
  }
}
```