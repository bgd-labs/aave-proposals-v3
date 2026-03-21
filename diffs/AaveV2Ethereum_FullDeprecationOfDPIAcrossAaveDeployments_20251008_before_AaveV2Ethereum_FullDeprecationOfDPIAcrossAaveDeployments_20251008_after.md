## Reserve changes

### Reserves altered

#### DPI ([0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b](https://etherscan.io/address/0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x2fe9EcF3024B5A63f50Ec0eFC53b8fF2C09F2E93](https://etherscan.io/address/0x2fe9EcF3024B5A63f50Ec0eFC53b8fF2C09F2E93) | [0x92A6A444f5b433235297d849d2F93B405657234a](https://etherscan.io/address/0x92A6A444f5b433235297d849d2F93B405657234a) |
| oracleDescription | DPI / USD / ETH | Fixed DPI/ETH |
| oracleLatestAnswer | 0.023055563997506188 | 0.022767 |
| interestRateStrategy | [0x6855E5544Cd803BF24c9612b3F12C009116B0ee1](https://etherscan.io/address/0x6855E5544Cd803BF24c9612b3F12C009116B0ee1) | [0x23A6A30F7301607b9bf0a577b0DDBD07920260C7](https://etherscan.io/address/0x23A6A30F7301607b9bf0a577b0DDBD07920260C7) |
| variableRateSlope2 | 300 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=200000000000000000000000000&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=200000000000000000000000000&maxVariableBorrowRate=undefined) |

## Raw diff

```json
{
  "reserves": {
    "0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b": {
      "interestRateStrategy": {
        "from": "0x6855E5544Cd803BF24c9612b3F12C009116B0ee1",
        "to": "0x23A6A30F7301607b9bf0a577b0DDBD07920260C7"
      },
      "oracle": {
        "from": "0x2fe9EcF3024B5A63f50Ec0eFC53b8fF2C09F2E93",
        "to": "0x92A6A444f5b433235297d849d2F93B405657234a"
      },
      "oracleDescription": {
        "from": "DPI / USD / ETH",
        "to": "Fixed DPI/ETH"
      },
      "oracleLatestAnswer": {
        "from": "23055563997506188",
        "to": "22767000000000000"
      }
    }
  },
  "strategies": {
    "0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b": {
      "address": {
        "from": "0x6855E5544Cd803BF24c9612b3F12C009116B0ee1",
        "to": "0x23A6A30F7301607b9bf0a577b0DDBD07920260C7"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x23a6a30f7301607b9bf0a577b0ddbd07920260c7": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 0,
        "newValue": 1
      },
      "stateDiff": {}
    },
    "0x7d2768de32b0b80b7a3454c06bdac94a69ddc7a9": {
      "label": "AaveV2Ethereum.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x4af58fad28e98f61df3b6713681f65b3090016272a366ba32bf8b0ecb0ee2ed8": {
          "previousValue": "0x00000000000000000000001c6855e5544cd803bf24c9612b3f12c009116b0ee1",
          "newValue": "0x00000000000000000000001c23a6a30f7301607b9bf0a577b0ddbd07920260c7"
        }
      }
    },
    "0xa50ba011c48153de246e5192c8f9258a2ba79ca9": {
      "label": "AaveV2Ethereum.ORACLE, AaveV2EthereumAMM.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xef336164d1d189e05c2770d7ba6ea4c2f55cc42e7f22b030cc2fddeb5a97f468": {
          "previousValue": "0x0000000000000000000000002fe9ecf3024b5a63f50ec0efc53b8ff2c09f2e93",
          "newValue": "0x00000000000000000000000092a6a444f5b433235297d849d2f93b405657234a"
        }
      }
    },
    "0xbd37610bbb1ddc2a22797f7e3f531b59902b7ba7": {
      "label": "AaveV2Ethereum.RATES_FACTORY",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 61,
        "newValue": 62
      },
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000002": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000003c",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000003d"
        },
        "0x405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5b0a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000023a6a30f7301607b9bf0a577b0ddbd07920260c7"
        },
        "0xe6930b66b5cb357f2c5382d16c228461c587129175dd3aca675d29ad21c5016f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000023a6a30f7301607b9bf0a577b0ddbd07920260c7"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x78a490f9ac7d685a066fa9c72749346f16fcd05d52774402954f8f78c000cd3d": {
          "previousValue": "0x0068e666de000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068e666de000000000003000000000000000000000000000000000000000000"
        },
        "0x78a490f9ac7d685a066fa9c72749346f16fcd05d52774402954f8f78c000cd3e": {
          "previousValue": "0x000000000000000000093a8000000000000069148b5f00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069148b5f00000000000068e666df"
        }
      }
    },
    "0xe20c172cc966db632af50d8740583b091c8ced80": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": {
        "previousValue": 61,
        "newValue": 62
      },
      "stateDiff": {}
    }
  }
}
```