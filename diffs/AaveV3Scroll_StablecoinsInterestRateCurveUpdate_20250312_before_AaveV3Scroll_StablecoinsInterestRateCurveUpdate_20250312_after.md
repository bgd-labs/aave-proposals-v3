## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
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
        "0x37e56e4c2b6ed73b31a7a63e641bfee67245b50921806a650aa65bb58a213ba7": {
          "previousValue": "0x0067d1c140000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c140000000000003000000000000000000000000000000000000000000"
        },
        "0x37e56e4c2b6ed73b31a7a63e641bfee67245b50921806a650aa65bb58a213ba8": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c100000000000067d1c141"
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
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe7e38a47befe9470622b773a1b8c266890363fb8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e0": {
          "previousValue": "0x000000000012fb0f3485c6061463303500000000036ef4ff6a13082263543edd",
          "newValue": "0x00000000000e83c1d0b72c6abe79eaf100000000036ef52b168e892292250390"
        },
        "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e1": {
          "previousValue": "0x000000000028972502a7a74fa8f8f91300000000038596dcc2875bc1f88ead34",
          "newValue": "0x00000000001f0a2cf207f40b736e9ce2000000000385973c8fc3a6249f3f4060"
        },
        "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e2": {
          "previousValue": "0x00000000000000000000010067d1bd2f0000000000000000000000000054cd5a",
          "newValue": "0x00000000000000000000010067d1c1410000000000000000000000000054cd5a"
        },
        "0xf507e1624bb58779977e83531690916e2eea78abad455da12c8f751da22d18e7": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000148974e",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000150fd8b"
        }
      }
    }
  }
}
```