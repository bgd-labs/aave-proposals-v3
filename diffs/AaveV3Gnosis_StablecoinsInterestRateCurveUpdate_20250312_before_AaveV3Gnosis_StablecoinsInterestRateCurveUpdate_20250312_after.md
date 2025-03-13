## Reserve changes

### Reserve altered

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59 % | 56.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
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
    "0x1df462e2712496373a347f8ad10802a5e95f053d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x281963d7471ecdc3a2bd4503e24e89691cfe420d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x36616cf17557639614c1cddb356b1b83fc0b2132": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x37b9ad6b5dc8ad977ad716e92f49e9d200e58431": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4ce496f0a390745102540faf041ef92ffd588b44": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4a7783ce0e0c0e13c55c8729b1b24615e8db845246e817324fc16a2ed4b8dae9": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000002328",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000002328"
        },
        "0xc0963972186d8ee23ea5bd91c3313dea1a6697d1afafd6c1ccd165b3e87dd630": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xfd6743ac1840b81c4bd353cd87b222fd0308e2c0fc9c7e4714a6cdbf1301492c": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0x7304979ec9e4eaa0273b6a037a31c4e9e5a75d16": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x77c874799e9564a0d0670ed40bf023d249e7bb21": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912c9": {
          "previousValue": "0x00000000001214fe863117e9705853d400000000034882943c2d8ce0529dd02e",
          "newValue": "0x00000000000d0f3a25376f7cd7c1ec630000000003488465de65eff029480783"
        },
        "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912ca": {
          "previousValue": "0x000000000028c432244beb9c50629f7c000000000357ba41be42c296cd76833d",
          "newValue": "0x00000000001d71534ed6eb9f88b7df0b000000000357be6e8b384ce80699eb87"
        },
        "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912cb": {
          "previousValue": "0x00000000000000000000070067d1919e00000000000000000000000000000000",
          "newValue": "0x00000000000000000000070067d1c14100000000000000000000000000000000"
        },
        "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912d0": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000015db41a",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000001d44f65"
        },
        "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d5": {
          "previousValue": "0x00000000000dbc66d2924d332608ee9a0000000003586a6d31897034c8955323",
          "newValue": "0x000000000009eb9fc7edb654e0b491190000000003586a72a936bdc591e2bc53"
        },
        "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d6": {
          "previousValue": "0x00000000002387f3999a38fea6e86fdc00000000037361d760ec6eec1e08b1d5",
          "newValue": "0x000000000019a94c9e995d406146edc600000000037361e5f780694ef72ecc60"
        },
        "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d7": {
          "previousValue": "0x00000000000000000000050067d1c08800000000000000000000000000000000",
          "newValue": "0x00000000000000000000050067d1c14100000000000000000000000000000000"
        },
        "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6dc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000012c29359c7a229a4f",
          "newValue": "0x0000000000000000000000000000000000000000000000012d7823a9d21e4e9b"
        },
        "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74de": {
          "previousValue": "0x00000000001fd1189360c07f0e8c89730000000003783ec987fbcfc9e6da45a3",
          "newValue": "0x000000000016fa9918fd99d99b03555a0000000003783fd644bda7bb063ab5c5"
        },
        "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74df": {
          "previousValue": "0x00000000003b3cd539e7aa43e2e785bc00000000039805cf8e533a6db607e3c5",
          "newValue": "0x00000000002ac867f2daf1bdee63bfee00000000039807d5cd9947ce29733647"
        },
        "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74e0": {
          "previousValue": "0x00000000000000000000040067d1b2780000000000000000010d0c404bce905e",
          "newValue": "0x00000000000000000000040067d1c1410000000000000000010d0c404bce905e"
        },
        "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74e5": {
          "previousValue": "0x00000000000000000000000000000000000000000000000d5c837e41e4aa8693",
          "newValue": "0x00000000000000000000000000000000000000000000000e2a57fe165a5a4069"
        }
      }
    },
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb96404e475f337a7e98e4a541c9b71309bb66c5a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xbec519531f0e78bcddb295242fa4ec5251b38574": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe59470b3be3293534603487e00a44c72f2cd466d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248f9": {
          "previousValue": "0x0067d1c140000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c140000000000003000000000000000000000000000000000000000000"
        },
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248fa": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c100000000000067d1c141"
        }
      }
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xec710f59005f48703908bc519d552df5b8472614": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```