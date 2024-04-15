## Reserve changes

### Reserves altered

#### AMPL ([0xD46bA6D942050d489DBd938a2C909A5d5039A161](https://etherscan.io/address/0xD46bA6D942050d489DBd938a2C909A5d5039A161))

| description | value before | value after |
| --- | --- | --- |
| aTokenImpl | [0x6fBC3BE5ee5273598d1491D41bB45F6d05a7541A](https://etherscan.io/address/0x6fBC3BE5ee5273598d1491D41bB45F6d05a7541A) | [0x1F32642b216d19DAEb1531862647195a626F4193](https://etherscan.io/address/0x1F32642b216d19DAEb1531862647195a626F4193) |
| interestRateStrategy | [0xa324C768Bdd002b3387CE1c691A549268f63250b](https://etherscan.io/address/0xa324C768Bdd002b3387CE1c691A549268f63250b) | [0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5](https://etherscan.io/address/0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5) |
| variableRateSlope2 | 0 % | 300 % |
| interestRate | ![before](/.assets/b066e7c9810c83ee1ab3a3bfa76a5f71483e3a32.svg) | ![after](/.assets/505a717515dde97057a00382ab87b2fbe4243854.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xD46bA6D942050d489DBd938a2C909A5d5039A161": {
      "aTokenImpl": {
        "from": "0x6fBC3BE5ee5273598d1491D41bB45F6d05a7541A",
        "to": "0x1F32642b216d19DAEb1531862647195a626F4193"
      },
      "interestRateStrategy": {
        "from": "0xa324C768Bdd002b3387CE1c691A549268f63250b",
        "to": "0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5"
      }
    }
  },
  "strategies": {
    "0xD46bA6D942050d489DBd938a2C909A5d5039A161": {
      "address": {
        "from": "0xa324C768Bdd002b3387CE1c691A549268f63250b",
        "to": "0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5"
      },
      "variableRateSlope2": {
        "from": 0,
        "to": "3000000000000000000000000000"
      }
    }
  }
}
```