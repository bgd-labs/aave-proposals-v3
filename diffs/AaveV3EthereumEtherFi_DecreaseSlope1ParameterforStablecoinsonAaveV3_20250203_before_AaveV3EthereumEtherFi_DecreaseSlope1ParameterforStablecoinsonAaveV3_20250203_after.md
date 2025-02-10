## Reserve changes

### Reserve altered

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 49.5 % |
| variableRateSlope1 | 12.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 52.5 % | 49.5 % |
| variableRateSlope1 | 12.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=125000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=525000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=495000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "maxVariableBorrowRate": {
        "from": "525000000000000000000000000",
        "to": "495000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "125000000000000000000000000",
        "to": "95000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
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
      "0x3d881c2dc90f00e7a52f06155f77fbec63a779c7": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b36": {
            "previousValue": "0x000000000013bbe7cf01a706f4fda48900000000034380958cd4966d85eef58c",
            "newValue": "0x00000000000efff75e77f11c050f25fa0000000003438a8d814363e12b27dba1"
          },
          "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b37": {
            "previousValue": "0x0000000000353c2355dd2a384feb226f00000000034a08466a79edb336474c99",
            "newValue": "0x00000000002876156d8390d603f5b1c300000000034a2360deafe27164346510"
          },
          "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b38": {
            "previousValue": "0x00000000000000000000030067a0453f00000000000000000000000000000000",
            "newValue": "0x00000000000000000000030067a135e700000000000000000000000000000000"
          },
          "0xd0bb603e19d3221c6caf5b9db7b052f4c1eacec34c11d54cb829f88934d95b3d": {
            "previousValue": "0x000000000000000000000000000000000000000000000001d87fcf6996e89645",
            "newValue": "0x0000000000000000000000000000000000000000000000022fbf49258b284e77"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf21": {
            "previousValue": "0x000000000040924245b3453104f4bc7e00000000035dcb1f2b2691f926c85ac8",
            "newValue": "0x00000000003113ca3c72c9ed902c3cb600000000035de2bd5c1cc8ffc4f64c81"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf22": {
            "previousValue": "0x00000000005ac9f213f3054027b107620000000003663ac988c638f38a54c10d",
            "newValue": "0x000000000045006fb27461d819d2013c0000000003665c527d847dc5bf196a4a"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf23": {
            "previousValue": "0x00000000000000000000010067a08cf700000000000000000000000000000000",
            "newValue": "0x00000000000000000000010067a135e700000000000000000000000000000000"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf28": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000004aebf0",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000059d3a5"
          }
        }
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7222182cb9c5320587b5148bf03eee107ad64578": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xd08b16358b83ce3047f6f93a142c6ab9489e40fd58374e54136e9cd21dc93b29": {
            "previousValue": "0x0067a135e6000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a135e6000000000003000000000000000000000000000000000000000000"
          },
          "0xd08b16358b83ce3047f6f93a142c6ab9489e40fd58374e54136e9cd21dc93b2a": {
            "previousValue": "0x000000000000000000093a8000000000000067cf5a6700000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf5a6700000000000067a135e7"
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
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          },
          "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
            "previousValue": "0x00000000000000000000000000000000000000000fa0000004e2000000002328",
            "newValue": "0x00000000000000000000000000000000000000000fa0000003b6000000002328"
          }
        }
      },
      "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
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
}
```