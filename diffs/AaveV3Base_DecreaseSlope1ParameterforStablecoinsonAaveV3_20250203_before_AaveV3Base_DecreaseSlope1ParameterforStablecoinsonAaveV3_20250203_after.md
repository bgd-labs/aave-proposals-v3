## Reserve changes

### Reserve altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 50.5 % |
| variableRateSlope1 | 12.5 % | 10.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=105000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=505000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "maxVariableBorrowRate": {
        "from": "515000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "115000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "505000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "105000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
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
          "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc5": {
            "previousValue": "0x0067a135f0000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135f0000000000003000000000000000000000000000000000000000000"
          },
          "0xda4c88cb8422456e6dbc87bdc0d70fdf69c0f9f7d6833899744759615d2d4cc6": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a7100000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a7100000000000067a135f1"
          }
        }
      },
      "0x3a9c471f13c9ca1ebdf440cf713c8404e498f9c3": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b659": {
            "previousValue": "0x00000000002a580cda227c8fff40603b00000000037b1aea8d4d15f25ffc338e",
            "newValue": "0x000000000022fad2fd511d8f41ac994b00000000037b1aeb1ee8aafe6afd620b"
          },
          "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b65a": {
            "previousValue": "0x00000000004684b3b759904a5a060b1000000000038ff0d7c031a74741e034f7",
            "newValue": "0x00000000003a411a0c0b0d7a0d3307e700000000038ff0d8b85acdf0c58742f4"
          },
          "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b65b": {
            "previousValue": "0x00000000000000000000040067a135eb00000000000000000000000000000000",
            "newValue": "0x00000000000000000000040067a135f100000000000000000000000000000000"
          },
          "0x33a59812d7f150f2c2e7cf398df161b5d00b06dc197e974636ff8a741412b660": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000068ce6eb9",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000068d13e1a"
          },
          "0x576d2086a3d5f0898768a114197adc4053263301f03ff1504528cd2771084b43": {
            "previousValue": "0x00000000001d5a43833723691b7de519000000000388813f63d2756441434ea1",
            "newValue": "0x000000000018a7fc2299834f5df86b2000000000038881534448e1053912f671"
          },
          "0x576d2086a3d5f0898768a114197adc4053263301f03ff1504528cd2771084b44": {
            "previousValue": "0x0000000000521fd80669795f1bcbb04c0000000003be3f4846b02ee8388b0acf",
            "newValue": "0x000000000044fc08972ee8b52d091c920000000003be3f833163a7dc593d65ba"
          },
          "0x576d2086a3d5f0898768a114197adc4053263301f03ff1504528cd2771084b45": {
            "previousValue": "0x00000000000000000000020067a134c700000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a135f100000000000000000000000000000000"
          },
          "0x576d2086a3d5f0898768a114197adc4053263301f03ff1504528cd2771084b4a": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000043f4ef4",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000004450bc5"
          }
        }
      },
      "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
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
      "0x7376b2f323dc56fcd4c191b34163ac8a84702dab": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x86ab1c62a8bf868e1b3e1ab87d587aba6fbcbdc5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x167d7ad8ce5bbf928e114a13d4a925d29e6437f0d5be246a7858d666db460b9d": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xfd9d8e5cf6730e7e57eb97f3b1049464bdecd36ad3cb0f2ef433a52cab89a82e": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa00000041a000000002328"
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
      }
    }
  }
}
```