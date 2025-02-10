## Reserve changes

### Reserve altered

#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 639,850.0374 USDC [639850037442] | 576,868.5604 USDC [576868560480] |
| virtualBalance | 639,772.9905 USDC [639772990580] | 576,791.5136 USDC [576791513618] |


#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 70,588.3994 LUSD [70588399405298855959016] | 69,781.6116 LUSD [69781611696661437400765] |
| virtualBalance | 70,588.3994 LUSD [70588399405298855959016] | 69,781.6116 LUSD [69781611696661437400765] |


## Raw diff

```json
{
  "reserves": {
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "aTokenUnderlyingBalance": {
        "from": "639850037442",
        "to": "576868560480"
      },
      "virtualBalance": {
        "from": "639772990580",
        "to": "576791513618"
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "aTokenUnderlyingBalance": {
        "from": "70588399405298855959016",
        "to": "69781611696661437400765"
      },
      "virtualBalance": {
        "from": "70588399405298855959016",
        "to": "69781611696661437400765"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x04a8d477ee202adce1682f5902e1160455205b12": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x230e0321cf38f09e247e50afc7801ea2351fe56f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x2b22e425c1322fba0dbf17bb1da25d71811ee7ba": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c325287": {
            "previousValue": "0x00000000002a802e676291e5055a120000000000039fbcdc551c564d7edd29f5",
            "newValue": "0x00000000002bb20c4b417d0062893c0b00000000039fbd0688197dcba0b396e9"
          },
          "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c325288": {
            "previousValue": "0x000000000062d20bacacbee69d74f7d60000000003e56033f676426c8139b490",
            "newValue": "0x000000000064332c86aae98812170a890000000003e5609d72802395cf7f3a0a"
          },
          "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c325289": {
            "previousValue": "0x00000000000000000000020067a6040700000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a605b100000000000000000000000000000000"
          },
          "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c32528e": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000009f1ebdb",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000a1d1f2a"
          },
          "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c32528f": {
            "previousValue": "0x000000000000000000000094f5711c7400000000000000000000000000000000",
            "newValue": "0x0000000000000000000000864b740a1200000000000000000000000000000000"
          },
          "0xa448ebc1fc7bd1ea9dc8c788edf226a39771c0d783bf57949af80885132bc288": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae96": {
            "previousValue": "0x000000000028b807fc6484074c12f0a600000000039bf87b11baa04b356e8da9",
            "newValue": "0x0000000000290b1478957401d0d7bb9a00000000039bfb760a4e477c57de4755"
          },
          "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae97": {
            "previousValue": "0x00000000004dcbc338e5cb4101b656f10000000003d0cfcdbfdd1fcfcfb632a1",
            "newValue": "0x00000000004e1af0ac362146497eb4cf0000000003d0d5d2d62cac4c883d405d"
          },
          "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae98": {
            "previousValue": "0x000000000000000000000a0067a5e62900000000000000000000000000000000",
            "newValue": "0x000000000000000000000a0067a605b100000000000000000000000000000000"
          },
          "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae9d": {
            "previousValue": "0x00000000000000000000000000000000000000000000000011d00b17448e34cb",
            "newValue": "0x00000000000000000000000000000000000000000000000019cd8301a0a8c3a4"
          },
          "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae9e": {
            "previousValue": "0x0000000000000ef29ad421c02927d9e800000000000000000000000000000000",
            "newValue": "0x0000000000000ec6de66674a1478c6bd00000000000000000000000000000000"
          }
        }
      },
      "0x4200000000000000000000000000000000000007": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4200000000000000000000000000000000000010": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4200000000000000000000000000000000000016": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5f4d15d761528c57a5c30c43c1dab26fc5452731": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xd9823faacdd4cc9cff25a787df109b0521b6ff4e9c3370f8ac4a76d05b607e85": {
            "previousValue": "0x635eec7c67a604070000000237acfee97ab1d700000000000006b3ff7e13fe08",
            "newValue": "0x635eec7c67a605b10000000237acfee97ab1d700000000000006b3ff7e13fe08"
          }
        }
      },
      "0x625e7708f30ca75bfd92586e17077590c60eb4cd": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x746c675dab49bcd5bb9dc85161f2d7eb435009bf": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7a7ef57479123f26db6a0e3efbf8a3562edd65be": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7f5c764cbc14f9669b88837ca1490cca17c31607": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000002": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000036116c9cf1e2",
            "newValue": "0x00000000000000000000000000000000000000000000000000003601b75438d6"
          },
          "0x5667746c7fce565cbf6b24470eec32092e8176fbc4bbb7e9df66c96b76ad3249": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0x841a69c93fa72728c2b91c156bd21ecddeff43f543c1aa61191b2d6d99eec7d9": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000094fa08c0c2",
            "newValue": "0x00000000000000000000000000000000000000000000000000000086500bae60"
          },
          "0xab7f4a2b3103a10c166aab767e78add6cc21483f348cdcac0157785c507bee64": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000010b4ba6aa",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xff6bca691c6da7b9504db459dcfbc7e4577e682652a73cb8a822066454e9b007": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000011021e324f",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000fb548b90c"
          }
        }
      },
      "0x8eb270e296023e9d92081fdf967ddd7878724424": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x929ec64c34a17401f460460d4b9390518e5b473e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x9359282735496463131139875849d5302fb4bed1": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xb2289e329d2f85f1ed31adbb30ea345278f21bcf": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xbcb167bdcf14a8f791d6f4a6edd964aed2f8813b": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000036": {
            "previousValue": "0x0000000000000000000000000000000000000000000026b45d8a2c528eb3f2bb",
            "newValue": "0x000000000000000000000000000000000000000000000000000003a8a2dc59fd"
          },
          "0x8de5b4c9e1ccce84b1f76b67482ce11256c258ced0ff3ce9c36f20fdbd88b36e": {
            "previousValue": "0x00000000039bf20b1dc39f33503e193e000000000000002733d9c8a466429a1d",
            "newValue": "0x00000000039fbd0688197dcba0b396e9000000000000000000000000000d9ada"
          },
          "0x9ad4ba68d92460835e236d222d0b933ede669f09541a7fc23404c9fc3ae9a34c": {
            "previousValue": "0x00000000038ec823ad69ac07848dd4aa00000000000000000000000000000000",
            "newValue": "0x00000000039fbd0688197dcba0b396e900000000000000000000000000000000"
          }
        }
      },
      "0xc0d3c0d3c0d3c0d3c0d3c0d3c0d3c0d3c0d30007": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x00000000000000000000000000000000000000000000000000000000000000cd": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000005e10",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000005e12"
          }
        }
      },
      "0xc0d3c0d3c0d3c0d3c0d3c0d3c0d3c0d3c0d30016": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000001": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000005e1b",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000005e1d"
          },
          "0x8328800f80047d280670b6ae24cd70ac8e424b991e82a83253d69808029cd976": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
          },
          "0xd81269390edfa697cc953a62e503e2fbf56e45c321fc9f4e20f08845bffcf385": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
          }
        }
      },
      "0xc3250a20f8a7bbdd23ade87737ee46a45fe5543e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xc40f949f8a4e094d1b49a23ea9241d289b7b2819": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000002": {
            "previousValue": "0x00000000000000000000000000000000000000000001194764fea9bcefeed067",
            "newValue": "0x00000000000000000000000000000000000000000001191ba890ef46db3fbd3c"
          },
          "0x3e6062051c3534f333eafceb417b1d58d7f4f3f5e0f15c12fa0b04848ab5d2fa": {
            "previousValue": "0x000000000000000000000000000000000000000000000ef29ad421c02927d9e8",
            "newValue": "0x000000000000000000000000000000000000000000000ec6de66674a1478c6bd"
          },
          "0x5667746c7fce565cbf6b24470eec32092e8176fbc4bbb7e9df66c96b76ad3249": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xff6bca691c6da7b9504db459dcfbc7e4577e682652a73cb8a822066454e9b007": {
            "previousValue": "0x0000000000000000000000000000000000000000000000c57c16620f3827de6f",
            "newValue": "0x00000000000000000000000000000000000000000000002bbc6dba7614af132b"
          }
        }
      },
      "0xce186f6cccb0c955445bb9d10c59cae488fea559": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xfccf3cabbe80101232d343252614b6a3ee81c989": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x682542400590cecd25f82cad25103b4dc125cd3511d319539197c8bb9765a74f": {
            "previousValue": "0x0067a605b0000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a605b0000000000003000000000000000000000000000000000000000000"
          },
          "0x682542400590cecd25f82cad25103b4dc125cd3511d319539197c8bb9765a750": {
            "previousValue": "0x000000000000000000093a8000000000000067d42a3100000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067d42a3100000000000067a605b1"
          }
        }
      }
    }
  }
}
```