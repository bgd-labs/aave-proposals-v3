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



### EMode: LBTC_WBTC(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | LBTC / WBTC | LBTC_WBTC |
| eMode.ltv (unchanged) | 84 % | 84 % |
| eMode.liquidationThreshold (unchanged) | 86 % | 86 % |
| eMode.liquidationBonus (unchanged) | 3 % | 3 % |
| eMode.borrowableBitmap (unchanged) | WBTC | WBTC |
| eMode.collateralBitmap (unchanged) | LBTC | LBTC |


### EMode: LBTC_cbBTC(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | LBTC_cbBTC |
| eMode.ltv | - | 84 % |
| eMode.liquidationThreshold | - | 86 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | cbBTC |
| eMode.collateralBitmap | - | LBTC |


### EMode: LBTC_tBTC(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | LBTC_tBTC |
| eMode.ltv | - | 84 % |
| eMode.liquidationThreshold | - | 86 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | tBTC |
| eMode.collateralBitmap | - | LBTC |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "label": {
        "from": "LBTC / WBTC",
        "to": "LBTC_WBTC"
      }
    },
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "17179869184",
        "collateralBitmap": "137438953472",
        "eModeCategory": 5,
        "label": "LBTC_cbBTC",
        "liquidationBonus": 10300,
        "liquidationThreshold": 8600,
        "ltv": 8400
      }
    },
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "8589934592",
        "collateralBitmap": "137438953472",
        "eModeCategory": 6,
        "label": "LBTC_tBTC",
        "liquidationBonus": 10300,
        "liquidationThreshold": 8600,
        "ltv": 8400
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
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4c4254435f744254430000000000000000000000000000000000000000000012"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000200000000"
        },
        "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1b": {
          "previousValue": "0x100000000000000000000003e800000089800000011307d0851229fe1e781c84",
          "newValue": "0x100000000000000000000003e80000008980000001131388851229fe1e781c84"
        },
        "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1c": {
          "previousValue": "0x0000000000000be47dfae2e52d5a675200000000033b3d10205acac2acde31c7",
          "newValue": "0x000000000000042e5473acedee7e5b9b00000000033b3d107f43a1fca0b3af62"
        },
        "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1d": {
          "previousValue": "0x00000000000210f9f9385539467afe1b00000000033bcfdfe8e3ed2c25984a6c",
          "newValue": "0x000000000001298ca1f3761220b9b37b00000000033bcff0695c821777da5a3d"
        },
        "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d1e": {
          "previousValue": "0x00000000000000000000210067c1bbb300000000000000000000000000000000",
          "newValue": "0x00000000000000000000210067c1cab300000000000000000000000000000000"
        },
        "0x392c0c0c73cb5e05233b1c77b0479a574c988ddf1c183c2c908a622e3cad9d23": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000e07c76281101",
          "newValue": "0x0000000000000000000000000000000000000000000000000000e20c60807f4d"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4c4254435f636242544300000000000000000000000000000000000000000014"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000400000000"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0",
          "newValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
          "previousValue": "0x4c425443202f2057425443000000000000000000000000000000000000000016",
          "newValue": "0x4c4254435f574254430000000000000000000000000000000000000000000012"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df7": {
          "previousValue": "0x100000000000000000000003e80000032c80000002d007d0850829fe1e781c84",
          "newValue": "0x100000000000000000000003e80000032c80000002d01388850829fe1e781c84"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df8": {
          "previousValue": "0x000000000000176c12029c9cb58e3f1e00000000033b47ee01198b7d4b54ad9b",
          "newValue": "0x000000000000083bfe69195bfaaabd9100000000033b47ee2265a69833aa2338"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df9": {
          "previousValue": "0x000000000002e65b290be207ee0cd3b400000000033c40ee598af44ec6a0b96e",
          "newValue": "0x000000000001a193491662455646cc2300000000033c40f27a20e43535b895c2"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dfa": {
          "previousValue": "0x00000000000000000000220067c1c80700000000000000000000000000000000",
          "newValue": "0x00000000000000000000220067c1cab300000000000000000000000000000000"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dff": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000004e613",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000004e7f6"
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
        "0xdb5a2db10d299abfdf9968d85d61bf8e452bb889fd7e81fef8587501508dee83": {
          "previousValue": "0x0067c1cab2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067c1cab2000000000003000000000000000000000000000000000000000000"
        },
        "0xdb5a2db10d299abfdf9968d85d61bf8e452bb889fd7e81fef8587501508dee84": {
          "previousValue": "0x000000000000000000093a8000000000000067efef3300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067efef3300000000000067c1cab3"
        }
      }
    }
  }
}
```