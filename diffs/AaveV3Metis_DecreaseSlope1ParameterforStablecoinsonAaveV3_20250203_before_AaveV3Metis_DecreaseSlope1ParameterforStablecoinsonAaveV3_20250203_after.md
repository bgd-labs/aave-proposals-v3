## Reserve changes

### Reserve altered

#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 62.5 % | 59.5 % |
| variableRateSlope1 | 12.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=625000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=595000000000000000000000000) |

#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 49.5 % |
| variableRateSlope1 | 12.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 49.5 % |
| variableRateSlope1 | 12.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "maxVariableBorrowRate": {
        "from": "625000000000000000000000000",
        "to": "595000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x13bd89af338f3c7eae9a75852fc2f1ca28b4ddbf": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x2233f8a66a728fba6e1dc95570b25360d07d5524": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x258625afde0073f5bbce50c0305f4c23b16c7f3a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x4e18fd3264da8b562950a072ccca4a353564c56c9abd38e5f1d807e200b82f28": {
            "previousValue": "0x00000000000000000000000000000000000000001388000004e2000000001f40",
            "newValue": "0x00000000000000000000000000000000000000001388000003b6000000001f40"
          },
          "0x752f7954a00d33da5d6ed8dad4b2c0ed9baacb1013196b6086c149cf6a942e76": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xf00e9cbb951fc06ac7351a5baeb5947035b75cf6560591f71c1b484b67347095": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x571171a7ef1e3c8c83d47ef1a50e225e9c351380": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x69fee8f261e004453be0800bc9039717528645a6": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x6b45dce8af4fe5ab3bfcf030d8fb57718eab54e5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x6fd45d32375d5adb8d76275a3932c740f03a8718": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x90df02551bb792286e8d4f13e0e357b4bf1d6a57": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x986fdca06d10baaf923fc032186f0b6aaeb04c42": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xb79c508b45d95db38395ed273cca5afa4bcb8f1225ec7e9c849430db27d6f0fe": {
            "previousValue": "0x0067a135e6000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135e6000000000003000000000000000000000000000000000000000000"
          },
          "0xb79c508b45d95db38395ed273cca5afa4bcb8f1225ec7e9c849430db27d6f0ff": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6700000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6700000000000067a135e7"
          }
        }
      },
      "0xb9fabd7500b2c6781c35dd48d54f81fc2299d7af": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xca311dce5b11436c7bd7b3847e77ade29f829f8e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768653": {
            "previousValue": "0x000000000037398c8fdbdbb6fb789890000000000367df3b23fa5d8f6764f955",
            "newValue": "0x000000000029f89f3804060bfd1b554d000000000367e1612b27234394037d67"
          },
          "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768654": {
            "previousValue": "0x000000000053f61f4f9edd65c294079600000000037f08f5d18a84cadf911e90",
            "newValue": "0x00000000003fcf98e9254900f97da9f800000000037f0c5047b68159d1f46532"
          },
          "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768655": {
            "previousValue": "0x00000000000000000000020067a1242400000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a135e700000000000000000000000000000000"
          },
          "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de276865a": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000038c1f67",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000003dcd477"
          },
          "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49a9": {
            "previousValue": "0x0000000000410b0fcbe6fad8384215e000000000038387c8faa522546e11a56e",
            "newValue": "0x0000000000316ef819327752cf68173e0000000003838ce0efb6f513be714629"
          },
          "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49aa": {
            "previousValue": "0x00000000005b1eb7855967629b54fe1300000000039a9871e5903990126718ec",
            "newValue": "0x000000000045406b20c114ae130d5e0300000000039a9fc37f96d6f507f843d4"
          },
          "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49ab": {
            "previousValue": "0x00000000000000000000030067a1134000000000000000000000000000000000",
            "newValue": "0x00000000000000000000030067a135e700000000000000000000000000000000"
          },
          "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49b0": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000027fc70a",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000002f3c7ce"
          },
          "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eea": {
            "previousValue": "0x00000000003ddae76edcbcb8a9418b49000000000387f0bc63bf67b502cfc5b6",
            "newValue": "0x00000000002f02d2da542b016358534d000000000387f93a2fa8468076996155"
          },
          "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eeb": {
            "previousValue": "0x0000000000673e9d3b75f488a2de0a340000000003b7f1785c81d577a4fcf9b8",
            "newValue": "0x00000000004e7783a8df62738a9d55880000000003b800658597e9a05c99cfd6"
          },
          "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eec": {
            "previousValue": "0x00000000000000000000000067a0f97400000000000000000000000000000000",
            "newValue": "0x00000000000000000000000067a135e700000000000000000000000000000000"
          },
          "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895ef1": {
            "previousValue": "0x0000000000000000000000000000000000000000000000009854d271199317a2",
            "newValue": "0x000000000000000000000000000000000000000000000000cf9c864249027c89"
          }
        }
      },
      "0xcdcb65fc657b701a5100a12efb663978e7e8ffb8": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xe7fa271bd76fc9c6f2f968976e9f4f553256e02f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```