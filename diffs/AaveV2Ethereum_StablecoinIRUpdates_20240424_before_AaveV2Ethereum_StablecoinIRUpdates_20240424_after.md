## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xBbE678b3E03E885B477f97af40671c1182582aD4](https://etherscan.io/address/0xBbE678b3E03E885B477f97af40671c1182582aD4) | [0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15](https://etherscan.io/address/0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/010633e355dbf154c1151f809618bd82bf6c78f6.svg) | ![after](/.assets/3ba5c7c483188de945c201d26fa5252c67e5caac.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xfA4dEC495522ea25f617113fA0633a5BeCD4918E](https://etherscan.io/address/0xfA4dEC495522ea25f617113fA0633a5BeCD4918E) | [0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505](https://etherscan.io/address/0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/4048416bedf0808a47706e49a9f98ee64701623a.svg) | ![after](/.assets/51f81c539b7291d13a067450c9db577fc40d9573.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x13828736b5e2CcF7811A2012ff9eB3e685a815b2](https://etherscan.io/address/0x13828736b5e2CcF7811A2012ff9eB3e685a815b2) | [0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA](https://etherscan.io/address/0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA) |
| variableRateSlope1 | 12 % | 9 % |
| interestRate | ![before](/.assets/223a1aac9347ec68266ca4077ea5d03b73ca9e05.svg) | ![after](/.assets/a47eecb09dc71d5549ab7cbd4807cd98ad151613.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0xBbE678b3E03E885B477f97af40671c1182582aD4",
        "to": "0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0xfA4dEC495522ea25f617113fA0633a5BeCD4918E",
        "to": "0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0x13828736b5e2CcF7811A2012ff9eB3e685a815b2",
        "to": "0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA"
      }
    }
  },
  "strategies": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0xBbE678b3E03E885B477f97af40671c1182582aD4",
        "to": "0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0xfA4dEC495522ea25f617113fA0633a5BeCD4918E",
        "to": "0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0x13828736b5e2CcF7811A2012ff9eB3e685a815b2",
        "to": "0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    }
  }
}
```