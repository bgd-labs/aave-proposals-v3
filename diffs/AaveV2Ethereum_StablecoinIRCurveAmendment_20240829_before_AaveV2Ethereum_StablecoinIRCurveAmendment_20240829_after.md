## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xffeae1Bf7ddc089b8820B223220d76E537bf058E](https://etherscan.io/address/0xffeae1Bf7ddc089b8820B223220d76E537bf058E) | [0xA939B1f36E9a14B044B8149933184a18E0dFC17D](https://etherscan.io/address/0xA939B1f36E9a14B044B8149933184a18E0dFC17D) |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/5f6eef0835ac19ee0c898e4b760d8970954291bf.svg) | ![after](/.assets/84b8d94b33b4219344f3a5409640bc44cb6c5979.svg) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60](https://etherscan.io/address/0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60) | [0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f](https://etherscan.io/address/0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f) |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/23e67c7d46dd80f36d580b243c5716c84080a34f.svg) | ![after](/.assets/50f09bd59fd9d937b0095494daa4eb1e9bba074f.svg) |

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910](https://etherscan.io/address/0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910) | [0xa8850b94E4A0B881c3b08aE065D189D87F34F175](https://etherscan.io/address/0xa8850b94E4A0B881c3b08aE065D189D87F34F175) |
| variableRateSlope1 | 6.5 % | 5.5 % |
| interestRate | ![before](/.assets/8f48c9478437c54125028a1d71100121cc58dcd0.svg) | ![after](/.assets/730ec9b7468e77521a3de2fca047c1cbdf97cd95.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0xffeae1Bf7ddc089b8820B223220d76E537bf058E",
        "to": "0xA939B1f36E9a14B044B8149933184a18E0dFC17D"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "interestRateStrategy": {
        "from": "0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60",
        "to": "0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "interestRateStrategy": {
        "from": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910",
        "to": "0xa8850b94E4A0B881c3b08aE065D189D87F34F175"
      }
    }
  },
  "strategies": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "address": {
        "from": "0xffeae1Bf7ddc089b8820B223220d76E537bf058E",
        "to": "0xA939B1f36E9a14B044B8149933184a18E0dFC17D"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "address": {
        "from": "0xF1722FBCAc1C49bA57a77c3F4373A4bb86a46e60",
        "to": "0x6a8C8119b2BA9460162B8C999f5A8C84f28a033f"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "address": {
        "from": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910",
        "to": "0xa8850b94E4A0B881c3b08aE065D189D87F34F175"
      },
      "variableRateSlope1": {
        "from": "65000000000000000000000000",
        "to": "55000000000000000000000000"
      }
    }
  }
}
```