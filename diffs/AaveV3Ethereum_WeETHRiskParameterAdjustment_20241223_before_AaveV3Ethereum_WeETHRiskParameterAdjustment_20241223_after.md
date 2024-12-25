## Reserve changes

### Reserves altered

#### weETH ([0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee](https://etherscan.io/address/0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee))

| description | value before | value after |
| --- | --- | --- |
| ltv | 72.5 % [7250] | 77.5 % [7750] |
| liquidationThreshold | 75 % [7500] | 80 % [8000] |
| liquidationBonus | 7.5 % | 7 % |


## Raw diff

```json
{
  "reserves": {
    "0xCd5fE23C85820F7B72D0926FC9b05b43E359b7ee": {
      "liquidationBonus": {
        "from": 10750,
        "to": 10700
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 8000
      },
      "ltv": {
        "from": 7250,
        "to": 7750
      }
    }
  }
}
```