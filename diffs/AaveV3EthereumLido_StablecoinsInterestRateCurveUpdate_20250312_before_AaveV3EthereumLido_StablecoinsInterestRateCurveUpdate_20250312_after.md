## Reserve changes

### Reserves altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 43.5 % | 41.5 % |
| variableRateSlope1 | 8.5 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=85000000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=435000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=65000000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=415000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "maxVariableBorrowRate": {
        "from": "435000000000000000000000000",
        "to": "415000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "85000000000000000000000000",
        "to": "65000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x013e2c7567b6231e865bb9273f8c7656103611c0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x342631c6cefc9cfbf97b2fe4aa242a236e1fd517": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e59212c34588a63350142efad594a20c88c2ced": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
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
    "0x8958b1c39269167527821f8c276ef7504883f2fa": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
          "previousValue": "0x00000000000000000000000000000000000000000dac000003520000000023f0",
          "newValue": "0x00000000000000000000000000000000000000000dac0000028a0000000023f0"
        }
      }
    },
    "0xc405a0eab071a085a832f876d8e5be7cfeafb624": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf21": {
          "previousValue": "0x00000000001939345daab5f51cacc85000000000035098c702ad44245f28c94b",
          "newValue": "0x00000000001349f6d78ed96a790966230000000003509be014da1e3bca000bce"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf22": {
          "previousValue": "0x00000000002e47c5dffb9c75336fef5b000000000358e13d058b7b1b2220cfcc",
          "newValue": "0x0000000000236427b926f1697dd18ea0000000000358e6fa61ed1170e3ff8e06"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf23": {
          "previousValue": "0x00000000000000000000030067d1879b00000000000000000000000000000000",
          "newValue": "0x00000000000000000000030067d1c13700000000000000000000000000000000"
        },
        "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf28": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000c172470",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000c974f69"
        }
      }
    },
    "0xcfbf336fe147d643b9cb705648500e101504b16d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
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
    "0xed90de2d824ee766c6fd22e90b12e598f681dc9f": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```