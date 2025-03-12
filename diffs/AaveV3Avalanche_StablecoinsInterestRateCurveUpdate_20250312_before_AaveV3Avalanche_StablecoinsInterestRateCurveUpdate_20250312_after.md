## Reserve changes

### Reserve altered

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowtrace.io/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 83.5 % | 81.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=835000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=815000000000000000000000000) |

#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowtrace.io/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowtrace.io/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "maxVariableBorrowRate": {
        "from": "835000000000000000000000000",
        "to": "815000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
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
    "0x5e06b10b3b9c3e1c0996d2544a35b9839be02922": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8195e934be8e1e1e67e36670679242f3eb3fe013d19203686902c1dc42dff3e4": {
          "previousValue": "0x0067d1d4d6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1d4d6000000000003000000000000000000000000000000000000000000"
        },
        "0x8195e934be8e1e1e67e36670679242f3eb3fe013d19203686902c1dc42dff3e5": {
          "previousValue": "0x000000000000000000093a8000000000000067fff95700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067fff95700000000000067d1d4d7"
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
    "0xb7467b66d86ce80cc258f28d266a18a51db7fac8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e54": {
          "previousValue": "0x000000000017a89081846b26f6a9d6920000000003b018df3b32f3dc5c8efc96",
          "newValue": "0x000000000012177dd94a118172ce40790000000003b018e87d7b0e76c7431c7e"
        },
        "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e55": {
          "previousValue": "0x00000000002d5121398e7d6ad6953dae0000000003dc9da3592fdbf804dc3be4",
          "newValue": "0x000000000022a7740895747719dcf5b90000000003dc9db5eb77ac99aafc7ef9"
        },
        "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e56": {
          "previousValue": "0x00000000000000000000020067d1d432000000000000000000000000001e2ca8",
          "newValue": "0x00000000000000000000020067d1d4d7000000000000000000000000001e2ca8"
        },
        "0x2889eaa22747c352a3ff649cf4e08b28f365682fd55aaed4ce267db314fb2e5b": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000012e889ab9",
          "newValue": "0x000000000000000000000000000000000000000000000000000000012ea4cdd4"
        },
        "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0dc": {
          "previousValue": "0x0000000000143a64751d9b62fb3b90cf0000000003a6aa449eb057afbd7de110",
          "newValue": "0x00000000000f7807b466eee1e1ea94990000000003a6acf22c15e6fa5de75d06"
        },
        "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0dd": {
          "previousValue": "0x00000000002de702c156936fc226cec00000000003e0254a6f9ae6f83531d863",
          "newValue": "0x0000000000231a2943047fcb0254899b0000000003e02bbdcfb2de7deb3a3e59"
        },
        "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0de": {
          "previousValue": "0x00000000000000000000000067d19c7600000000000000000364fc6e86ca1940",
          "newValue": "0x00000000000000000000000067d1d4d700000000000000000364fc6e86ca1940"
        },
        "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0e3": {
          "previousValue": "0x000000000000000000000000000000000000000000000017ef16f73d64ae51cd",
          "newValue": "0x000000000000000000000000000000000000000000000018af0de38dc0efd8f1"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a59": {
          "previousValue": "0x000000000019d371419e3f035451bba50000000003f39b5e9354409b4a241e90",
          "newValue": "0x000000000013c0200ad0304a5c7d57640000000003f3a708271b361e00985c4e"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a5a": {
          "previousValue": "0x000000000032382a902bfdc0125d97980000000004382451f376ee5da5dc0e73",
          "newValue": "0x000000000026677e5308e03c94680f640000000004383c8917e43645ddeb13eb"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a5b": {
          "previousValue": "0x00000000000000000000090067d1232800000000000000000000000000000000",
          "newValue": "0x00000000000000000000090067d1d4d700000000000000000000000000000000"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a60": {
          "previousValue": "0x00000000000000000000000000000000000000000000000013c67575892d38c0",
          "newValue": "0x00000000000000000000000000000000000000000000000015f2fa0bb0820f1f"
        },
        "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d1": {
          "previousValue": "0x000000000017407bd69e42a0841c755f0000000003c03a3d370c2e0a2b6a19cc",
          "newValue": "0x000000000011c7e6a92cbd18d68fb2340000000003c03a4b680d281f209c6b5b"
        },
        "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d2": {
          "previousValue": "0x00000000002ced042e9816e54ec84e100000000003f2aa70922bea2496ce679f",
          "newValue": "0x0000000000225ae57f4a56f0e3bc23010000000003f2aa8d6e5995fab7627f64"
        },
        "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d3": {
          "previousValue": "0x00000000000000000000050067d1d3da000000000000000000000000000af47e",
          "newValue": "0x00000000000000000000050067d1d4d7000000000000000000000000000af47e"
        },
        "0xc57f56f849ad32bb472c0d67ed5e500cf239272111ef73c3733c2f26d95801d8": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000c851d9e1",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000c86e5a40"
        },
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e50": {
          "previousValue": "0x00000000000f2a3894aa8a79d8faff39000000000341db3dbfa8bffb50055ed5",
          "newValue": "0x00000000000b98cfa7f0c2539d37f747000000000341dcc0f33b9a3a7c939ea8"
        },
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e51": {
          "previousValue": "0x000000000024481b8b7807af27a855cb000000000345198fd5ab717576aa4205",
          "newValue": "0x00000000001bbebc28fbd0fdcec0a06a0000000003451d31d091206476a63069"
        },
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e52": {
          "previousValue": "0x000000000000000000000c0067d1a53b00000000000000000000000000000000",
          "newValue": "0x000000000000000000000c0067d1d4d700000000000000000000000000000000"
        },
        "0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e57": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000022111b604",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000221886fea"
        }
      }
    },
    "0xce1c5509f2f4d755aa64b8d135b15ec6f12a93da": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x407d49b714d2f7c89e1ec857f4e9a88b01552ae9d3f4dfe83781337ef2c8403a": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x5168043d85dd693fa85d213a5a3e1191de7379a93c3c6faae63171fb25d4db0e": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x6d5cd3b71e09b061445794b4d555aeb5e8ae0d193d0bb5800c86e86e3c7de839": {
          "previousValue": "0x00000000000000000000000000000000000000001d4c00000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000001d4c0000028a000000002328"
        },
        "0x77a72eeb7b26d7d784b9b048cde6315746a8d5d947824e5d85df4e64d068d9e1": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xce4b940e880c89863c2e445fce964b180851cd1fa4485218bbe7309de5adec2e": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0xdc1fad70953bb3918592b6fcc374fe05f5811b6a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
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
```