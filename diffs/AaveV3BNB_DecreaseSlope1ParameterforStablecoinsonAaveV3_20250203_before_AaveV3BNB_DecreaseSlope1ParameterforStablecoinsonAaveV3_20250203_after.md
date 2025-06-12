## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x2d97f8fa96886fd923c065f5457f9ddd494e3877": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x67bdf23c7fce7c65ff7415ba3f2520b45d6f9584": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x6807dc923806fe8fd134338eabca509979a7e0cb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x777fba024ba1228fda76149a4ff8b23475ed057d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x4078230474dd5bdc247bf09d8b5fb987f142ad094173e6813c24e122b1c3d673": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0x75a19152562baa2463adfc9e32b10635714b7aec97670f598eb1da6e2a56b10f": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xd4187960d8e14595954dfc8de3270472baacfaaf992e341d5e2ea3c02ecc7e98": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xb769c2a9259b3eedaf120d8643c4c7eae977fd7f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593adb": {
            "previousValue": "0x000000000031c19b312945b64452df05000000000377580e2278db167f8a288c",
            "newValue": "0x0000000000291a5f70a50908558f0c8e000000000377581e1b74765cc03dd1d9"
          },
          "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593adc": {
            "previousValue": "0x00000000004c71154219164507f8d4f700000000038ab3dda736482dca38c721",
            "newValue": "0x00000000003f25c421a3d680ab64da8800000000038ab3f6ba439b9fcbc10708"
          },
          "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593add": {
            "previousValue": "0x00000000000000000000050067a1355e00000000000000000000000000000000",
            "newValue": "0x00000000000000000000050067a135ee00000000000000000000000000000000"
          },
          "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593ae2": {
            "previousValue": "0x000000000000000000000000000000000000000000000052b42293396eab9f60",
            "newValue": "0x000000000000000000000000000000000000000000000052c182d9d980296d1d"
          },
          "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6a": {
            "previousValue": "0x00000000002b92ce3ee41ee0a4086c06000000000375dd90086b4569dec6c8a2",
            "newValue": "0x000000000023fedeca06a9db163b87e9000000000375de4706a69c7db82b3ef8"
          },
          "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6b": {
            "previousValue": "0x00000000004788eb39543e967cdadbbc0000000003894f61c597e416ff31b32f",
            "newValue": "0x00000000003b1816b4998859632ea2580000000003895094c9ae62455b6d62d2"
          },
          "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6c": {
            "previousValue": "0x00000000000000000000040067a12e8f00000000000000000000000000000000",
            "newValue": "0x00000000000000000000040067a135ee00000000000000000000000000000000"
          },
          "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e71": {
            "previousValue": "0x0000000000000000000000000000000000000000000000141c04d1f2a8ef491f",
            "newValue": "0x00000000000000000000000000000000000000000000001444d8ff6b21f6c600"
          },
          "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032a": {
            "previousValue": "0x0000000000173164dd1887a97400f4aa0000000003751e3589a0add5fb4885c4",
            "newValue": "0x00000000001328d8ba9ddbf0304012430000000003751f147ddac9b300845f9e"
          },
          "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032b": {
            "previousValue": "0x0000000000375b0235d75c0f34afd8680000000003945782f760b064ab1241d9",
            "newValue": "0x00000000002dba895ab78cabbb490d6600000000039459a9dfa4d38ddba0a8a6"
          },
          "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032c": {
            "previousValue": "0x00000000000000000000060067a1250b00000000000000000000000000000000",
            "newValue": "0x00000000000000000000060067a135ee00000000000000000000000000000000"
          },
          "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b0331": {
            "previousValue": "0x00000000000000000000000000000000000000000000000f826e6367ec069891",
            "newValue": "0x00000000000000000000000000000000000000000000000fc37f8c2059223ea5"
          }
        }
      },
      "0xbdfa4bdd705e02a2da357ddd2e543ec654529940": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xe0033292d8349127dd6b6fa9c34f6f3d290151b2785dbcbf18fa2c3985d1f743": {
            "previousValue": "0x0067a135ed000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135ed000000000003000000000000000000000000000000000000000000"
          },
          "0xe0033292d8349127dd6b6fa9c34f6f3d290151b2785dbcbf18fa2c3985d1f744": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6e00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6e00000000000067a135ee"
          }
        }
      },
      "0xcdbbed5606d9c5c98eeedd67933991dc17f0c68d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xe5ef2dd06755a97e975f7e282f828224f2c3e627": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xe628b8a123e6037f1542e662b9f55141a16945c8": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xf8bb2be50647447fb355e3a77b81be4db64107cd": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xff75b6da14ffbbfd355daf7a2731456b3562ba6d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```