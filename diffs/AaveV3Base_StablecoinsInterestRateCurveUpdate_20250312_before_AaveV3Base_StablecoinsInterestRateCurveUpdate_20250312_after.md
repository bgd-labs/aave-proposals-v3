## Reserve changes

### Reserves altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
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
    "0x2425a746911128c2eaa7bebdc9bc452ee52208a1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x319d156ea750b20d5370ef7b348b6ff1ab5d0256": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x7bfa808024a5334b0a1e191d8e95f6724ea40d1a03d1286b6934e670f8c6924b": {
          "previousValue": "0x0067d1c142000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c142000000000003000000000000000000000000000000000000000000"
        },
        "0x7bfa808024a5334b0a1e191d8e95f6724ea40d1a03d1286b6934e670f8c6924c": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c300000000000067d1c143"
        }
      }
    },
    "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x59dca05b6c26dbd64b5381374aaac5cd05644c28": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6ef6b6176091f94a8ad52c08e571f81598b226a2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b659": {
          "previousValue": "0x0000000000227fc3a6174e3217e266ec00000000037f433fb8844cd255229f6c",
          "newValue": "0x000000000018ea7f1b502439c234cbc700000000037f4340a6e31a055d9db653"
        },
        "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b65a": {
          "previousValue": "0x0000000000384f43e1da7074199edd44000000000396d617362d8103a9c80c5b",
          "newValue": "0x000000000028ab0661a5cd0e40780e46000000000396d618c57dff7604107fb8"
        },
        "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b65b": {
          "previousValue": "0x00000000000000000000040067d1c13700000000000000000000000000023f4f",
          "newValue": "0x00000000000000000000040067d1c14300000000000000000000000000023f4f"
        },
        "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b660": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000031adbe12",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000031b188fb"
        }
      }
    },
    "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x167d7ad8ce5bbf928e114a13d4a925d29e6437f0d5be246a7858d666db460b9d": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```