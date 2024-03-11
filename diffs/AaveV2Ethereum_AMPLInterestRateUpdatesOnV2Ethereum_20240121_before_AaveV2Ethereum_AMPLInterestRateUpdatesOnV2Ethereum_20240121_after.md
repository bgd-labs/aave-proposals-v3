## Reserve changes

### Reserves altered

#### AMPL ([0xD46bA6D942050d489DBd938a2C909A5d5039A161](https://etherscan.io/address/0xD46bA6D942050d489DBd938a2C909A5d5039A161))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 99 % | 99.9 % |
| interestRateStrategy | [0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5](https://etherscan.io/address/0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5) | [0xa324C768Bdd002b3387CE1c691A549268f63250b](https://etherscan.io/address/0xa324C768Bdd002b3387CE1c691A549268f63250b) |
| variableRateSlope2 | 300 % | 0 % |
| interestRate | ![before](/.assets/505a717515dde97057a00382ab87b2fbe4243854.svg) | ![after](/.assets/b066e7c9810c83ee1ab3a3bfa76a5f71483e3a32.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xD46bA6D942050d489DBd938a2C909A5d5039A161": {
      "interestRateStrategy": {
        "from": "0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5",
        "to": "0xa324C768Bdd002b3387CE1c691A549268f63250b"
      },
      "reserveFactor": {
        "from": 9900,
        "to": 9990
      }
    }
  },
  "strategies": {
    "0xD46bA6D942050d489DBd938a2C909A5d5039A161": {
      "address": {
        "from": "0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5",
        "to": "0xa324C768Bdd002b3387CE1c691A549268f63250b"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": 0
      }
    }
  }
}
```