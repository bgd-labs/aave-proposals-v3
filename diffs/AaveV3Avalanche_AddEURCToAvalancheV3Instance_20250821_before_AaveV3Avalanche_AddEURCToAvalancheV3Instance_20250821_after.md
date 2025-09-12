## Raw diff

```json
{
  "reserves": {
    "0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD": {
      "from": null,
      "to": {
        "aToken": "0x8a9FdE6925a839F6B1932d16B36aC026F8d3FbdB",
        "aTokenName": "Aave Avalanche EURC",
        "aTokenSymbol": "aAvaEURC",
        "aTokenUnderlyingBalance": "100000000",
        "borrowCap": 2800000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "id": 14,
        "interestRateStrategy": "0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7800,
        "ltv": 7500,
        "oracle": "0x3368310bC4AeE5D96486A73bae8E6b49FcDE62D3",
        "oracleDecimals": 8,
        "oracleDescription": "EURC / USD",
        "oracleLatestAnswer": "117116745",
        "reserveFactor": 1000,
        "supplyCap": 3000000,
        "symbol": "EURC",
        "underlying": "0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x5D557B07776D12967914379C71a1310e917C7555",
        "variableDebtTokenName": "Aave Avalanche Variable Debt EURC",
        "variableDebtTokenSymbol": "variableDebtAvaEURC",
        "virtualBalance": "100000000"
      }
    }
  },
  "strategies": {
    "0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD": {
      "from": null,
      "to": {
        "address": "0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "560000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "500000000000000000000000000"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x048f2228d7bf6776f99ab50cb1b1eab4d1d4ca73": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0x818053ddcf4ca94f9378570d4e8eebd5e9c07bacd404fb6c0dd0b00ca9dc55b3": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
          },
          "0xfddaf3fe0f0428230f0b587264e1de4bd93444bbf0f1586f3980e098f591f4f1": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000ac140648435d03f784879cd789130f22ef588fcd"
          }
        }
      },
      "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
        "label": null,
        "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0xb9c7405fdb60827a063770d15a9163cf3257eafb54d63ebc3245e8170763b9ae": {
            "previousValue": "0x0068c41b06000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0068c41b06000000000003000000000000000000000000000000000000000000"
          },
          "0xb9c7405fdb60827a063770d15a9163cf3257eafb54d63ebc3245e8170763b9af": {
            "previousValue": "0x000000000000000000093a8000000000000068f23f8700000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000068f23f8700000000000068c41b07"
          }
        }
      },
      "0x5793fe4de34532f162b4e207af872729880ec2b6": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": {
          "previousValue": 41,
          "newValue": 43
        },
        "stateDiff": {}
      },
      "0x5d557b07776d12967914379c71a1310e917c7555": {
        "label": null,
        "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
        "balanceDiff": null,
        "nonceDiff": {
          "previousValue": 0,
          "newValue": 1
        },
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000000": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000001": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000035": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x9bfa444531719c27f056280a2c08db888d2a215278d4df74e1efe5279b72a557"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000037": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000c891eb4cbdeff6e073e859e987815ed1505c2acd"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000043"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003c": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x7661726961626c65446562744176614555524300000000000000000000000026"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000006"
          },
          "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000acd1a67bd377c6a4397b486f8b9afabde49b8933"
          },
          "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x41617665204176616c616e636865205661726961626c65204465627420455552"
          },
          "0xbbe3212124853f8b0084a66a2d057c2966e251e132af3691db153ab65f0d1a4e": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x4300000000000000000000000000000000000000000000000000000000000000"
          }
        }
      },
      "0x6e2afd57a161d12f34f416c29619bfeacac8aa18": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": {
          "previousValue": 41,
          "newValue": 43
        },
        "stateDiff": {}
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x00000000000000000000000000000000000000000000000e00000000000009c4",
            "newValue": "0x00000000000000000000000000000000000000000000000f00000000000009c4"
          },
          "0x229f20bcd3cc05a7ee68bb1632cc35b79bb8c7425622671f3831d7287f10cb53": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000c891eb4cbdeff6e073e859e987815ed1505c2acd"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d326f": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x100000000000000000000003e80002dc6c00002ab98003e8850629041e781d4c"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3270": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3271": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000033b2e3c9fd0803ce8000000"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3272": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000e0068c41b0700000000000000000000000000000000"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3273": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000008a9fde6925a839f6b1932d16b36ac026f8d3fbdb"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3275": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000005d557b07776d12967914379c71a1310e917c7555"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3277": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000005f5e10000000000000000000000000000000000"
          },
          "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d3278": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xedc1d953cc6ade74d50e6c6e70d0462e65eb7a20e8c51b7bd12c917f09b11b0a": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000000282aa2a",
            "newValue": "0x000000000000000000000000000000000000000000000000000000002282aa2a"
          }
        }
      },
      "0x8145edddf43f50276641b55bd3ad95944510021e": {
        "label": null,
        "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
        "balanceDiff": null,
        "nonceDiff": {
          "previousValue": 41,
          "newValue": 43
        },
        "stateDiff": {}
      },
      "0x8a9fde6925a839f6b1932d16b36ac026f8d3fbdb": {
        "label": null,
        "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
        "balanceDiff": null,
        "nonceDiff": {
          "previousValue": 0,
          "newValue": 1
        },
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000000": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000004"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000001": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000036": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000037": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x41617665204176616c616e636865204555524300000000000000000000000026"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000038": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x6141766145555243000000000000000000000000000000000000000000000010"
          },
          "0x0000000000000000000000000000000000000000000000000000000000000039": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000006"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003b": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0xf7d886cff6bd92cb2e52f532dba05267869b611c7be84e94fd8f488d8b62b32c"
          },
          "0x000000000000000000000000000000000000000000000000000000000000003d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x000000000000000000000000c891eb4cbdeff6e073e859e987815ed1505c2acd"
          },
          "0x1b0a8b1fefd7a38e70e752f3739d9dc1a8977de346f6e5fbc0ed7b9a89d5fe95": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000033b2e3c9fd0803ce800000000000000000000000000000005f5e100"
          },
          "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000008debe6c7d5b56e09403bdb0ec5cb92506ac462cd"
          }
        }
      },
      "0xc891eb4cbdeff6e073e859e987815ed1505c2acd": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0x3cbe880e3b44f0fb01593f7a53d59f55c2cc106b9e4dc5a33503da994844ae5d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100"
          },
          "0x5e698d9ad4a68fb359a10cfcce1f47bf10a92867d6c80e4a869d36d146859eb6": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xcfee9669af5ae13d1bba1089c67dc421bfba32e654595e48881629acff624766": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000005f5e100",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          }
        }
      },
      "0xce1c5509f2f4d755aa64b8d135b15ec6f12a93da": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0x27f6196beb65e2a2536792fafc4da27a11bd5c7c2b93e982a7b4ef4bc56733a7": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000138800000258000000002328"
          }
        }
      },
      "0xebd36016b3ed09d4693ed4251c67bd858c3c7c9c": {
        "label": null,
        "contract": null,
        "balanceDiff": null,
        "nonceDiff": null,
        "stateDiff": {
          "0x27f6196beb65e2a2536792fafc4da27a11bd5c7c2b93e982a7b4ef4bc56733a7": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000003368310bc4aee5d96486a73bae8e6b49fcde62d3"
          }
        }
      }
    }
  }
}
```