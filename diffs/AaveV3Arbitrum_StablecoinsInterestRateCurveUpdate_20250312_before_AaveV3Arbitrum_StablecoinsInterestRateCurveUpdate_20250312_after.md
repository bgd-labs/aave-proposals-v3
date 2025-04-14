## Reserve changes

### Reserve altered

#### FRAX ([0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59 % | 56.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://arbiscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### USD₮0 ([0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9](https://arbiscan.io/address/0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### USDC ([0xaf88d065e77c8cC2239327C5EDb3A432268e5831](https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xaf88d065e77c8cC2239327C5EDb3A432268e5831": {
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
    "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x35cf9ccc5fb50786824d0efe505d33216d9658f34614e7c25f0d5baeb2b0c672": {
          "previousValue": "0x0067d1d098000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1d098000000000003000000000000000000000000000000000000000000"
        },
        "0x35cf9ccc5fb50786824d0efe505d33216d9658f34614e7c25f0d5baeb2b0c673": {
          "previousValue": "0x000000000000000000093a8000000000000067fff51900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067fff51900000000000067d1d099"
        }
      }
    },
    "0x429f16dba3b9e1900087cbaa7b50d38bc60fb73f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x030912f9e45d0d6642728ac097f582a9127c24e3d956414d4c8e57e398cba934": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x0b802dd8ef10b7199d8583a067e6a339f2cdf2c4173b3505e7604a919519a9e8": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000001f40",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000001f40"
        },
        "0x5b9be64bf9cee843a021a73d059f41c67bf33ba01053f7c3baec4bdf7883e3b1": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0x8ab31c90a837d3116d15e74d32c78cb399edadb5a9dcfb2ececb6b4b485a1b38": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xae78f2b883a3575129c34f54e0f7e202891eb6cfba1031d11a7280ef7155b6ee": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0x5d557b07776d12967914379c71a1310e917c7555": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5e76e98e0963ecdc6a065d1435f84065b7523f39": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7f775bb7af2e7e09d5dc9506c95516159a5ca0d0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x231517525e76b52ef0565e25ae6e726ef61fa7481dd09cfc0b1bb129c697db6a": {
          "previousValue": "0x00000000001c9781151e0ed7e7149d770000000003a45ced5dd7c1420b70d8b1",
          "newValue": "0x000000000014a66e82046cb109f8e0ac0000000003a46130c22ab93420daa182"
        },
        "0x231517525e76b52ef0565e25ae6e726ef61fa7481dd09cfc0b1bb129c697db6b": {
          "previousValue": "0x0000000000365f4151047ee4b732d42b0000000003cda64ed7e845ef2cae1667",
          "newValue": "0x00000000002744e9927b5fff39e6ccd50000000003cdaec63fa1e883d46973cf"
        },
        "0x231517525e76b52ef0565e25ae6e726ef61fa7481dd09cfc0b1bb129c697db6c": {
          "previousValue": "0x000000000000000000000d0067d190f100000000000000000000000000000000",
          "newValue": "0x000000000000000000000d0067d1d09900000000000000000000000000000000"
        },
        "0x231517525e76b52ef0565e25ae6e726ef61fa7481dd09cfc0b1bb129c697db71": {
          "previousValue": "0x000000000000000000000000000000000000000000000000222577812beb1129",
          "newValue": "0x000000000000000000000000000000000000000000000000318098e3cb6a0c7e"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e85": {
          "previousValue": "0x0000000000185ea47e0aa8bb63fb43ea0000000003964049ddda2f5868aec2d0",
          "newValue": "0x00000000001199b96e6ce5e99cf3cd110000000003964159be1bec26a17d484a"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e86": {
          "previousValue": "0x0000000000353e04f9fe6df5db4dd6b90000000003c99d771bd7964ac5c51328",
          "newValue": "0x00000000002673f1cacd98dffc715f120000000003c99fea5332ca22c28a5f3c"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e87": {
          "previousValue": "0x000000000000000000000b0067d1bdb500000000000000000000000000000000",
          "newValue": "0x000000000000000000000b0067d1d09900000000000000000000000000000000"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e8c": {
          "previousValue": "0x000000000000000000000000000000000000000000000000429c935efb20d6b4",
          "newValue": "0x000000000000000000000000000000000000000000000000498b27d849ccd90f"
        },
        "0x625a1e0785d461c74fd523038876599d0612e2713e0fd72b607e0a293734bc03": {
          "previousValue": "0x00000000001a6cfa496395859c3220220000000003cbe141310e6c430a939145",
          "newValue": "0x00000000001315d1984712f8fca3c9850000000003cbe14e4a2af1bc90ca6d4d"
        },
        "0x625a1e0785d461c74fd523038876599d0612e2713e0fd72b607e0a293734bc04": {
          "previousValue": "0x000000000031484d98997035a3f4631100000000040139687b1c0768d09130f9",
          "newValue": "0x00000000002397c6a01d57da00f030f000000000040139823fb55d51f6b32029"
        },
        "0x625a1e0785d461c74fd523038876599d0612e2713e0fd72b607e0a293734bc05": {
          "previousValue": "0x00000000000000000000050067d1cfce00000000000000000000000000e4454a",
          "newValue": "0x00000000000000000000050067d1d09900000000000000000000000000e4454a"
        },
        "0x625a1e0785d461c74fd523038876599d0612e2713e0fd72b607e0a293734bc0a": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000001c869218",
          "newValue": "0x000000000000000000000000000000000000000000000000000000001ca7cf9a"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479b": {
          "previousValue": "0x000000000016e4ff2531750025d0a8db0000000003b5d0bd4f4a9e7fb75cc337",
          "newValue": "0x00000000001088f372b6c6fa709e7b6d0000000003b5d109934dbf05d0454ad0"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479c": {
          "previousValue": "0x0000000000323ffa32b8de4f7877ba5a0000000003f7a70fc8464582edebddf7",
          "newValue": "0x0000000000244aa8fca62aa3ed362aeb0000000003f7a7c2c6d7a3cc9f3f87ad"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479d": {
          "previousValue": "0x00000000000000000000000067d1cb2500000000000000000301fada6578ce1e",
          "newValue": "0x00000000000000000000000067d1d09900000000000000000301fada6578ce1e"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a947a2": {
          "previousValue": "0x000000000000000000000000000000000000000000000005b6c0fe52d1cc9d2a",
          "newValue": "0x000000000000000000000000000000000000000000000005e65dddaf2b12f562"
        },
        "0xeca9b25e580a9539f66a1e310f07d98e6be14b94407490b048d1fe024e73af50": {
          "previousValue": "0x0000000000186032d68f4a1d3c40ca9a0000000003a26605019ea21d77aa92dc",
          "newValue": "0x0000000000119acf6a530321a54052fe0000000003a26606082b91b45f3bf77e"
        },
        "0xeca9b25e580a9539f66a1e310f07d98e6be14b94407490b048d1fe024e73af51": {
          "previousValue": "0x00000000002f55164e497a462a51b26a0000000003c0d6ee9809a50540389c99",
          "newValue": "0x0000000000222f3acec6a41a1cd694580000000003c0d6f0a68879524fcd7198"
        },
        "0xeca9b25e580a9539f66a1e310f07d98e6be14b94407490b048d1fe024e73af52": {
          "previousValue": "0x000000000000000000000c0067d1d0870000000000000000000000000936d5ad",
          "newValue": "0x000000000000000000000c0067d1d0990000000000000000000000000936d5ad"
        },
        "0xeca9b25e580a9539f66a1e310f07d98e6be14b94407490b048d1fe024e73af57": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000043c29112",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000043c96cfc"
        }
      }
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
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa8669021776bc142dfca87c21b4a52595bcbb40a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf611aeb5013fd2c0511c9cd55c7dc5c1140741a6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xfb00ac187a8eb5afae4eace434f493eb62672df7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```