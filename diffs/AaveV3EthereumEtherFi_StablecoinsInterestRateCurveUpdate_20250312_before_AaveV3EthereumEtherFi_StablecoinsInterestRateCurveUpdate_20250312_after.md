## Reserve changes

### Reserve altered

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 48.5 % | 46.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=485000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "maxVariableBorrowRate": {
        "from": "485000000000000000000000000",
        "to": "465000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
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
    "0x0aa97c284e98396202b6a04024f5e2c65026f3c0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3ce8e2eb6501d4705477643e96881b1bef6a2db3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x56401d666f486c495566a29249447c2bb8c56bb2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b36": {
          "previousValue": "0x00000000000c4dbaca0f04dfb104ea9a00000000034534b5afb225c704acec79",
          "newValue": "0x0000000000096930ccc80ebca8e0bdda00000000034544ffa3a1d042beed1458"
        },
        "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b37": {
          "previousValue": "0x000000000022a99a7260694533a5c0ec00000000034e808d76e810f2d50095ea",
          "newValue": "0x00000000001a828142982aa14f16935e00000000034eaef504ed7f34d1240c88"
        },
        "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b38": {
          "previousValue": "0x00000000000000000000030067cf4bc700000000000000000000000000000000",
          "newValue": "0x00000000000000000000030067d1c13700000000000000000000000000000000"
        },
        "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b3d": {
          "previousValue": "0x00000000000000000000000000000000000000000000000107b9be07c00088ae",
          "newValue": "0x0000000000000000000000000000000000000000000000019613481fe979e4c3"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf21": {
          "previousValue": "0x000000000013b92a4363f4e6089505ed000000000361c909651d668603b964b0",
          "newValue": "0x00000000000f1558cc4d5b5ada197a25000000000361cf74247fd18090a30f25"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf22": {
          "previousValue": "0x00000000002960b037406000112f5ea200000000036ce83b90ce90b8ece4ec91",
          "newValue": "0x00000000001fa485c27cd381c27a639600000000036cf5de472a532e63a7a7b9"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf23": {
          "previousValue": "0x00000000000000000000010067d12ba300000000000000000000000000ad350c",
          "newValue": "0x00000000000000000000010067d1c13700000000000000000000000000ad350c"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf28": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000072a83b",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000007f166f"
        }
      }
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x5930bb25cb489b555415b7efb12f9cb00a48defc0192276c8118358784264ff9": {
          "previousValue": "0x0067d1c136000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d1c136000000000003000000000000000000000000000000000000000000"
        },
        "0x5930bb25cb489b555415b7efb12f9cb00a48defc0192276c8118358784264ffa": {
          "previousValue": "0x000000000000000000093a8000000000000067ffe5b700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067ffe5b700000000000067d1c137"
        }
      }
    },
    "0x8438f4d29d895d75c86bdc25360c25ef0607e65d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9355032d747f1e08f8720cd01950e652ee15cdb7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xbb077daffeb23b2126e7358b0b122ba6838fb881": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc16666b7ff197427bd255e6961a5f99cfb3a6059": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x27e997bcf7e34b5892c35718d72ca8a4d44f6f77265e19fe4feb6a8ebb16cc7b": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        },
        "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
          "previousValue": "0x00000000000000000000000000000000000000000fa000000352000000002328",
          "newValue": "0x00000000000000000000000000000000000000000fa00000028a000000002328"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xeba440b438ad808101d1c451c1c5322c90befcda": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xfd3ada5aabdc6531c7c2ac46c00ebf870f5a0e6b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```