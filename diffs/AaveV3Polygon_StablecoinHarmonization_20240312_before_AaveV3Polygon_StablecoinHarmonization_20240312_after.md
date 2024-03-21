## Reserve changes

### Reserve altered

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 25 % |


#### BAL ([0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 45 % | 42 % |


#### agEUR ([0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4](https://polygonscan.com/address/0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |


#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 20 % |


## Raw diff

```json
{
  "reserves": {
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      }
    },
    "0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3": {
      "liquidationThreshold": {
        "from": 4500,
        "to": 4200
      }
    },
    "0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4": {
      "isFrozen": {
        "from": false,
        "to": true
      }
    },
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    }
  }
}
```