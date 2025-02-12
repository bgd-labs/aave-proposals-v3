## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 50.5 % |
| variableRateSlope1 | 12.5 % | 10.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=105000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=505000000000000000000000000) |

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 61.5 % | 59.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=615000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=595000000000000000000000000) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "505000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "105000000000000000000000000"
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "maxVariableBorrowRate": {
        "from": "615000000000000000000000000",
        "to": "595000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
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
      "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x055aec32800c1157d69820865326b61e91384dc9cf7d6e5d81cc0f17b3c39783": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0x905324f6ac5b7ced7b5c02238633a89b1812b204b997b2d9662e7ee96782f059": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa00000041a000000002328"
          },
          "0xae02604fb37f9c24800df454b9c35a512bc615e51b1cb51c5f01fd34e5087042": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xebab341f8755e41e908427903682896fb6f5295dc81509190f27a340c010d4e0": {
            "previousValue": "0x000000000000000000000000000000000000000013880000047e000000001f40",
            "newValue": "0x00000000000000000000000000000000000000001388000003b6000000001f40"
          },
          "0xfaad2634be2a92239146fcf31c9286389570ac13f367a3736a19ed2cf0ce788c": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0x5d557b07776d12967914379c71a1310e917c7555": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5dfb8c777c19d3cedcdc7398d2eef1fb0b9b05c9": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7d": {
            "previousValue": "0x00000000003181aa5ecc956f10e3e6ab00000000038944a63d4e2b5ac601022b",
            "newValue": "0x000000000028e58d2b20df1a477412d900000000038944b1460bb584ea864616"
          },
          "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7e": {
            "previousValue": "0x00000000004c3fe789550813d8d1539c00000000039bc16109712942b141885f",
            "newValue": "0x00000000003efd23c5c86ee1af93738c00000000039bc17260f07104a667f46e"
          },
          "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7f": {
            "previousValue": "0x00000000000000000000140067a1358e00000000000000000000000000000000",
            "newValue": "0x00000000000000000000140067a135f000000000000000000000000000000000"
          },
          "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d84": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000020e83452",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000020f76ea8"
          },
          "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b40": {
            "previousValue": "0x00000000002887736efb4c83fafd01a80000000003992656f9e771bb22181d5b",
            "newValue": "0x0000000000217b6153ebc926a1db1c9a0000000003992db196a549e3dd84fd5e"
          },
          "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b41": {
            "previousValue": "0x00000000004d9d4cf168f3b2a5be13c80000000003db3c5681b03896cbf43cf7",
            "newValue": "0x0000000000401e1c45bc623d9adc32c10000000003db4b6e8861a5a1667d8964"
          },
          "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b42": {
            "previousValue": "0x000000000000000000000d0067a0e78800000000000000000000000000000000",
            "newValue": "0x000000000000000000000d0067a135f000000000000000000000000000000000"
          },
          "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b47": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000e35",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000000161a"
          },
          "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59f": {
            "previousValue": "0x000000000027cbcf641f68244c14cbee0000000003a8c12cbbe8feb9482421a3",
            "newValue": "0x0000000000216dc2e608de1f2db5d38b0000000003a8c1340a0cfadc281449e9"
          },
          "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a0": {
            "previousValue": "0x00000000005f9fe1e37865ca48cbd42c0000000003f31ffdd0b17584fb91222a",
            "newValue": "0x000000000050531a28a34a42e467f2000000000003f32010c324000a10992eb4"
          },
          "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a1": {
            "previousValue": "0x00000000000000000000020067a135a200000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a135f000000000000000000000000000000000"
          },
          "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a6": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000002df5af9a",
            "newValue": "0x000000000000000000000000000000000000000000000000000000002e056c16"
          },
          "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0d": {
            "previousValue": "0x0000000000345140ffee830c2b22b3fe0000000003c0e1b7b86642be16ce8f9e",
            "newValue": "0x00000000002b37fe0d5370060ada83910000000003c0e1b7f9101bdd3f59c5c9"
          },
          "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0e": {
            "previousValue": "0x00000000004e626834f56572254f4b5b0000000003eccd0750bd1c776f0e285c",
            "newValue": "0x000000000040c098df85b6b05f0a3e2d0000000003eccd07b60c7d07771e2c33"
          },
          "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0f": {
            "previousValue": "0x00000000000000000000050067a135ee00000000000000000000000000000000",
            "newValue": "0x00000000000000000000050067a135f000000000000000000000000000000000"
          },
          "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b14": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000026f9db2e",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000026fa37b6"
          },
          "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f6": {
            "previousValue": "0x00000000002d8ee0b8b3526887dd79b00000000003aca29e8e6a217f3b65d704",
            "newValue": "0x000000000025a28d9dc1d4215c13f5810000000003aca2ad32c0e50bf9c56abe"
          },
          "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f7": {
            "previousValue": "0x0000000000502091a36e47bba08f21910000000003e6cc9da5b7126e38ed1e47",
            "newValue": "0x000000000042312ad5d6db91676f24a10000000003e6ccb8fde97305ddeb4d37"
          },
          "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f8": {
            "previousValue": "0x00000000000000000000000067a1356800000000000000000000000000000000",
            "newValue": "0x00000000000000000000000067a135f000000000000000000000000000000000"
          },
          "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42fd": {
            "previousValue": "0x00000000000000000000000000000000000000000000000dddd0d0c3ed7294e2",
            "newValue": "0x00000000000000000000000000000000000000000000000de5ff783ccc5d3d48"
          }
        }
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x79b5e91037ae441de0d9e6fd3fd85b96b83d4e93": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8145edddf43f50276641b55bd3ad95944510021e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8619d80fb0141ba7f184cbf22fd724116d9f7ffc": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec673": {
            "previousValue": "0x0067a135ef000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135ef000000000003000000000000000000000000000000000000000000"
          },
          "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec674": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a7000000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a7000000000000067a135f0"
          }
        }
      },
      "0xdf7d0e6454db638881302729f5ba99936eaab233": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xe701126012ec0290822eea17b794454d1af8b030": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xfb00ac187a8eb5afae4eace434f493eb62672df7": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xfccf3cabbe80101232d343252614b6a3ee81c989": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```