## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a](https://bscscan.com/address/0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a) | [0xD161Cd855089c33c00F7D30C56452e5B4B8a8599](https://bscscan.com/address/0xD161Cd855089c33c00F7D30C56452e5B4B8a8599) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/36854462871fe9c2159f93144e1db3723476a00a.svg) | ![after](/.assets/189b1048cfb01ad4ab7283e7ad5c7292c5ec484d.svg) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24](https://bscscan.com/address/0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24) | [0x4e4B860383B9C35615f2dc0C3b78F83009A46720](https://bscscan.com/address/0x4e4B860383B9C35615f2dc0C3b78F83009A46720) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 13 % | 10 % |
| interestRate | ![before](/.assets/782488a1b7ee691f80006e3fec1034d79c974a26.svg) | ![after](/.assets/caf98330fb34eb7b2e26a2107766215407decc6a.svg) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86](https://bscscan.com/address/0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86) | [0x6415754564745A50adB508D3B94d10870FE220eb](https://bscscan.com/address/0x6415754564745A50adB508D3B94d10870FE220eb) |
| variableRateSlope1 | 12 % | 9 % |
| baseStableBorrowRate | 15 % | 12 % |
| interestRate | ![before](/.assets/ef55117ceefbc6d6d810e0e5578a4a7e9f292aae.svg) | ![after](/.assets/2fa239413d25864a0b99b39868a3fb49e63010ad.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "interestRateStrategy": {
        "from": "0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a",
        "to": "0xD161Cd855089c33c00F7D30C56452e5B4B8a8599"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "interestRateStrategy": {
        "from": "0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24",
        "to": "0x4e4B860383B9C35615f2dc0C3b78F83009A46720"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "interestRateStrategy": {
        "from": "0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86",
        "to": "0x6415754564745A50adB508D3B94d10870FE220eb"
      }
    }
  },
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "address": {
        "from": "0x7aD646053aE2A184971dc952Cc680a5a5a0cFB8a",
        "to": "0xD161Cd855089c33c00F7D30C56452e5B4B8a8599"
      },
      "baseStableBorrowRate": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "address": {
        "from": "0x0C8c4DbEB2dfA2a3770a54450E9937725D2d3D24",
        "to": "0x4e4B860383B9C35615f2dc0C3b78F83009A46720"
      },
      "baseStableBorrowRate": {
        "from": "130000000000000000000000000",
        "to": "100000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "address": {
        "from": "0xBE6Af4cD3097424BcF5C5BeC3bcEc2017DBCaA86",
        "to": "0x6415754564745A50adB508D3B94d10870FE220eb"
      },
      "baseStableBorrowRate": {
        "from": "150000000000000000000000000",
        "to": "120000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "90000000000000000000000000"
      }
    }
  }
}
```