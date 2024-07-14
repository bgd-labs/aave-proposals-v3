## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15](https://etherscan.io/address/0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15) | [0xffeae1Bf7ddc089b8820B223220d76E537bf058E](https://etherscan.io/address/0xffeae1Bf7ddc089b8820B223220d76E537bf058E) |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](/.assets/3ba5c7c483188de945c201d26fa5252c67e5caac.svg) | ![after](/.assets/128f17e58b8c5df5af7f975b363bf1270ccb5bcc.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505](https://etherscan.io/address/0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505) | [0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60](https://etherscan.io/address/0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60) |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](/.assets/51f81c539b7291d13a067450c9db577fc40d9573.svg) | ![after](/.assets/500ca9c909d05986de4d39e94e8f45f11b1bcdd1.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA](https://etherscan.io/address/0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA) | [0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910](https://etherscan.io/address/0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910) |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](/.assets/a47eecb09dc71d5549ab7cbd4807cd98ad151613.svg) | ![after](/.assets/77d4a2faf4436e62f14b7aa864bc17ee7907a603.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15",
        "to": "0xffeae1Bf7ddc089b8820B223220d76E537bf058E"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505",
        "to": "0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA",
        "to": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910"
      }
    }
  },
  "strategies": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0xeA3e03e3d3FFaF0724Cf2a2A2E41f8fF2F443c15",
        "to": "0xffeae1Bf7ddc089b8820B223220d76E537bf058E"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0xcA52f53A926d2fa200ED9d98C6D3d9dC3ed63505",
        "to": "0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0xC599aB00AaF46901EA8c31dFB4c5363b111D2FeA",
        "to": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  }
}
```