## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 50 % [5000] | 60 % [6000] |


#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 10 % [1000] | 20 % [2000] |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 63 % [6300] | 0 % [0] |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 10 % [1000] | 25 % [2500] |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 5000,
        "to": 6000
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 6300,
        "to": 0
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x04bab55efaf36d7a3d82d731649f3ddcc6bb2d450bbd2692a6f734d89ae3ecb9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001d4c"
        },
        "0x4077009f47acda086f17995361add44a9578e0de964d8e5663425f4d844587b8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001d4c"
        },
        "0x5a560350de1777248c18897d5d1c543e3d2272fa9ffbc1cda01861bbef7098f4": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000189c"
        },
        "0x7328721bbb46679a643531171c521cbf5c06ed9d896585e3d397d43f767dae1e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001d4c"
        }
      }
    },
    "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5dfb8c777c19d3cedcdc7398d2eef1fb0b9b05c9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7c": {
          "previousValue": "0x100000000000000000000103e8005f5e1000055d4a8003e8850629041e781d4c",
          "newValue": "0x100000000000000000000103e8005f5e1000055d4a8007d0870629041e780000"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7d": {
          "previousValue": "0x00000000002c88afe4ec55e9ad71042800000000038a3b193ba6902a1d15d1e9",
          "newValue": "0x00000000002795f20070e7bb33ba842200000000038a3b205497867a7e6b4e01"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7e": {
          "previousValue": "0x00000000004851a6bbdf32b05ec74f3a00000000039d49300e06d3724c382a09",
          "newValue": "0x00000000004851a706398fb4adb41fa600000000039d493bd29c2c8c0ffacc6f"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7f": {
          "previousValue": "0x00000000000000000000140067aa34be00000000000000000000000000000000",
          "newValue": "0x00000000000000000000140067aa350400000000000000000000000000000000"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d84": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000016f32346",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000016fd45e1"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59e": {
          "previousValue": "0x100000000000000000000103e8002dc6c0000297c1e01388a50629041e781d4c",
          "newValue": "0x100000000000000000000103e8002dc6c0000297c1e01770a70629041e780000"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59f": {
          "previousValue": "0x0000000000282b0979be1a2faf6423500000000003a99c85f9f4c1e264ae7488",
          "newValue": "0x000000000020226e15023e2d6c0c4f2c0000000003a99c89c2da2fa1a45accf0"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a0": {
          "previousValue": "0x00000000006012065420b4eeaf6a3b160000000003f553c4d0dd505ec74b63b6",
          "newValue": "0x00000000006012067b03d5cca533c9e30000000003f553ce995070213944fba5"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a1": {
          "previousValue": "0x00000000000000000000020067aa34dc00000000000000000000000000000000",
          "newValue": "0x00000000000000000000020067aa350400000000000000000000000000000000"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000020db721e",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000020e3bbfb"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0c": {
          "previousValue": "0x100000000000000000000103e80055d4a8000510ff4003e8a50629041e781d4c",
          "newValue": "0x100000000000000000000103e80055d4a8000510ff4009c4a70629041e780000"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0d": {
          "previousValue": "0x0000000000311b3778fffdf44b28a5bc0000000003c1f83bd427cc6d3186bb1b",
          "newValue": "0x000000000028ec03a60190e07ec25c280000000003c1f83e33c9f50d41025f0a"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0e": {
          "previousValue": "0x00000000004bf0d94c4490fc906168a80000000003ee88d2fe051c8a4098711a",
          "newValue": "0x00000000004bf0d9612694e55e93b7030000000003ee88d6d53b34123b218704"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0f": {
          "previousValue": "0x00000000000000000000050067aa34f000000000000000000000000000000000",
          "newValue": "0x00000000000000000000050067aa350400000000000000000000000000000000"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b14": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000001b4cd401",
          "newValue": "0x000000000000000000000000000000000000000000000000000000001b504684"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f5": {
          "previousValue": "0x100000000000000000000103e8002aea540001c9c38009c4a51229041e14189c",
          "newValue": "0x100000000000000000000103e8002aea540001c9c38009c4a71229041e140000"
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
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2e": {
          "previousValue": "0x0067aa3503000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067aa3503000000000003000000000000000000000000000000000000000000"
        },
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2f": {
          "previousValue": "0x000000000000000000093a8000000000000067d8598400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067d8598400000000000067aa3504"
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
```