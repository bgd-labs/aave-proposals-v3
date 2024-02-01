## Reserve changes

### Reserve altered

#### UNI ([0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984](https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 20 % | 14 % |


#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 74 % | 72 % |


#### MKR ([0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 18 % | 14 % |


#### ENS ([0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72](https://etherscan.io/address/0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 24 % | 0.05 % |


#### CRV ([0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 18 % | 14 % |


#### ZRX ([0xE41d2489571d322189246DaFA5ebDe1F4699F498](https://etherscan.io/address/0xE41d2489571d322189246DaFA5ebDe1F4699F498))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 12 % | 8 % |


## Raw diff

```json
{
  "reserves": {
    "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984": {
      "liquidationThreshold": {
        "from": 2000,
        "to": 1400
      }
    },
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "liquidationThreshold": {
        "from": 7400,
        "to": 7200
      }
    },
    "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2": {
      "liquidationThreshold": {
        "from": 1800,
        "to": 1400
      }
    },
    "0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72": {
      "liquidationThreshold": {
        "from": 2400,
        "to": 5
      }
    },
    "0xD533a949740bb3306d119CC777fa900bA034cd52": {
      "liquidationThreshold": {
        "from": 1800,
        "to": 1400
      }
    },
    "0xE41d2489571d322189246DaFA5ebDe1F4699F498": {
      "liquidationThreshold": {
        "from": 1200,
        "to": 800
      }
    }
  }
}
```