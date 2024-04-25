## Reserve changes

### Reserve altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 75 % |
| liquidationThreshold | 79 % | 78 % |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 75 % |
| liquidationThreshold | 79 % | 78 % |


## Raw diff

```json
{
  "reserves": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7800
      },
      "ltv": {
        "from": 7600,
        "to": 7500
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7800
      },
      "ltv": {
        "from": 7600,
        "to": 7500
      }
    }
  }
}
```