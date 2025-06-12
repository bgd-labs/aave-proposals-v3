## Reserve changes

### Reserve altered

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52 % | 49.5 % |
| variableRateSlope1 | 12 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=520000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 53 % | 50.5 % |
| variableRateSlope1 | 13 % | 10.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=130000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=530000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=105000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=505000000000000000000000000) |

#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 61.5 % | 59.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=615000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=595000000000000000000000000) |

#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "maxVariableBorrowRate": {
        "from": "520000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "maxVariableBorrowRate": {
        "from": "530000000000000000000000000",
        "to": "505000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "130000000000000000000000000",
        "to": "105000000000000000000000000"
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "maxVariableBorrowRate": {
        "from": "615000000000000000000000000",
        "to": "595000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
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
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4ce496f0a390745102540faf041ef92ffd588b44": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x4a7783ce0e0c0e13c55c8729b1b24615e8db845246e817324fc16a2ed4b8dae9": {
            "previousValue": "0x000000000000000000000000000000000000000013880000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000001388000003b6000000002328"
          },
          "0x80e20a7b385f8d2ac1c3ea1e98ad1ac1729cb251c634a7724657086e5970e994": {
            "previousValue": "0x00000000000000000000000000000000000000000fa000000514000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa00000041a000000002328"
          },
          "0xc0963972186d8ee23ea5bd91c3313dea1a6697d1afafd6c1ccd165b3e87dd630": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004b0000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xfd6743ac1840b81c4bd353cd87b222fd0308e2c0fc9c7e4714a6cdbf1301492c": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0x5f6f7b0a87ca3cf3d0b431ae03ef3305180bff4d": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7304979ec9e4eaa0273b6a037a31c4e9e5a75d16": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
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
          "0x47bd603b2672149df187087e649a417345c22ebc601af252344b2472b5a5fea8": {
            "previousValue": "0x0067a135ed000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135ed000000000003000000000000000000000000000000000000000000"
          },
          "0x47bd603b2672149df187087e649a417345c22ebc601af252344b2472b5a5fea9": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6e00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6e00000000000067a135ee"
          }
        }
      },
      "0xec710f59005f48703908bc519d552df5b8472614": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xf2c312bfaf4cf0429db4da15a0cf5f770ea3e770": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912c9": {
            "previousValue": "0x0000000000251bf97d527e6a6dbb2a18000000000345aa29efbc7190232babd7",
            "newValue": "0x00000000001d60da5524c4cb7f60c991000000000345aaf6efdefa4e64432488"
          },
          "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912ca": {
            "previousValue": "0x0000000000436f86883906cd196a0e64000000000352391a1625ccdd1cda8d51",
            "newValue": "0x00000000003562fe658de22b647b5e920000000003523a9434170a4550930d8a"
          },
          "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912cb": {
            "previousValue": "0x00000000000000000000070067a12bad00000000000000000000000000000000",
            "newValue": "0x00000000000000000000070067a135ee00000000000000000000000000000000"
          },
          "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912d0": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000003867809",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000003acb11e"
          },
          "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d5": {
            "previousValue": "0x000000000021520910c05d97b02cde91000000000355df93e65fb4a5377d97de",
            "newValue": "0x00000000001b868d125baf450ce85498000000000355df9441dde1b33eb813c0"
          },
          "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d6": {
            "previousValue": "0x00000000003e8e146314da39cc13298a00000000036e12da734d8ecb0b2a7df6",
            "newValue": "0x000000000033ad05ba444582f3ed205800000000036e12db23f0076ae57b4bf3"
          },
          "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d7": {
            "previousValue": "0x00000000000000000000050067a135e900000000000000000000000000000000",
            "newValue": "0x00000000000000000000050067a135ee00000000000000000000000000000000"
          },
          "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6dc": {
            "previousValue": "0x000000000000000000000000000000000000000000000002c7f676982582a2d0",
            "newValue": "0x000000000000000000000000000000000000000000000002c8061451cf6e4eb2"
          },
          "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27690": {
            "previousValue": "0x00000000005f28a8b395723a6fed68390000000003793c5fcddce0b42d6442c4",
            "newValue": "0x0000000000510d0fc834cd8411df58bd0000000003793cdf5b6613b8269cf4aa"
          },
          "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27691": {
            "previousValue": "0x00000000008b7acdecda2c8c5e99e1cc00000000039212855697176c83d07295",
            "newValue": "0x000000000076cd12616948b49fb778180000000003921345859cf4ecd4415baa"
          },
          "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27692": {
            "previousValue": "0x00000000000000000000030067a1339600000000000000000000000000000000",
            "newValue": "0x00000000000000000000030067a135ee00000000000000000000000000000000"
          },
          "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27697": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000000a33fca5",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000a50b5dd"
          },
          "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74de": {
            "previousValue": "0x000000000036da1371f534a90284bf1e00000000037372472049da28afa8decf",
            "newValue": "0x00000000002d4ffe296d4a6fd2ba0f1100000000037372e4c893d68d2921c7d6"
          },
          "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74df": {
            "previousValue": "0x000000000057ebca2a319b7fb24fea7300000000038fc10d84cee5331e31edc4",
            "newValue": "0x000000000048a167b782dad152008e4800000000038fc21252a4268ab255f384"
          },
          "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74e0": {
            "previousValue": "0x00000000000000000000040067a130df00000000000000000000000000000000",
            "newValue": "0x00000000000000000000040067a135ee00000000000000000000000000000000"
          },
          "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74e5": {
            "previousValue": "0x0000000000000000000000000000000000000000000000152b75f238db87c773",
            "newValue": "0x000000000000000000000000000000000000000000000015aeb77e2c5afb2a47"
          }
        }
      }
    }
  }
}
```