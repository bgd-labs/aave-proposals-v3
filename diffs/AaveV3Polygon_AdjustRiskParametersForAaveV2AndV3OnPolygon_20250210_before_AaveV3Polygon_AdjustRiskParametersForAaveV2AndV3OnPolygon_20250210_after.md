## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 50 % [5000] | 60 % [6000] |


#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 10 % [1000] | 20 % [2000] |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 0 % [0] |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 10 % [1000] | 25 % [2500] |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
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
      "ltv": {
        "from": 6300,
        "to": 0
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
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
      "stateDiff": {}
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
          "newValue": "0x100000000000000000000103e8005f5e1000055d4a8007d0850629041e780000"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7d": {
          "previousValue": "0x0000000000246c52f2ace581a52b1f5600000000038b0d191d5a36fa9d00fa41",
          "newValue": "0x0000000000206049fa7b258aa3a23ffd00000000038b0d1fc13552e54123060b"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7e": {
          "previousValue": "0x00000000003b71ab36075b30854e1b2d00000000039ea09d22cc626b9ab7a966",
          "newValue": "0x00000000003b71ab700f8625823aad5200000000039ea0a834e7d15060411f18"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7f": {
          "previousValue": "0x00000000000000000000140067b385a100000000000000000000000000000000",
          "newValue": "0x00000000000000000000140067b385f100000000000000000000000000000000"
        },
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d84": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000670ffb4b",
          "newValue": "0x000000000000000000000000000000000000000000000000000000006719a2ee"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59e": {
          "previousValue": "0x100000000000000000000103e8002dc6c0000297c1e01388a50629041e781d4c",
          "newValue": "0x100000000000000000000103e8002dc6c0000297c1e01770a50629041e780000"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b59f": {
          "previousValue": "0x00000000002178eb64e8f1abb0fa30780000000003aa66ed8aa4e72f5a1e8426",
          "newValue": "0x00000000001ac722cb7c3d6e91c056570000000003aa66f10384e44ad2853053"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a0": {
          "previousValue": "0x0000000000506080eb973e13c79d85240000000003f7557ad7d2819cfd1205e0",
          "newValue": "0x00000000005060810a24b0050392e6f60000000003f75583dd426c09300517a5"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a1": {
          "previousValue": "0x00000000000000000000020067b385c500000000000000000000000000000000",
          "newValue": "0x00000000000000000000020067b385f100000000000000000000000000000000"
        },
        "0x5086f8006fb47d4e8b7d07ce95e816ef3f62d9d614c3cca018dfb9c36698b5a6": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000940ababf",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000941223a1"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0c": {
          "previousValue": "0x100000000000000000000103e80055d4a8000510ff4003e8a50629041e781d4c",
          "newValue": "0x100000000000000000000103e80055d4a8000510ff4009c4a50629041e780000"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0d": {
          "previousValue": "0x000000000026cf2696a263bcea3321a20000000003c2e779000b731984a16157",
          "newValue": "0x000000000020574b6a9c43d829c690960000000003c2e78bc6e4e0ea1e8b7da5"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0e": {
          "previousValue": "0x00000000003d5c35957354c276952aa50000000003f00b6f78a5677ea864f1cc",
          "newValue": "0x00000000003d5c362567e52e1438ade00000000003f00b8e8cea9c74b3ce8cd0"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0f": {
          "previousValue": "0x00000000000000000000050067b3852900000000000000000000000000000000",
          "newValue": "0x00000000000000000000050067b385f100000000000000000000000000000000"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b14": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000076f3b737",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000770f62ad"
        },
        "0x9690560edd96b8ad42bbefadc2405558072125d86547c092bfe966b61dcb42f5": {
          "previousValue": "0x100000000000000000000103e8002aea540001c9c38009c4a51229041e14189c",
          "newValue": "0x100000000000000000000103e8002aea540001c9c38009c4a51229041e140000"
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
          "previousValue": "0x0067b385f0000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067b385f0000000000003000000000000000000000000000000000000000000"
        },
        "0x6b16ef514f22b74729cbea5cc7babfecbdc2309e530ca716643d11fe929eed2f": {
          "previousValue": "0x000000000000000000093a8000000000000067e1aa7100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067e1aa7100000000000067b385f1"
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