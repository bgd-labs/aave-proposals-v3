## Reserve changes

### Reserve altered

#### USDC ([0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59 % | 56.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

#### USDT ([0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 49 % | 46.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=490000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 59 % | 56.5 % |
| variableRateSlope1 | 9 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=90000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=590000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=565000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0x94b008aA00579c1307B0EF2c499aD98a8ce58e58": {
      "maxVariableBorrowRate": {
        "from": "490000000000000000000000000",
        "to": "465000000000000000000000000"
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
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "maxVariableBorrowRate": {
        "from": "590000000000000000000000000",
        "to": "565000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "90000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x04a8d477ee202adce1682f5902e1160455205b12": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4a1c3ad6ed28a636ee1751c69071f6be75deb8b8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5d557b07776d12967914379c71a1310e917c7555": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x746c675dab49bcd5bb9dc85161f2d7eb435009bf": {
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
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479b": {
          "previousValue": "0x00000000001832337f449723263b20a70000000003b1b27804c612864b197539",
          "newValue": "0x000000000011799812e4e9917dbbbfd10000000003b1b29d45319115e87071a2"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479c": {
          "previousValue": "0x000000000033a897797542499ea709730000000003ee75e8cb739655f2ee834e",
          "newValue": "0x0000000000254f193e367c34380cc8170000000003ee763d6fdfdd4304c3cb72"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479d": {
          "previousValue": "0x00000000000000000000000067d1bebb00000000000000000fa3e45480d43bce",
          "newValue": "0x00000000000000000000000067d1c14300000000000000000fa3e45480d43bce"
        },
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a947a2": {
          "previousValue": "0x00000000000000000000000000000000000000000000000185c6d8d9fe8b49e7",
          "newValue": "0x0000000000000000000000000000000000000000000000018c065814167f7f1a"
        },
        "0xa0b8f387d5b8bd1bf8b412b92b699bfd966a963296b1d96813b058460ecb6dee": {
          "previousValue": "0x00000000001dc587e50d683913c199d00000000003cd92952e9b289ce76f3c98",
          "newValue": "0x00000000001580709380417992e889cb0000000003cd929c76c47e42ebac9d2e"
        },
        "0xa0b8f387d5b8bd1bf8b412b92b699bfd966a963296b1d96813b058460ecb6def": {
          "previousValue": "0x0000000000344f373b165f45d43af8fe00000000040233c41384ce0cfdd0d6f1",
          "newValue": "0x000000000025c76f2ebb48c9f1fa383e00000000040233d18ff51aedf4b9aff4"
        },
        "0xa0b8f387d5b8bd1bf8b412b92b699bfd966a963296b1d96813b058460ecb6df0": {
          "previousValue": "0x00000000000000000000050067d1c0df00000000000000000000000000000000",
          "newValue": "0x00000000000000000000050067d1c14300000000000000000000000000000000"
        },
        "0xa0b8f387d5b8bd1bf8b412b92b699bfd966a963296b1d96813b058460ecb6df5": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000402eea8",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000004058553"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb3": {
          "previousValue": "0x00000000000b726a262daefafa2010350000000003bfbea94644a6a6b255f76f",
          "newValue": "0x0000000000084473c719bf30243269f10000000003bfbfe8e391074aa43daae8"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb4": {
          "previousValue": "0x0000000000247d7c62e4a3dcbcace32b00000000040a13bfff5e2474cef3eb7e",
          "newValue": "0x00000000001a5ab1f3ceb2c27dfc4df600000000040a1809c630fe3375c1a919"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb5": {
          "previousValue": "0x00000000000000000000070067d1940700000000000000000000000000000000",
          "newValue": "0x00000000000000000000070067d1c14300000000000000000000000000000000"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cba": {
          "previousValue": "0x000000000000000000000000000000000000000000000000f96174f3e96a7d44",
          "newValue": "0x0000000000000000000000000000000000000000000000015aa4cc8dba588dee"
        },
        "0xb04d9c3bb35d8dd8744332b42a4546444ffef44680d64eb6509bf979fa84d5c6": {
          "previousValue": "0x00000000001fbbd5066923a2e48e306300000000038f9dd73a496f257921248e",
          "newValue": "0x000000000016eb371ff488850853dc0b00000000038f9df322e0a31596e850e8"
        },
        "0xb04d9c3bb35d8dd8744332b42a4546444ffef44680d64eb6509bf979fa84d5c7": {
          "previousValue": "0x0000000000360173fb531da5612dcc180000000003aa279abbaf1f507e9fbed2",
          "newValue": "0x000000000027010d5bddfdd0aeaee43e0000000003aa27cb9c973c4537db676b"
        },
        "0xb04d9c3bb35d8dd8744332b42a4546444ffef44680d64eb6509bf979fa84d5c8": {
          "previousValue": "0x000000000000000000000d0067d1bfc300000000000000000000000000007b8f",
          "newValue": "0x000000000000000000000d0067d1c14300000000000000000000000000007b8f"
        },
        "0xb04d9c3bb35d8dd8744332b42a4546444ffef44680d64eb6509bf979fa84d5cd": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000b0d82c6",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000b28de27"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae96": {
          "previousValue": "0x0000000000120786571d5bb1fcfdbe2e00000000039f716f72716c032b4adfa0",
          "newValue": "0x00000000000d057a60341ca3d0afae3e00000000039f72a2b33f406d431be30c"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae97": {
          "previousValue": "0x00000000002dcba0558527c0b761015a0000000003d7d8385ba6a866868237ac",
          "newValue": "0x000000000021131e60684e2837b247e20000000003d7db7442b5b99d47d88890"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae98": {
          "previousValue": "0x000000000000000000000a0067d1a4b100000000000000000000000000000000",
          "newValue": "0x000000000000000000000a0067d1c14300000000000000000000000000000000"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae9d": {
          "previousValue": "0x00000000000000000000000000000000000000000000000017c43bed21f7b76c",
          "newValue": "0x0000000000000000000000000000000000000000000000001a940ec815b91e0f"
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
    "0x9359282735496463131139875849d5302fb4bed1": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1c7f307829b43601cc9e310d5b7c696a0f5a58e0e5f7e8e14880124f843d7a16": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000001f40",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000001f40"
        },
        "0x8ab31c90a837d3116d15e74d32c78cb399edadb5a9dcfb2ececb6b4b485a1b38": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xd60fa3de876540110dbcbf4325b220f46a9428adfeaf8bd10910c12e372d2c38": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xf540d9affb5b61427f85b916ad3643b26bbc5c478bdd9001a3f8d87e090798f9": {
          "previousValue": "0x0000000000000000000000000000000000000000138800000384000000001f40",
          "newValue": "0x000000000000000000000000000000000000000013880000028a000000001f40"
        },
        "0xfd74717084bb85208713447be2862ba3b9a132ab45002d008b933a2acdff89c3": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000384000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
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
    "0xce186f6cccb0c955445bb9d10c59cae488fea559": {
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
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a5": {
          "previousValue": "0x0067d1c142000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c142000000000003000000000000000000000000000000000000000000"
        },
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a6": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5c300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5c300000000000067d1c143"
        }
      }
    }
  }
}
```