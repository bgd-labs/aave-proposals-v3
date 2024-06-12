## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xb8975328Aa52c00B9Ec1e11e518C4900f2e6C62a](https://etherscan.io/address/0xb8975328Aa52c00B9Ec1e11e518C4900f2e6C62a) | [0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910](https://etherscan.io/address/0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910) |
| variableRateSlope1 | 3.8 % | 2.7 % |
| interestRate | ![before](/.assets/1b4c8cf52b3cfc10e92a52e04f08a3ec2809eb88.svg) | ![after](/.assets/79f40b1fe490831a58a3b210506bd38f6e7e3ed1.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "interestRateStrategy": {
        "from": "0xb8975328Aa52c00B9Ec1e11e518C4900f2e6C62a",
        "to": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910"
      }
    }
  },
  "strategies": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "address": {
        "from": "0xb8975328Aa52c00B9Ec1e11e518C4900f2e6C62a",
        "to": "0x5A3a8Aa25F0D61eF834Da59B4cD5bC48B8AB9910"
      },
      "variableRateSlope1": {
        "from": "38000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```