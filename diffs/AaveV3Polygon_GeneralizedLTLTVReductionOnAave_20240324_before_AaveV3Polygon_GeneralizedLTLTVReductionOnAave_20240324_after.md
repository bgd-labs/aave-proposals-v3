## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 81 % | 79 % |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "liquidationThreshold": {
        "from": 8100,
        "to": 7900
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
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