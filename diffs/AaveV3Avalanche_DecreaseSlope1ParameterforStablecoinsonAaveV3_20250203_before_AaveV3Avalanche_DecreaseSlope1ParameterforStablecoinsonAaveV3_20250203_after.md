## Reserve changes

### Reserve altered

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowtrace.io/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 80.5 % | 84.5 % |
| variableRateSlope1 | 5.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=845000000000000000000000000) |

#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowtrace.io/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52 % | 49.5 % |
| variableRateSlope1 | 12 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=520000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowtrace.io/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52 % | 49.5 % |
| variableRateSlope1 | 12 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=520000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52 % | 49.5 % |
| variableRateSlope1 | 12 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=520000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52 % | 49.5 % |
| variableRateSlope1 | 12 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=120000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=520000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "maxVariableBorrowRate": {
        "from": "805000000000000000000000000",
        "to": "845000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "55000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "maxVariableBorrowRate": {
        "from": "520000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "maxVariableBorrowRate": {
        "from": "520000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "maxVariableBorrowRate": {
        "from": "520000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "maxVariableBorrowRate": {
        "from": "520000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "120000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x34e2ed44ef7466d5f9e0b782b5c08b57475e7907": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x3c06dce358add17aaf230f2234bccc4afd50d090": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5dfb8c777c19d3cedcdc7398d2eef1fb0b9b05c9": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e54": {
            "previousValue": "0x00000000001ec6aa3ea2956b8bf621340000000003ad31749a8e1f84eabab59d",
            "newValue": "0x0000000000185d46eb98d5064492e3ca0000000003ad3177bba12a124209ddf6"
          },
          "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e55": {
            "previousValue": "0x00000000003d6985a13ed877529f17d90000000003d6a20a39bf9121b9020e87",
            "newValue": "0x0000000000309e349994890c501b7e8e0000000003d6a210bea3129751b0c6f6"
          },
          "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e56": {
            "previousValue": "0x00000000000000000000020067a135c100000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a135ec00000000000000000000000000000000"
          },
          "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e5b": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000f57d82c1",
            "newValue": "0x00000000000000000000000000000000000000000000000000000000f586c661"
          },
          "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0dc": {
            "previousValue": "0x000000000035dbd74c5848ded91aa22e0000000003a32b050de1a220d2a0a3db",
            "newValue": "0x00000000002aa36db45e8c28c01e10e80000000003a32ce1b29eb0a10dd57045"
          },
          "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0dd": {
            "previousValue": "0x000000000058fecbd6a8ecb4ee0ad9ad0000000003d8dc7be029f0782309b5cf",
            "newValue": "0x000000000046746ce0dbe5330025a6930000000003d8dfbce4b2f3cc20ba14b6"
          },
          "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0de": {
            "previousValue": "0x00000000000000000000000067a1272500000000000000000000000000000000",
            "newValue": "0x00000000000000000000000067a135ec00000000000000000000000000000000"
          },
          "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0e3": {
            "previousValue": "0x00000000000000000000000000000000000000000000001dde63086b35f78b16",
            "newValue": "0x00000000000000000000000000000000000000000000001e478f52ab3771263b"
          },
          "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a59": {
            "previousValue": "0x0000000000343960602a452b79918e390000000003ef3957f972b3958e6afc6b",
            "newValue": "0x00000000002958bce87107aecbce2cf20000000003ef4e69d8c9febd41f1fc2c"
          },
          "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a5a": {
            "previousValue": "0x000000000054da03d084f01dd583037500000000042fcfad6bd0f1ea423c4f8a",
            "newValue": "0x0000000000432d1f29198c0b535b55d200000000042ff41bbfd861a1f05d5377"
          },
          "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a5b": {
            "previousValue": "0x00000000000000000000090067a0967c00000000000000000000000000000000",
            "newValue": "0x00000000000000000000090067a135ec00000000000000000000000000000000"
          },
          "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a60": {
            "previousValue": "0x0000000000000000000000000000000000000000000000001edbb20a255f239e",
            "newValue": "0x00000000000000000000000000000000000000000000000022ab29113f8b9497"
          },
          "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d1": {
            "previousValue": "0x00000000002823106d231b9dc12be8590000000003bd7b8d7b629a4f703603cc",
            "newValue": "0x00000000001fc66e2fbee3a378610b490000000003bd7ba97b31b0af73acf56c"
          },
          "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d2": {
            "previousValue": "0x00000000004621f8ce11be9df3f598a70000000003ecbb80904512297c9e49d2",
            "newValue": "0x0000000000378590ab9422cba1b87e2c0000000003ecbbb3e6e4fba0ff4171cd"
          },
          "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d3": {
            "previousValue": "0x00000000000000000000050067a134ca00000000000000000000000000000000",
            "newValue": "0x00000000000000000000050067a135ec00000000000000000000000000000000"
          },
          "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d8": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000009db057f9",
            "newValue": "0x000000000000000000000000000000000000000000000000000000009dde04ca"
          },
          "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e50": {
            "previousValue": "0x00000000001ff6b8a6303e405ee878ae00000000033eee7ef0b769a9cb94b5c7",
            "newValue": "0x00000000003735cad1bc3ab9be9034b500000000033eee877b32eab4293f47f5"
          },
          "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e51": {
            "previousValue": "0x00000000002a5ef4afdbc74d33322b540000000003401bed60e28002fcebc275",
            "newValue": "0x0000000000492fa6cd6c885d642ce3ee0000000003401bf8b7609e623e8dcc10"
          },
          "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e52": {
            "previousValue": "0x000000000000000000000c0067a1356c00000000000000000000000000000000",
            "newValue": "0x000000000000000000000c0067a135ec00000000000000000000000000000000"
          },
          "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e57": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000e13e238d",
            "newValue": "0x00000000000000000000000000000000000000000000000000000000e141e054"
          }
        }
      },
      "0x5e06b10b3b9c3e1c0996d2544a35b9839be02922": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xfc869d08d1790d4602743c5b6e4adb33c74c1d0d7c8c47359779d859193dcb05": {
            "previousValue": "0x0067a135eb000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135eb000000000003000000000000000000000000000000000000000000"
          },
          "0xfc869d08d1790d4602743c5b6e4adb33c74c1d0d7c8c47359779d859193dcb06": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6c00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6c00000000000067a135ec"
          }
        }
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8145edddf43f50276641b55bd3ad95944510021e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8619d80fb0141ba7f184cbf22fd724116d9f7ffc": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa0d9c1e9e48ca30c8d8c3b5d69ff5dc1f6dffc24": {
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
      "0xce1c5509f2f4d755aa64b8d135b15ec6f12a93da": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x407d49b714d2f7c89e1ec857f4e9a88b01552ae9d3f4dfe83781337ef2c8403a": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004b0000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0x5168043d85dd693fa85d213a5a3e1191de7379a93c3c6faae63171fb25d4db0e": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004b0000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0x6d5cd3b71e09b061445794b4d555aeb5e8ae0d193d0bb5800c86e86e3c7de839": {
            "previousValue": "0x00000000000000000000000000000000000000001d4c00000226000000002328",
            "newValue": "0x00000000000000000000000000000000000000001d4c000003b6000000002328"
          },
          "0x77a72eeb7b26d7d784b9b048cde6315746a8d5d947824e5d85df4e64d068d9e1": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004b0000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xce4b940e880c89863c2e445fce964b180851cd1fa4485218bbe7309de5adec2e": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004b0000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0xdc1fad70953bb3918592b6fcc374fe05f5811b6a": {
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
}
```