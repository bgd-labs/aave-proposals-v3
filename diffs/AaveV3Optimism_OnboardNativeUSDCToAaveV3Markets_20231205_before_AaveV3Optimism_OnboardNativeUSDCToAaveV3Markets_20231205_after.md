## Reserve changes

### Reserve altered

#### USDC ([0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://explorer.optimism.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80 % | 77 % |
| liquidationThreshold | 85 % | 80 % |
| interestRateStrategy | [0x5eE947d920643cCd3e2c54eAAd8F260FC8Add3b4](https://explorer.optimism.io/address/0x5eE947d920643cCd3e2c54eAAd8F260FC8Add3b4) | [0xB57Ff919A953424d6B143ABfD6740A225eab953e](https://explorer.optimism.io/address/0xB57Ff919A953424d6B143ABfD6740A225eab953e) |
| variableRateSlope1 | 3.5 % | 5 % |
| baseStableBorrowRate | 4.5 % | 6 % |
| interestRate | ![before](/.assets/d89ecf5f1ccbeb07b104da02d99f5a5862da4efa.svg) | ![after](/.assets/642e6998ba4d8e6257bd1b98e572a781ba6d9958.svg) |

#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://explorer.optimism.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 25,000,000 USDC | 18,000,000 USDC |
| borrowCap | 20,000,000 USDC | 15,500,000 USDC |
| interestRateStrategy | [0x3832311560d3B457E9cC35e5b8e06EB167D8c17D](https://explorer.optimism.io/address/0x3832311560d3B457E9cC35e5b8e06EB167D8c17D) | [0x769EbC5106bF09D9A665CCb691e1907612b57F16](https://explorer.optimism.io/address/0x769EbC5106bF09D9A665CCb691e1907612b57F16) |
| variableRateSlope1 | 5 % | 7 % |
| variableRateSlope2 | 60 % | 80 % |
| baseStableBorrowRate | 6 % | 8 % |
| interestRate | ![before](/.assets/2054bce529b78cac463f95dc79fc18b65a0c1f44.svg) | ![after](/.assets/08d9252b4f8f8c9e59638a9a35a34e736f126166.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85": {
      "interestRateStrategy": {
        "from": "0x5eE947d920643cCd3e2c54eAAd8F260FC8Add3b4",
        "to": "0xB57Ff919A953424d6B143ABfD6740A225eab953e"
      },
      "liquidationThreshold": {
        "from": 8500,
        "to": 8000
      },
      "ltv": {
        "from": 8000,
        "to": 7700
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "borrowCap": {
        "from": 20000000,
        "to": 15500000
      },
      "interestRateStrategy": {
        "from": "0x3832311560d3B457E9cC35e5b8e06EB167D8c17D",
        "to": "0x769EbC5106bF09D9A665CCb691e1907612b57F16"
      },
      "supplyCap": {
        "from": 25000000,
        "to": 18000000
      }
    }
  },
  "strategies": {
    "0x769EbC5106bF09D9A665CCb691e1907612b57F16": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "5000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    },
    "0xB57Ff919A953424d6B143ABfD6740A225eab953e": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "60000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "35000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```