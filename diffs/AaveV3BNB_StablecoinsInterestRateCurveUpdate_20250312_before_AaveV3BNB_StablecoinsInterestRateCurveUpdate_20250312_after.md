## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x2d97f8fa96886fd923c065f5457f9ddd494e3877": {
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
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x75a19152562baa2463adfc9e32b10635714b7aec97670f598eb1da6e2a56b10f": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xd4187960d8e14595954dfc8de3270472baacfaaf992e341d5e2ea3c02ecc7e98": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9e255f9d061405769abb2b583c9b2c4368b482b9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593adb": {
          "previousValue": "0x00000000001f5b3089c04497eecd4a6d00000000037bb1fa482b5a08480e4d10",
          "newValue": "0x000000000017fa706c8bd7a1073774cf00000000037bb1fab410a77b6ad00cf0"
        },
        "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593adc": {
          "previousValue": "0x0000000000342bc4ad6e0060ccfba877000000000391b768114f6842b15450ce",
          "newValue": "0x000000000027e53c0ed1fad0e848e04b000000000391b768c9431f3e8dad96da"
        },
        "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593add": {
          "previousValue": "0x00000000000000000000050067d1c13d00000000000000000b78d6f1322298b3",
          "newValue": "0x00000000000000000000050067d1c14300000000000000000b78d6f1322298b3"
        },
        "0x01e77548dd65884cfab89fc0b4723cfde5b99f1ffaee11e7a06bfd4142593ae2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000095ae2663555652eca",
          "newValue": "0x0000000000000000000000000000000000000000000000095b3e251478188315"
        },
        "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6a": {
          "previousValue": "0x00000000001a3282b04e37555981b7ed000000000379accd60c73ae3656ead4e",
          "newValue": "0x00000000001408848a999de77296f076000000000379ad1b32754a4e75a205dc"
        },
        "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6b": {
          "previousValue": "0x00000000002fafbe77eb8aa64920f69900000000038fd896a9d503d1ba13113a",
          "newValue": "0x0000000000247757add6a2600187c9c100000000038fd927d8a744a54fdcf55d"
        },
        "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e6c": {
          "previousValue": "0x00000000000000000000040067d1bc1200000000000000000000000000000000",
          "newValue": "0x00000000000000000000040067d1c14300000000000000000000000000000000"
        },
        "0x6022ee0e2dbef67a625ebdf9df1fcd22d35d1555aca42bf2783f31dbd8ac7e71": {
          "previousValue": "0x000000000000000000000000000000000000000000000003094ed6c7a57f9c06",
          "newValue": "0x000000000000000000000000000000000000000000000003236744271028b9a6"
        },
        "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032a": {
          "previousValue": "0x0000000000259f3faf24015c000fd21a0000000003793773554ff259cda18d0b",
          "newValue": "0x00000000001cc51b3c95f9e86a02411600000000037938e5baacb97a5ef76114"
        },
        "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032b": {
          "previousValue": "0x00000000003c9ce3e6e2d68a32b8798700000000039be32a1cd7736619ac8244",
          "newValue": "0x00000000002e59e26d180f679a7be2b600000000039be596209c0b119289acf4"
        },
        "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b032c": {
          "previousValue": "0x00000000000000000000060067d1b00c000000000000000003bbcf02f86a79f6",
          "newValue": "0x00000000000000000000060067d1c143000000000000000003bbcf02f86a79f6"
        },
        "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b0331": {
          "previousValue": "0x00000000000000000000000000000000000000000000000297ac7ed3a0fcbc71",
          "newValue": "0x000000000000000000000000000000000000000000000002dd4099d66260df16"
        }
      }
    },
    "0xbdfa4bdd705e02a2da357ddd2e543ec654529940": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4f8c9d329171a3577e6beb939d329b1f26da4c7a51f25bbe134c866f0feee945": {
          "previousValue": "0x0067d1c142000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c142000000000003000000000000000000000000000000000000000000"
        },
        "0x4f8c9d329171a3577e6beb939d329b1f26da4c7a51f25bbe134c866f0feee946": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c300000000000067d1c143"
        }
      }
    },
    "0xcdbbed5606d9c5c98eeedd67933991dc17f0c68d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
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
```