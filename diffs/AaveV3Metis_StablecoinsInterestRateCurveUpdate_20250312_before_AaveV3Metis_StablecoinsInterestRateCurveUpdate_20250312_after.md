## Reserve changes

### Reserve altered

#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59.5 % | 56.5 % |
| variableRateSlope1 | 9.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=595000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49.5 % | 46.5 % |
| variableRateSlope1 | 9.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49.5 % | 46.5 % |
| variableRateSlope1 | 9.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "maxVariableBorrowRate": {
        "from": "595000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "95000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "maxVariableBorrowRate": {
        "from": "495000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "95000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "maxVariableBorrowRate": {
        "from": "495000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "95000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
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
          "previousValue": "0x00000000000000000000000000000000000000001388000003b6000000001f40",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000001f40"
        },
        "0x752f7954a00d33da5d6ed8dad4b2c0ed9baacb1013196b6086c149cf6a942e76": {
          "previousValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xf00e9cbb951fc06ac7351a5baeb5947035b75cf6560591f71c1b484b67347095": {
          "previousValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
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
        "0x10f5232ee9f6343d8bf0b7c9043a31ee616d8f028dcf3d2e9033ff8e0ce0ef0f": {
          "previousValue": "0x0067d1c13e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c13e000000000003000000000000000000000000000000000000000000"
        },
        "0x10f5232ee9f6343d8bf0b7c9043a31ee616d8f028dcf3d2e9033ff8e0ce0ef10": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5bf00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5bf00000000000067d1c13f"
        }
      }
    },
    "0xad6a01bade8e5ffed933e342f58a53768422e96a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768653": {
          "previousValue": "0x00000000002947be038322d4aac3648000000000036c8340cbdad5655e9ed7aa",
          "newValue": "0x00000000001c3e9c0ab50d175d4fc40800000000036c850eab5bee625f4372f3"
        },
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768654": {
          "previousValue": "0x00000000003f48949bafb1d3470ec6a300000000038669a334dfd9fb7a8c1c66",
          "newValue": "0x00000000002b4ca5334d8a67848a8eb60000000003866c7c31e934c1373fbf0e"
        },
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768655": {
          "previousValue": "0x00000000000000000000020067d1ad660000000000000000000000000004c1d4",
          "newValue": "0x00000000000000000000020067d1c13f0000000000000000000000000004c1d4"
        },
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de276865a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000001e67cf4",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000020f6572"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49a9": {
          "previousValue": "0x000000000024265a7c471a8ee1af86c90000000003899c58670220fd0ac17feb",
          "newValue": "0x000000000018bc0f5fe7de9d3ee30aaf000000000389a0ffea90b677b14dc289"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49aa": {
          "previousValue": "0x00000000003b3876c260e03709f57d780000000003a3284a4f2377580df87bbe",
          "newValue": "0x000000000028850f0a45ea1a990072e80000000003a330215735bf0628253bb1"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49ab": {
          "previousValue": "0x00000000000000000000030067d188a800000000000000000000000000000000",
          "newValue": "0x00000000000000000000030067d1c13f00000000000000000000000000000000"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49b0": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000007c232c",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000a85fe1"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eea": {
          "previousValue": "0x0000000000a171bd37ba740c3bafdae800000000038e4833da7f72b6a2d30de4",
          "newValue": "0x0000000000911dda3dda121f52c958ab00000000038e7cdf58bf1c4d3d36eb86"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eeb": {
          "previousValue": "0x0000000000f48acb70136baa7bcd5ef00000000003c2fc78b1b6d840592ab2c8",
          "newValue": "0x0000000000dbcd26381bc6a12188f2f30000000003c350e28d6078614faabf60"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895eec": {
          "previousValue": "0x00000000000000000000000067d1329700000000000000000000000000000000",
          "newValue": "0x00000000000000000000000067d1c13f00000000000000000000000000000000"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895ef1": {
          "previousValue": "0x00000000000000000000000000000000000000000000000240841d88cf6871a9",
          "newValue": "0x0000000000000000000000000000000000000000000000034f7213a7c09ced35"
        }
      }
    },
    "0xb9fabd7500b2c6781c35dd48d54f81fc2299d7af": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xcdcb65fc657b701a5100a12efb663978e7e8ffb8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
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
```