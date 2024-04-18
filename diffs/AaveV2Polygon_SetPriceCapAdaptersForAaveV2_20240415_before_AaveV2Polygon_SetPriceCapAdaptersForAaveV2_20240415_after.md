## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xefb7e6be8356cCc6827799B6A7348eE674A80EaE](https://polygonscan.com/address/0xefb7e6be8356cCc6827799B6A7348eE674A80EaE) | [0xB611AA5E98112C7c3711Ca3a5187dC025B83C8e4](https://polygonscan.com/address/0xB611AA5E98112C7c3711Ca3a5187dC025B83C8e4) |
| oracleDescription | USDC / ETH | Capped USDC / USD / ETH |
| oracleLatestAnswer | 0.000335503089164054 | 0.000331870961747146 |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xFC539A559e170f848323e19dfD66007520510085](https://polygonscan.com/address/0xFC539A559e170f848323e19dfD66007520510085) | [0x08EDd9E1DF3b0b8498864C60a2FD6cDb13148885](https://polygonscan.com/address/0x08EDd9E1DF3b0b8498864C60a2FD6cDb13148885) |
| oracleDescription | DAI / ETH | Capped DAI / USD / ETH |
| oracleLatestAnswer | 0.00033274601 | 0.000331847400086945 |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xf9d5AAC6E5572AEFa6bd64108ff86a222F69B64d](https://polygonscan.com/address/0xf9d5AAC6E5572AEFa6bd64108ff86a222F69B64d) | [0xf840c80932908EF206056dF0882bC595e7150607](https://polygonscan.com/address/0xf840c80932908EF206056dF0882bC595e7150607) |
| oracleDescription | USDT / ETH | Capped USDT / USD / ETH |
| oracleLatestAnswer | 0.000333898735191591 | 0.000331947288252023 |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "oracle": {
        "from": "0xefb7e6be8356cCc6827799B6A7348eE674A80EaE",
        "to": "0xB611AA5E98112C7c3711Ca3a5187dC025B83C8e4"
      },
      "oracleDescription": {
        "from": "USDC / ETH",
        "to": "Capped USDC / USD / ETH"
      },
      "oracleLatestAnswer": {
        "from": 335503089164054,
        "to": 331870961747146
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "oracle": {
        "from": "0xFC539A559e170f848323e19dfD66007520510085",
        "to": "0x08EDd9E1DF3b0b8498864C60a2FD6cDb13148885"
      },
      "oracleDescription": {
        "from": "DAI / ETH",
        "to": "Capped DAI / USD / ETH"
      },
      "oracleLatestAnswer": {
        "from": 332746010000000,
        "to": 331847400086945
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "oracle": {
        "from": "0xf9d5AAC6E5572AEFa6bd64108ff86a222F69B64d",
        "to": "0xf840c80932908EF206056dF0882bC595e7150607"
      },
      "oracleDescription": {
        "from": "USDT / ETH",
        "to": "Capped USDT / USD / ETH"
      },
      "oracleLatestAnswer": {
        "from": 333898735191591,
        "to": 331947288252023
      }
    }
  }
}
```