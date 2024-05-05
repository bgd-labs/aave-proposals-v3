## Reserve changes

### Reserve altered

#### UNI ([0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984](https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 14 % | 0.01 % |


#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 72 % | 68 % |


#### MKR ([0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 14 % | 10 % |


#### CRV ([0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 14 % | 0.01 % |


#### ZRX ([0xE41d2489571d322189246DaFA5ebDe1F4699F498](https://etherscan.io/address/0xE41d2489571d322189246DaFA5ebDe1F4699F498))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 8 % | 5 % |


## Raw diff

```json
{
  "reserves": {
    "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984": {
      "liquidationThreshold": {
        "from": 1400,
        "to": 1
      }
    },
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "liquidationThreshold": {
        "from": 7200,
        "to": 6800
      }
    },
    "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2": {
      "liquidationThreshold": {
        "from": 1400,
        "to": 1000
      }
    },
    "0xD533a949740bb3306d119CC777fa900bA034cd52": {
      "liquidationThreshold": {
        "from": 1400,
        "to": 1
      }
    },
    "0xE41d2489571d322189246DaFA5ebDe1F4699F498": {
      "liquidationThreshold": {
        "from": 800,
        "to": 500
      }
    }
  }
}
```