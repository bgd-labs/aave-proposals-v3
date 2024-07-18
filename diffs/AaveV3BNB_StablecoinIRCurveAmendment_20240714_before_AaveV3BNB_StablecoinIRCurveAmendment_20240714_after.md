## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xD161Cd855089c33c00F7D30C56452e5B4B8a8599](https://bscscan.com/address/0xD161Cd855089c33c00F7D30C56452e5B4B8a8599) | [0xbD77cb6a17cCCca5D8fB634f664E4e4950c9fF89](https://bscscan.com/address/0xbD77cb6a17cCCca5D8fB634f664E4e4950c9fF89) |
| variableRateSlope1 | 9 % | 6.5 % |
| baseStableBorrowRate | 10 % | 7.5 % |
| interestRate | ![before](/.assets/189b1048cfb01ad4ab7283e7ad5c7292c5ec484d.svg) | ![after](/.assets/7f9afb59cb1613d388e0fdf70c60e5558619475e.svg) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x4e4B860383B9C35615f2dc0C3b78F83009A46720](https://bscscan.com/address/0x4e4B860383B9C35615f2dc0C3b78F83009A46720) | [0x77498A4A946e0303E92B78676851f861906e6eF4](https://bscscan.com/address/0x77498A4A946e0303E92B78676851f861906e6eF4) |
| variableRateSlope1 | 9 % | 6.5 % |
| baseStableBorrowRate | 10 % | 7.5 % |
| interestRate | ![before](/.assets/caf98330fb34eb7b2e26a2107766215407decc6a.svg) | ![after](/.assets/71bde6295557afba19d840105a7bbab6e3d05a66.svg) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x6415754564745A50adB508D3B94d10870FE220eb](https://bscscan.com/address/0x6415754564745A50adB508D3B94d10870FE220eb) | [0xcA8a1DC160f6EAF4A9CBf7f94D07895c593A3ee4](https://bscscan.com/address/0xcA8a1DC160f6EAF4A9CBf7f94D07895c593A3ee4) |
| variableRateSlope1 | 9 % | 6.5 % |
| baseStableBorrowRate | 12 % | 9.5 % |
| interestRate | ![before](/.assets/2fa239413d25864a0b99b39868a3fb49e63010ad.svg) | ![after](/.assets/c2c9708f17d73b4a7ad107f9dbb2d7e30cb470e0.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "interestRateStrategy": {
        "from": "0xD161Cd855089c33c00F7D30C56452e5B4B8a8599",
        "to": "0xbD77cb6a17cCCca5D8fB634f664E4e4950c9fF89"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "interestRateStrategy": {
        "from": "0x4e4B860383B9C35615f2dc0C3b78F83009A46720",
        "to": "0x77498A4A946e0303E92B78676851f861906e6eF4"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "interestRateStrategy": {
        "from": "0x6415754564745A50adB508D3B94d10870FE220eb",
        "to": "0xcA8a1DC160f6EAF4A9CBf7f94D07895c593A3ee4"
      }
    }
  },
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "address": {
        "from": "0xD161Cd855089c33c00F7D30C56452e5B4B8a8599",
        "to": "0xbD77cb6a17cCCca5D8fB634f664E4e4950c9fF89"
      },
      "baseStableBorrowRate": {
        "from": "100000000000000000000000000",
        "to": "75000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "address": {
        "from": "0x4e4B860383B9C35615f2dc0C3b78F83009A46720",
        "to": "0x77498A4A946e0303E92B78676851f861906e6eF4"
      },
      "baseStableBorrowRate": {
        "from": "100000000000000000000000000",
        "to": "75000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "address": {
        "from": "0x6415754564745A50adB508D3B94d10870FE220eb",
        "to": "0xcA8a1DC160f6EAF4A9CBf7f94D07895c593A3ee4"
      },
      "baseStableBorrowRate": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  }
}
```