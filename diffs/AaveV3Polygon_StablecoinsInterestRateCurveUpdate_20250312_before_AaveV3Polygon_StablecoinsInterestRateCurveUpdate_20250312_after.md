## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 50 % | 47.5 % |
| variableRateSlope1 | 10 % | 7.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=500000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=75000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=475000000000000000000000000) |

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59 % | 56.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "maxVariableBorrowRate": {
        "from": "500000000000000000000000000",
        "to": "475000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "100000000000000000000000000",
        "to": "75000000000000000000000000"
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x055aec32800c1157d69820865326b61e91384dc9cf7d6e5d81cc0f17b3c39783": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x905324f6ac5b7ced7b5c02238633a89b1812b204b997b2d9662e7ee96782f059": {
          "previousValue": "0x00000000000000000000000000000000000000000fa0000003e8000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa0000002ee000000002328"
        },
        "0xae02604fb37f9c24800df454b9c35a512bc615e51b1cb51c5f01fd34e5087042": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xebab341f8755e41e908427903682896fb6f5295dc81509190f27a340c010d4e0": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000001f40",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000001f40"
        },
        "0xfaad2634be2a92239146fcf31c9286389570ac13f367a3736a19ed2cf0ce788c": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0x5d557b07776d12967914379c71a1310e917c7555": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
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
    "0xb7467b66d86ce80cc258f28d266a18a51db7fac8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7d": {
          "previousValue": "0x00000000001ba8478284f50dff8cb89c00000000038d7f914c1004ec96a729c0",
          "newValue": "0x000000000013f98961ae91a72e2cb69f00000000038d7f9eb1cd5057f29caac3"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7e": {
          "previousValue": "0x00000000003579e714ad1b9603fc53010000000003a2e1eb269e30d6ce0756e8",
          "newValue": "0x0000000000269f2747d12bfb75f66e0a0000000003a2e205aa076f7478de9918"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7f": {
          "previousValue": "0x00000000000000000000140067d1c06f0000000000000000000000000004a418",
          "newValue": "0x00000000000000000000140067d1c1430000000000000000000000000004a418"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d84": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000001125b811a",
          "newValue": "0x00000000000000000000000000000000000000000000000000000001127dd2a9"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b40": {
          "previousValue": "0x00000000001be468d811c50ac26f331000000000039d2b69fa2059b9ba335a8b",
          "newValue": "0x00000000001424fe750a311839a53f1500000000039d2c53e26d69c1214073fb"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b41": {
          "previousValue": "0x000000000038f5dcbe7717a5701572b80000000003e36d8c5ee5b92c4d25eb2b",
          "newValue": "0x00000000002923608e18056bb6d9ae730000000003e36f8e531073f63d6c79ea"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b42": {
          "previousValue": "0x000000000000000000000d0067d1b32b00000000000000000000000000000009",
          "newValue": "0x000000000000000000000d0067d1c14300000000000000000000000000000009"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b47": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000007b83",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000007c67"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59f": {
          "previousValue": "0x000000000019ae0b1c6b7e2f2006242b0000000003ac5c5bdb29a1deba446e91",
          "newValue": "0x00000000001342885ff0e0621d339eff0000000003ac5c5deb37a705a388ce69"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a0": {
          "previousValue": "0x00000000004cd09a8cba8c5dcc33df790000000003fd555c4d26a062b2239a6e",
          "newValue": "0x0000000000399c73f97064e37e78c4650000000003fd556300b4b9d6e4da8922"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a1": {
          "previousValue": "0x00000000000000000000020067d1c1210000000000000000000000000005bb6d",
          "newValue": "0x00000000000000000000020067d1c1430000000000000000000000000005bb6d"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a6": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000001329bb8be",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000132a17f8e"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0d": {
          "previousValue": "0x00000000001d7ce427fda3e404f9ac560000000003c571679047a96ee197e8fa",
          "newValue": "0x0000000000154bfa5529de10cd8077510000000003c5716fdc367392d5abab62"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0e": {
          "previousValue": "0x0000000000390744ddab1cd3d3e8d0bd0000000003f4b775ac0f2d25f100ce9d",
          "newValue": "0x0000000000292fead6844d9b549e76dd0000000003f4b78680cc1474b1730ad9"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0f": {
          "previousValue": "0x00000000000000000000050067d1c0cf0000000000000000000000000009d96c",
          "newValue": "0x00000000000000000000050067d1c1430000000000000000000000000009d96c"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b14": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000001f450cb2f",
          "newValue": "0x00000000000000000000000000000000000000000000000000000001f47038f5"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f6": {
          "previousValue": "0x00000000002be538acdb03dc715dbc1c0000000003b112cf7cdb7cb2ae38004b",
          "newValue": "0x00000000001fb3c94634e26bcd0fea720000000003b113b63bf6c26e6e2e8f17"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f7": {
          "previousValue": "0x00000000004594424c39fa865ee52b620000000003ef1db270b16fa9f08a7b92",
          "newValue": "0x000000000032406bdc187068a761f4720000000003ef1f383645b992e5ec3d90"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f8": {
          "previousValue": "0x00000000000000000000000067d1b89d0000000000000000036340a44e2f8484",
          "newValue": "0x00000000000000000000000067d1c1430000000000000000036340a44e2f8484"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42fd": {
          "previousValue": "0x00000000000000000000000000000000000000000000004a967e42bacd726a02",
          "newValue": "0x00000000000000000000000000000000000000000000004afc80863926e5a88a"
        }
      }
    },
    "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8bd72d705e704e96ab1fa5baf1ac8053f4ec008dca8cf0376ca60a5648fa9532": {
          "previousValue": "0x0067d1c142000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c142000000000003000000000000000000000000000000000000000000"
        },
        "0x8bd72d705e704e96ab1fa5baf1ac8053f4ec008dca8cf0376ca60a5648fa9533": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c300000000000067d1c143"
        }
      }
    },
    "0xdf7d0e6454db638881302729f5ba99936eaab233": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
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
```