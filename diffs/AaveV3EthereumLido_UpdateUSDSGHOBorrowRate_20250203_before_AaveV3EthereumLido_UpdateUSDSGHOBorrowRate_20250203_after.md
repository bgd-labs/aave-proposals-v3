## Reserve changes

### Reserve altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 60.5 % | 59 % |
| baseVariableBorrowRate | 8 % | 6.5 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=80000000000000000000000000&maxVariableBorrowRate=605000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=25000000000000000000000000&variableRateSlope2=500000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=65000000000000000000000000&maxVariableBorrowRate=590000000000000000000000000) |

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 46.5 % | 44.5 % |
| variableRateSlope1 | 10.75 % | 8.75 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=107500000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=465000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=87500000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=7500000000000000000000000&maxVariableBorrowRate=445000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "baseVariableBorrowRate": {
        "from": "80000000000000000000000000",
        "to": "65000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "605000000000000000000000000",
        "to": "590000000000000000000000000"
      }
    },
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "maxVariableBorrowRate": {
        "from": "465000000000000000000000000",
        "to": "445000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "107500000000000000000000000",
        "to": "87500000000000000000000000"
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
      "0x18577f0f4a0b2ee6f4048db51c7acd8699f97db8": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x2d9fe18b6c35fe439cc15d932cc5c943bf2d901e": {
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
            "previousValue": "0x0067a0fb8a000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a0fb8a000000000003000000000000000000000000000000000000000000"
          },
          "0xd08b16358b83ce3047f6f93a142c6ab9489e40fd58374e54136e9cd21dc93b2a": {
            "previousValue": "0x000000000000000000093a8000000000000067cf200b00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf200b00000000000067a0fb8b"
          }
        }
      },
      "0x8958b1c39269167527821f8c276ef7504883f2fa": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x8172978433a0fcf5efd57c53d724a94f303cc6b76aee037f692f7050f5d07c5d": {
            "previousValue": "0x00000000000000000000000000000000000000000dac000004330000004b23f0",
            "newValue": "0x00000000000000000000000000000000000000000dac0000036b0000004b23f0"
          },
          "0x8464d39f2e013f742832d01b64507041c699fe53e2b530f6afd3f7345d1a56ff": {
            "previousValue": "0x00000000000000000000000000000000000000001388000000fa0000032023f0",
            "newValue": "0x00000000000000000000000000000000000000001388000000fa0000028a23f0"
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
      "0xf5b4664cb6d13189345119c60a948cdc7785d0fe": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c4": {
            "previousValue": "0x00000000001b7f36726d26f0016edff7000000000348ec7bbbe0a17c2234eac7",
            "newValue": "0x000000000016eedf197fd121adcc7c90000000000348eda8e18a6601fd8372c9"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c5": {
            "previousValue": "0x0000000000398827217d3275b202f80a00000000034f86b312a93ecf357d9d4f",
            "newValue": "0x00000000002ffb90ba956c806839a37000000000034f892e1d33d4dcc27df8ba"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c6": {
            "previousValue": "0x00000000000000000000020067a0e74b00000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a0fb8b00000000000000000000000000000000"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550cb": {
            "previousValue": "0x0000000000000000000000000000000000000000000000dcecb35c1bb597ef97",
            "newValue": "0x0000000000000000000000000000000000000000000000e1cc13d4d502c089ac"
          },
          "0xfd2dab4be6d07bba0109696859cf3ea9f610b92569d2a062e705af4b9c58ff17": {
            "previousValue": "0x0000000000064403b980176d60e6ea7e00000000033bfe7cfcbf7edd507a7b46",
            "newValue": "0x00000000000521598af7cc78850b0be900000000033bff37bc08c8c2b42df7ea"
          },
          "0xfd2dab4be6d07bba0109696859cf3ea9f610b92569d2a062e705af4b9c58ff18": {
            "previousValue": "0x00000000004475d36e4885d3d117ec1000000000034545a9c112bd3170e41120",
            "newValue": "0x0000000000380d78dc947f92489ed1d50000000003454db9196bde6d7650b3a7"
          },
          "0xfd2dab4be6d07bba0109696859cf3ea9f610b92569d2a062e705af4b9c58ff19": {
            "previousValue": "0x00000000000000000000060067a0c39300000000000000000000000000000000",
            "newValue": "0x00000000000000000000060067a0fb8b00000000000000000000000000000000"
          },
          "0xfd2dab4be6d07bba0109696859cf3ea9f610b92569d2a062e705af4b9c58ff1e": {
            "previousValue": "0x0000000000000000000000000000000000000000000000056669ed61968f3ee7",
            "newValue": "0x000000000000000000000000000000000000000000000005bbd617426c25ea17"
          }
        }
      }
    }
  }
}
```