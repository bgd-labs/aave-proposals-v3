## Reserve changes

### Reserves altered

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | true | false |
| supplyCap | 20,000,000 sUSD | 7,000,000 sUSD |
| borrowCap | 13,000,000 sUSD | 5,600,000 sUSD |
| ltv | 0 % | 60 % |
| liquidationThreshold | 75 % | 70 % |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "liquidationThreshold": {
        "from": 9500,
        "to": 9300
      },
      "ltv": {
        "from": 9300,
        "to": 9000
      }
    }
  },
  "reserves": {
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "borrowCap": {
        "from": 13000000,
        "to": 5600000
      },
      "isFrozen": {
        "from": true,
        "to": false
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 7000
      },
      "ltv": {
        "from": 0,
        "to": 6000
      },
      "supplyCap": {
        "from": 20000000,
        "to": 7000000
      }
    }
  }
}
```