## Reserve changes

### Reserve altered

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2](https://gnosisscan.io/address/0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2) | [0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2](https://gnosisscan.io/address/0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2) |


#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2](https://gnosisscan.io/address/0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2) | [0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2](https://gnosisscan.io/address/0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2) |


#### sDAI ([0xaf204776c7245bF4147c2612BF6e5972Ee483701](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2](https://gnosisscan.io/address/0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2) | [0x38fe17BA2dfF456C6c980dD2227B0abA89FCB105](https://gnosisscan.io/address/0x38fe17BA2dfF456C6c980dD2227B0abA89FCB105) |
| oracleDescription | sDAI/DAI/USD | Capped sDAI / DAI / USD |


#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xE5269eF0CE04E509E8134624c7BF043b21e10897](https://gnosisscan.io/address/0xE5269eF0CE04E509E8134624c7BF043b21e10897) | [0x7443afE82986d7475Cea0c5b04C6F1581fdAce87](https://gnosisscan.io/address/0x7443afE82986d7475Cea0c5b04C6F1581fdAce87) |


## Raw diff

```json
{
  "reserves": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "oracle": {
        "from": "0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2",
        "to": "0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2"
      }
    },
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "oracle": {
        "from": "0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2",
        "to": "0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2"
      }
    },
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "oracle": {
        "from": "0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2",
        "to": "0x38fe17BA2dfF456C6c980dD2227B0abA89FCB105"
      },
      "oracleDescription": {
        "from": "sDAI/DAI/USD",
        "to": "Capped sDAI / DAI / USD"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "oracle": {
        "from": "0xE5269eF0CE04E509E8134624c7BF043b21e10897",
        "to": "0x7443afE82986d7475Cea0c5b04C6F1581fdAce87"
      }
    }
  }
}
```