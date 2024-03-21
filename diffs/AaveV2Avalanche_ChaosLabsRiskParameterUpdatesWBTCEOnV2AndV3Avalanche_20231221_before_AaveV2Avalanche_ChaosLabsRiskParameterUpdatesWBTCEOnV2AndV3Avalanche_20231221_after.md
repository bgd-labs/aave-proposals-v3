## Reserve changes

### Reserves altered

#### WBTC.e ([0x50b7545627a5162F82A992c33b87aDc75187B218](https://snowscan.xyz/address/0x50b7545627a5162F82A992c33b87aDc75187B218))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 60 % | 0 % |
| liquidationThreshold | 75 % | 70 % |


## Raw diff

```json
{
  "reserves": {
    "0x50b7545627a5162F82A992c33b87aDc75187B218": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 7000
      },
      "ltv": {
        "from": 6000,
        "to": 0
      }
    }
  }
}
```