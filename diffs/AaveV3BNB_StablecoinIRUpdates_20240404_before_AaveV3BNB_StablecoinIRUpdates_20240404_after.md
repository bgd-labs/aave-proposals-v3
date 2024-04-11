## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xA60d98d1e7C1b5C186c181152AE7412C38ABaC94](https://bscscan.com/address/0xA60d98d1e7C1b5C186c181152AE7412C38ABaC94) | [0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a](https://bscscan.com/address/0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 7 % | 13 % |
| interestRate | ![before](/.assets/9a2d8ed48d646e3c752ce9f8afc7d70cedc3acaf.svg) | ![after](/.assets/36854462871fe9c2159f93144e1db3723476a00a.svg) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x786c9fF899805fa0813C77CD3228C0e857664E78](https://bscscan.com/address/0x786c9fF899805fa0813C77CD3228C0e857664E78) | [0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24](https://bscscan.com/address/0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 7 % | 13 % |
| interestRate | ![before](/.assets/d96c11a19e37534df160331280d004c75b2fc23a.svg) | ![after](/.assets/782488a1b7ee691f80006e3fec1034d79c974a26.svg) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xDFFD9CDd2eC42099D7086Ff76938C111022014D0](https://bscscan.com/address/0xDFFD9CDd2eC42099D7086Ff76938C111022014D0) | [0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86](https://bscscan.com/address/0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 9 % | 15 % |
| interestRate | ![before](/.assets/911a3480b9f792f655a3ba52d4db6447055ff426.svg) | ![after](/.assets/ef55117ceefbc6d6d810e0e5578a4a7e9f292aae.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "interestRateStrategy": {
        "from": "0xA60d98d1e7C1b5C186c181152AE7412C38ABaC94",
        "to": "0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "interestRateStrategy": {
        "from": "0x786c9fF899805fa0813C77CD3228C0e857664E78",
        "to": "0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "interestRateStrategy": {
        "from": "0xDFFD9CDd2eC42099D7086Ff76938C111022014D0",
        "to": "0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86"
      }
    }
  },
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "address": {
        "from": "0xA60d98d1e7C1b5C186c181152AE7412C38ABaC94",
        "to": "0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a"
      },
      "baseStableBorrowRate": {
        "from": "70000000000000000000000000",
        "to": "130000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "address": {
        "from": "0x786c9fF899805fa0813C77CD3228C0e857664E78",
        "to": "0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24"
      },
      "baseStableBorrowRate": {
        "from": "70000000000000000000000000",
        "to": "130000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "address": {
        "from": "0xDFFD9CDd2eC42099D7086Ff76938C111022014D0",
        "to": "0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86"
      },
      "baseStableBorrowRate": {
        "from": "90000000000000000000000000",
        "to": "150000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    }
  }
}
```