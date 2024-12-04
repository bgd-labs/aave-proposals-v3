## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA939B1f36E9a14B044B8149933184a18E0dFC17D](https://etherscan.io/address/0xA939B1f36E9a14B044B8149933184a18E0dFC17D) | [0x7011B47A142E2f462AB10F5bDBc8A478310EB0FD](https://etherscan.io/address/0x7011B47A142E2f462AB10F5bDBc8A478310EB0FD) |
| variableRateSlope1 | 5.5 % | 12.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f](https://etherscan.io/address/0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f) | [0x4e1494475048fa155F1D837B6bD51458bD170f48](https://etherscan.io/address/0x4e1494475048fa155F1D837B6bD51458bD170f48) |
| variableRateSlope1 | 5.5 % | 12.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xa8850b94E4A0B881c3b08aE065D189D87F34F175](https://etherscan.io/address/0xa8850b94E4A0B881c3b08aE065D189D87F34F175) | [0x869eF970878F96c130E14B46B024D2ca18b5b762](https://etherscan.io/address/0x869eF970878F96c130E14B46B024D2ca18b5b762) |
| variableRateSlope1 | 5.5 % | 12.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=1000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=1000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) |

## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0xA939B1f36E9a14B044B8149933184a18E0dFC17D",
        "to": "0x7011B47A142E2f462AB10F5bDBc8A478310EB0FD"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f",
        "to": "0x4e1494475048fa155F1D837B6bD51458bD170f48"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0xa8850b94E4A0B881c3b08aE065D189D87F34F175",
        "to": "0x869eF970878F96c130E14B46B024D2ca18b5b762"
      }
    }
  },
  "strategies": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0xA939B1f36E9a14B044B8149933184a18E0dFC17D",
        "to": "0x7011B47A142E2f462AB10F5bDBc8A478310EB0FD"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f",
        "to": "0x4e1494475048fa155F1D837B6bD51458bD170f48"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0xa8850b94E4A0B881c3b08aE065D189D87F34F175",
        "to": "0x869eF970878F96c130E14B46B024D2ca18b5b762"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "125000000000000000000000000"
      }
    }
  }
}
```