## Reserve changes

### Reserves altered

#### AMPL ([0xD46bA6D942050d489DBd938a2C909A5d5039A161](https://etherscan.io/address/0xD46bA6D942050d489DBd938a2C909A5d5039A161))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 99 % | 99.9 % |
| interestRateStrategy | [0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5](https://etherscan.io/address/0xB2D822cAdb9040F3164829BC34e41a93cA3E01e5) | [0xa324C768Bdd002b3387CE1c691A549268f63250b](https://etherscan.io/address/0xa324C768Bdd002b3387CE1c691A549268f63250b) |
| variableRateSlope2 | 300 % | 0 % |
| interestRate | ![before](/.assets/476ff20939889da0d22c72400271f9f8e240b721.svg) | ![after](/.assets/f3e4c54fb5d844c997b8b4b37ce42b85783857eb.svg) |

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
    "0xa324C768Bdd002b3387CE1c691A549268f63250b": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "200000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": 0,
        "variableRateSlope2": 0
      }
    }
  }
}
```