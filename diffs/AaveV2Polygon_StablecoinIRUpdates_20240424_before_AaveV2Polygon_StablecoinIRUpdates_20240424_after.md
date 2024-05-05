## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76](https://polygonscan.com/address/0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76) | [0xd9b99ccEe49a285dE83d16e0CEA1b4044e233bBE](https://polygonscan.com/address/0xd9b99ccEe49a285dE83d16e0CEA1b4044e233bBE) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/6f633d9077d080479568e5342fc14c4507401d2f.svg) | ![after](/.assets/5b1e905cd3cb5b406884275c7fd4e64da7878d88.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966](https://polygonscan.com/address/0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966) | [0x964a4edc8009cA560dE2cCe1bA6300d48ecc203e](https://polygonscan.com/address/0x964a4edc8009cA560dE2cCe1bA6300d48ecc203e) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/9566c6dd3a1bea1498b3908b4be8b94c971a839d.svg) | ![after](/.assets/348c235b7a1295a8ce62e07989c483b9365844c2.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x1233847129541c166ad585FaC0727CcBF6cf28eC](https://polygonscan.com/address/0x1233847129541c166ad585FaC0727CcBF6cf28eC) | [0xE66886B0e34Dc1C40B2d7BB1ff9137339648deEa](https://polygonscan.com/address/0xE66886B0e34Dc1C40B2d7BB1ff9137339648deEa) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/ad5d77509bc0670471c898f81b8247410aaa1df4.svg) | ![after](/.assets/da4b864dce1658e918e95d8753964d93049b3e7a.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76",
        "to": "0xd9b99ccEe49a285dE83d16e0CEA1b4044e233bBE"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966",
        "to": "0x964a4edc8009cA560dE2cCe1bA6300d48ecc203e"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0x1233847129541c166ad585FaC0727CcBF6cf28eC",
        "to": "0xE66886B0e34Dc1C40B2d7BB1ff9137339648deEa"
      }
    }
  },
  "strategies": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "address": {
        "from": "0x40648f731198AD8ba5757a0bE5DaDaE034ffCf76",
        "to": "0xd9b99ccEe49a285dE83d16e0CEA1b4044e233bBE"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "address": {
        "from": "0xc4d392a7Bfe01E80A07272F5D8a34D49E9cce966",
        "to": "0x964a4edc8009cA560dE2cCe1bA6300d48ecc203e"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "address": {
        "from": "0x1233847129541c166ad585FaC0727CcBF6cf28eC",
        "to": "0xE66886B0e34Dc1C40B2d7BB1ff9137339648deEa"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    }
  }
}
```