## Reserve changes

### Reserve altered

#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 68 % | 65 % |


#### ZRX ([0xE41d2489571d322189246DaFA5ebDe1F4699F498](https://etherscan.io/address/0xE41d2489571d322189246DaFA5ebDe1F4699F498))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 5 % | 0.01 % |


## Raw diff

```json
{
  "reserves": {
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "liquidationThreshold": {
        "from": 6800,
        "to": 6500
      }
    },
    "0xE41d2489571d322189246DaFA5ebDe1F4699F498": {
      "liquidationThreshold": {
        "from": 500,
        "to": 1
      }
    }
  }
}
```