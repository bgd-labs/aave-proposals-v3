## Reserve changes

### Reserves altered

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 47 % | 44.5 % |
| baseVariableBorrowRate | 11.25 % | 8.75 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=112500000000000000000000000&maxVariableBorrowRate=470000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=7500000000000000000000000&variableRateSlope2=350000000000000000000000000&optimalUsageRatio=920000000000000000000000000&baseVariableBorrowRate=87500000000000000000000000&maxVariableBorrowRate=445000000000000000000000000) |

## Raw diff

```json
{
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "baseVariableBorrowRate": {
        "from": "112500000000000000000000000",
        "to": "87500000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "470000000000000000000000000",
        "to": "445000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x490e0e6255bf65b43e2e02f7acb783c5e04572ff": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7222182cb9c5320587b5148bf03eee107ad64578": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xd08b16358b83ce3047f6f93a142c6ab9489e40fd58374e54136e9cd21dc93b29": {
            "previousValue": "0x0067a0fb4e000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a0fb4e000000000003000000000000000000000000000000000000000000"
          },
          "0xd08b16358b83ce3047f6f93a142c6ab9489e40fd58374e54136e9cd21dc93b2a": {
            "previousValue": "0x000000000000000000093a8000000000000067cf1fcf00000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf1fcf00000000000067a0fb4f"
          }
        }
      },
      "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x8172978433a0fcf5efd57c53d724a94f303cc6b76aee037f692f7050f5d07c5d": {
            "previousValue": "0x00000000000000000000000000000000000000000dac0000004b0000046523f0",
            "newValue": "0x00000000000000000000000000000000000000000dac0000004b0000036b23f0"
          }
        }
      },
      "0xac725cb59d16c81061bdea61041a8a5e73da9ec6": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xef434e4573b90b6ecd4a00f4888381e4d0cc5ccd": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c4": {
            "previousValue": "0x0000000000098f1b0c869ebd1bf1056c000000000349575fc2129bd53d330868",
            "newValue": "0x00000000000773bae911ae35f8ee17800000000003495763270c297261fc61a2"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c5": {
            "previousValue": "0x00000000005dd23a5a0a9b9ae94cb1360000000003569251ae18f98dfbffade8",
            "newValue": "0x0000000000492445a9b56c352b8d19370000000003569273852ab3b46d1e012e"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c6": {
            "previousValue": "0x00000000000000000000230067a0faa700000000000000000000000000000000",
            "newValue": "0x00000000000000000000230067a0fb4f00000000000000000000000000000000"
          },
          "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550cb": {
            "previousValue": "0x00000000000000000000000000000000000000000000005f854157abe28b7b49",
            "newValue": "0x00000000000000000000000000000000000000000000005f9f4059a0dcb1645d"
          }
        }
      }
    }
  }
}
```