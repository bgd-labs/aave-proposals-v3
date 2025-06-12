## Reserve changes

### Reserves altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 46.5 % | 44.5 % |
| variableRateSlope1 | 11.5 % | 9.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=115000000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=465000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=95000000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=445000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "maxVariableBorrowRate": {
        "from": "465000000000000000000000000",
        "to": "445000000000000000000000000"
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
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
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
      "0x8958b1c39269167527821f8c276ef7504883f2fa": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
            "previousValue": "0x00000000000000000000000000000000000000000dac0000047e0000000023f0",
            "newValue": "0x00000000000000000000000000000000000000000dac000003b60000000023f0"
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
      "0xed90de2d824ee766c6fd22e90b12e598f681dc9f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xf5b4664cb6d13189345119c60a948cdc7785d0fe": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf21": {
            "previousValue": "0x000000000048e546460544234b01c30c00000000034c39d58ce296c6bc6abaa0",
            "newValue": "0x00000000003c37e396a473f2a63a4dd600000000034c3c6f9a69c0121c9dd15d"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf22": {
            "previousValue": "0x00000000005b836cd519cac336e3197700000000035230a6179cce79f3426075",
            "newValue": "0x00000000004b991fba79eba8d740c90600000000035233f02bb26a0486f784b0"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf23": {
            "previousValue": "0x00000000000000000000030067a1251300000000000000000000000000000000",
            "newValue": "0x00000000000000000000030067a135e700000000000000000000000000000000"
          },
          "0xed960c71bd5fa1333658850f076b35ec5565086b606556c3dd36a916b43ddf28": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000009e838ab",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000a450031"
          }
        }
      }
    }
  }
}
```