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
| oracle | [0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2](https://gnosisscan.io/address/0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2) | [0x620424f393dD413c2F8Dc2980905c4daa3619e61](https://gnosisscan.io/address/0x620424f393dD413c2F8Dc2980905c4daa3619e61) |
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
        "to": "0x620424f393dD413c2F8Dc2980905c4daa3619e61"
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
  },
  "raw": {
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc5": {
          "previousValue": "0x00682606a6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682606a6000000000003000000000000000000000000000000000000000000"
        },
        "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc6": {
          "previousValue": "0x000000000000000000093a8000000000000068542b2700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068542b27000000000000682606a7"
        }
      }
    },
    "0xeb0a051be10228213baeb449db63719d6742f7c4": {
      "label": "AaveV3Gnosis.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x7a707fb5a667d8fcd75b759571976d14d8065a51b95e6ef656e3cfbef6769e8d": {
          "previousValue": "0x0000000000000000000000001d0f881ce1a646e2f27dec3c57fa056cb838bcc2",
          "newValue": "0x000000000000000000000000620424f393dd413c2f8dc2980905c4daa3619e61"
        },
        "0x80e20a7b385f8d2ac1c3ea1e98ad1ac1729cb251c634a7724657086e5970e994": {
          "previousValue": "0x0000000000000000000000000a2d05bc646c65a029e602c257dfa14adf8bfad2",
          "newValue": "0x0000000000000000000000001450c4be9dd66889cddab77e5947b6166acbfae2"
        },
        "0xc0963972186d8ee23ea5bd91c3313dea1a6697d1afafd6c1ccd165b3e87dd630": {
          "previousValue": "0x0000000000000000000000000a2d05bc646c65a029e602c257dfa14adf8bfad2",
          "newValue": "0x0000000000000000000000001450c4be9dd66889cddab77e5947b6166acbfae2"
        },
        "0xfd6743ac1840b81c4bd353cd87b222fd0308e2c0fc9c7e4714a6cdbf1301492c": {
          "previousValue": "0x000000000000000000000000e5269ef0ce04e509e8134624c7bf043b21e10897",
          "newValue": "0x0000000000000000000000007443afe82986d7475cea0c5b04c6f1581fdace87"
        }
      }
    }
  }
}
```