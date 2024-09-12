## Reserve changes

### Reserve altered

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66.5 % | 65.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/0b207451ec38eb4a7c392a3d9c43ab7e77836211.svg) | ![after](/.assets/b27664e2bba5abe215b912a5fe562266fbcca6fd.svg) |

#### jEUR ([0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c](https://polygonscan.com/address/0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 66.5 % | 65.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/0b207451ec38eb4a7c392a3d9c43ab7e77836211.svg) | ![after](/.assets/b27664e2bba5abe215b912a5fe562266fbcca6fd.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/938dd0b29af2a7ddfe8cbd0de959c4c24b5ea9ef.svg) | ![after](/.assets/c9c9093a6438fd3f547513a97d88d37319d11c5d.svg) |

#### EURA ([0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4](https://polygonscan.com/address/0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/fa2d9144d6937d795a23d4864f7e30b8efbfa233.svg) | ![after](/.assets/796680e4254d0e06db0b26ecfb8ab8fb3d9d298a.svg) |

#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/fa2d9144d6937d795a23d4864f7e30b8efbfa233.svg) | ![after](/.assets/796680e4254d0e06db0b26ecfb8ab8fb3d9d298a.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/938dd0b29af2a7ddfe8cbd0de959c4c24b5ea9ef.svg) | ![after](/.assets/c9c9093a6438fd3f547513a97d88d37319d11c5d.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "maxVariableBorrowRate": {
        "from": "665000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c": {
      "maxVariableBorrowRate": {
        "from": "665000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
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