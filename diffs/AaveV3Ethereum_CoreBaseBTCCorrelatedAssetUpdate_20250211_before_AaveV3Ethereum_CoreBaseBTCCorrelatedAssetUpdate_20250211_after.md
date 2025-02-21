## Reserve changes

### Reserve altered

#### tBTC ([0x18084fbA666a33d37592fA2633fD49a74DD93a88](https://etherscan.io/address/0x18084fbA666a33d37592fA2633fD49a74DD93a88))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 304 % | 64 % |
| variableRateSlope2 | 300 % | 60 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=640000000000000000000000000) |

#### cbBTC ([0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf](https://etherscan.io/address/0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 50 % [5000] |
| optimalUsageRatio | 45 % | 80 % |
| maxVariableBorrowRate | 304 % | 64 % |
| variableRateSlope2 | 300 % | 60 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=600000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=640000000000000000000000000) |

## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: BTC_CORRELATED(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | LBTC / WBTC | BTC_CORRELATED |
| eMode.ltv (unchanged) | 84 % | 84 % |
| eMode.liquidationThreshold (unchanged) | 86 % | 86 % |
| eMode.liquidationBonus (unchanged) | 3 % | 3 % |
| eMode.borrowableBitmap | WBTC | WBTC, tBTC, cbBTC |
| eMode.collateralBitmap (unchanged) | LBTC | LBTC |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "borrowableBitmap": {
        "from": "4",
        "to": "25769803780"
      },
      "label": {
        "from": "LBTC / WBTC",
        "to": "BTC_CORRELATED"
      }
    }
  },
  "reserves": {
    "0x18084fbA666a33d37592fA2633fD49a74DD93a88": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    },
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "reserveFactor": {
        "from": 2000,
        "to": 5000
      }
    }
  },
  "strategies": {
    "0x18084fbA666a33d37592fA2633fD49a74DD93a88": {
      "maxVariableBorrowRate": {
        "from": "3040000000000000000000000000",
        "to": "640000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "600000000000000000000000000"
      }
    },
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "maxVariableBorrowRate": {
        "from": "3040000000000000000000000000",
        "to": "640000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "600000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1b": {
            "previousValue": "0x100000000000000000000003e800000089800000011307d0851229fe1e781c84",
            "newValue": "0x100000000000000000000003e80000008980000001131388851229fe1e781c84"
          },
          "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1c": {
            "previousValue": "0x00000000000012979254a0c50b4279b000000000033b3a8b7cefccd8baa94874",
            "newValue": "0x00000000000006894a1235fef6e5935200000000033b3a8ca4c1dea0373d31ff"
          },
          "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1d": {
            "previousValue": "0x0000000000029565e0b6b966444ae9e700000000033bb7021601b7f73eda08b4",
            "newValue": "0x0000000000017409603d560154cafebf00000000033bb72b37c58d28a7059827"
          },
          "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1e": {
            "previousValue": "0x00000000000000000000210067af25ef00000000000000000000000000000000",
            "newValue": "0x00000000000000000000210067af43d700000000000000000000000000000000"
          },
          "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d23": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000d2d917543a93",
            "newValue": "0x0000000000000000000000000000000000000000000000000000d6c6cc012d71"
          },
          "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
            "previousValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0",
            "newValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0"
          },
          "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
            "previousValue": "0x4c425443202f2057425443000000000000000000000000000000000000000016",
            "newValue": "0x4254435f434f5252454c4154454400000000000000000000000000000000001c"
          },
          "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354e": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000004",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000600000004"
          },
          "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df7": {
            "previousValue": "0x100000000000000000000003e80000032c80000002d007d0850829fe1e781c84",
            "newValue": "0x100000000000000000000003e80000032c80000002d01388850829fe1e781c84"
          },
          "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df8": {
            "previousValue": "0x00000000000030adb4b3ae81c0736ba800000000033b458c596584cce084888c",
            "newValue": "0x000000000000111d12063af62197ee0600000000033b458ced8304fb2abc45c8"
          },
          "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df9": {
            "previousValue": "0x0000000000042e34ea83d3af084d6e4f00000000033c200b53e5b49c367b1f02",
            "newValue": "0x00000000000259fdcca4eb778b5735cb00000000033c20180f99255e88f91864"
          },
          "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dfa": {
            "previousValue": "0x00000000000000000000220067af3e1f00000000000000000000000000000000",
            "newValue": "0x00000000000000000000220067af43d700000000000000000000000000000000"
          },
          "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dff": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000086560",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000086b41"
          }
        }
      },
      "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x1df6378d90dbe801fca9d47d5375a5a229ffa4eb34516b72a9e9ff9483681050": {
            "previousValue": "0x0000000000000000000000000000000000000000753000000190000000001194",
            "newValue": "0x0000000000000000000000000000000000000000177000000190000000001f40"
          },
          "0x32feeefce75ce500b7e13282ca15382c6b3ea60fcece07987211390bdef2b0af": {
            "previousValue": "0x0000000000000000000000000000000000000000753000000190000000001194",
            "newValue": "0x0000000000000000000000000000000000000000177000000190000000001f40"
          }
        }
      },
      "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf0": {
            "previousValue": "0x0067af43d6000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067af43d6000000000003000000000000000000000000000000000000000000"
          },
          "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf1": {
            "previousValue": "0x000000000000000000093a8000000000000067dd685700000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067dd685700000000000067af43d7"
          }
        }
      }
    }
  }
}
```