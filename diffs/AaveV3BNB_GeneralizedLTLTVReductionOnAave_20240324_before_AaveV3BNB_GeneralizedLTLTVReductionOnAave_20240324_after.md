## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    }
  }
}
```