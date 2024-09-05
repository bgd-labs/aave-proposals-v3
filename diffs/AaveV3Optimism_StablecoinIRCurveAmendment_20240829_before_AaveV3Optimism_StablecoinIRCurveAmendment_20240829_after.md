## Reserve changes

### Reserve altered

#### USDC ([0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 69 % | 65.5 % |
| variableRateSlope1 | 9 % | 5.5 % |
| interestRate | ![before](/.assets/c7d643451e15e805ee62a25de69d34fe9bc6ed06.svg) | ![after](/.assets/d7c18f984b71e5f66cebf23ccf14dfe374c5aea5.svg) |

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/0306558ca945fa6bf094ed4dc3c695b090af4273.svg) | ![after](/.assets/951d49070e612a5403fc1f2dd3d2ddc01451b318.svg) |

#### USDT ([0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/b756f485e0a4f77f2e519fa5fdeb44454e53900e.svg) | ![after](/.assets/a6c0aceaa49e1b7b29b7ac5bfdef770548c468d6.svg) |

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 81.5 % | 80.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/b756f485e0a4f77f2e519fa5fdeb44454e53900e.svg) | ![after](/.assets/a6c0aceaa49e1b7b29b7ac5bfdef770548c468d6.svg) |

#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 93.5 % | 92.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/5603d9f34bbf84ceb6513f5e937d7c004e9ee12a.svg) | ![after](/.assets/77e8b4e8ca779dca15dad80d4e2d35851e9936e0.svg) |

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://optimistic.etherscan.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 306.5 % | 305.5 % |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/b1ddd2130611cb445002caf4960064cec7b0692c.svg) | ![after](/.assets/b01ecd05f671ebefee2c3db6c5419cfd8db4cc6d.svg) |

## Raw diff

```json
{
  "strategies": {
    "0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85": {
      "maxVariableBorrowRate": {
        "from": "690000000000000000000000000",
        "to": "655000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0x94b008aA00579c1307B0EF2c499aD98a8ce58e58": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "maxVariableBorrowRate": {
        "from": "815000000000000000000000000",
        "to": "805000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "maxVariableBorrowRate": {
        "from": "935000000000000000000000000",
        "to": "925000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xdFA46478F9e5EA86d57387849598dbFB2e964b02": {
      "maxVariableBorrowRate": {
        "from": "3065000000000000000000000000",
        "to": "3055000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    }
  }
}
```