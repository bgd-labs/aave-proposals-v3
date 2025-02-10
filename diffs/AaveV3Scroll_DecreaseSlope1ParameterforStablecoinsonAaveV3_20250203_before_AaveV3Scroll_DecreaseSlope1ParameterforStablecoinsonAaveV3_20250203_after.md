## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 51.5 % | 49.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=515000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
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
      "0x11fcfe756c05ad438e312a7fd934381537d3cffe": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x32bcab42a2bb5ac577d24b425d46d8b8e0df9b7f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x3d2e209af5bfa79297c88d6b57f89d792f6e28ee": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x49ba16c08130ff8cfade263b49387a8555bc057b": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x69850d0b276776781c063771b161bd8894bcdd04": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x6b6b41c0f8c223715f712be83cec3c37bbfdc3fe": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7633f981d87dc6307227de9383d2ce7243158081": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x986fdca06d10baaf923fc032186f0b6aaeb04c42": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xb79c508b45d95db38395ed273cca5afa4bcb8f1225ec7e9c849430db27d6f0fe": {
            "previousValue": "0x0067a135ee000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135ee000000000003000000000000000000000000000000000000000000"
          },
          "0xb79c508b45d95db38395ed273cca5afa4bcb8f1225ec7e9c849430db27d6f0ff": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6f00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6f00000000000067a135ef"
          }
        }
      },
      "0xc1abf87ffadf4908f4ec8dc54a25dcfeabae4a24": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xc37353e5766164d8654d3cb395acfdca4c2e7ddc": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xd070814d1411eddff677039c37c2413a15e681c88846606935bc880f4979bdd5": {
            "previousValue": "0x00000000000000000000000000000000000000000fa00000047e000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0xcb2107ace932591c57eb5d07a135f1f3dd613dc0": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e0": {
            "previousValue": "0x000000000037dac1995763b7eed4149200000000036a6035049a015caf20fe12",
            "newValue": "0x00000000002e240d9430580e5122f36800000000036a613deb04143003ae07c8"
          },
          "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e1": {
            "previousValue": "0x000000000050fda59b83cadadd6148bc00000000037e7935bf7c34c9077227dd",
            "newValue": "0x000000000042e7d275642c96221db16500000000037e7abeb10f323aba8755d4"
          },
          "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e2": {
            "previousValue": "0x00000000000000000000010067a12d8000000000000000000000000000000000",
            "newValue": "0x00000000000000000000010067a135ef00000000000000000000000000000000"
          },
          "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e7": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000006be886b",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000704b72f"
          }
        }
      }
    }
  }
}
```