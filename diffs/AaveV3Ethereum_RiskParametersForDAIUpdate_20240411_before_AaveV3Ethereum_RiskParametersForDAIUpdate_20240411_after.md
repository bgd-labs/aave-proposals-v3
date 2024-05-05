## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 63 % |
| liquidationThreshold | 79 % | 77 % |


#### sDAI ([0x83F20F44975D03b1b09e64809B757c47f942BEeA](https://etherscan.io/address/0x83F20F44975D03b1b09e64809B757c47f942BEeA))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 63 % |
| liquidationThreshold | 79 % | 77 % |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7700
      },
      "ltv": {
        "from": 7600,
        "to": 6300
      }
    },
    "0x83F20F44975D03b1b09e64809B757c47f942BEeA": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7700
      },
      "ltv": {
        "from": 7600,
        "to": 6300
      }
    }
  }
}
```