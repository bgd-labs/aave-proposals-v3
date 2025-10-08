## Reserve changes

### Reserves altered

#### DPI ([0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369](https://polygonscan.com/address/0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x2e48b7924FBe04d575BA229A59b64547d9da16e9](https://polygonscan.com/address/0x2e48b7924FBe04d575BA229A59b64547d9da16e9) | [0x105fe43207CE8331555C9Be8c13718d6DeD2fD97](https://polygonscan.com/address/0x105fe43207CE8331555C9Be8c13718d6DeD2fD97) |
| oracleDescription | DPI / USD | Fixed DPI/USD |
| oracleLatestAnswer | 102.93299299 | 102 |
| liquidationThreshold | 45 % [4500] | 0.05 % [5] |
| maxVariableBorrowRate | 310 % | 70 % |
| baseVariableBorrowRate | 0 % | 20 % |
| variableRateSlope2 | 300 % | 40 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3100000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=100000000000000000000000000&variableRateSlope2=400000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=200000000000000000000000000&maxVariableBorrowRate=700000000000000000000000000) |

## Raw diff

```json
{
  "reserves": {
    "0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369": {
      "liquidationThreshold": {
        "from": 4500,
        "to": 5
      },
      "oracle": {
        "from": "0x2e48b7924FBe04d575BA229A59b64547d9da16e9",
        "to": "0x105fe43207CE8331555C9Be8c13718d6DeD2fD97"
      },
      "oracleDescription": {
        "from": "DPI / USD",
        "to": "Fixed DPI/USD"
      },
      "oracleLatestAnswer": {
        "from": "10293299299",
        "to": "10200000000"
      }
    }
  },
  "strategies": {
    "0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "200000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "3100000000000000000000000000",
        "to": "700000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": "3000000000000000000000000000",
        "to": "400000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x93d1935305b2d38c36a29894407d9e2a1bc6d663aa42bffc7b7c21e606326569": {
          "previousValue": "0x0068e66893000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068e66893000000000003000000000000000000000000000000000000000000"
        },
        "0x93d1935305b2d38c36a29894407d9e2a1bc6d663aa42bffc7b7c21e60632656a": {
          "previousValue": "0x000000000000000000093a8000000000000069148d1400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069148d1400000000000068e66894"
        }
      }
    },
    "0x56076f960980d453b5b749cb6a1c4d2e4e138b1a": {
      "label": "AaveV3Polygon.ASSETS.DAI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.LINK.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WBTC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDT0.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.AAVE.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.WPOL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.CRV.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.SUSHI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.GHST.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.BAL.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.DPI.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURS.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.jEUR.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.EURA.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.miMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.stMATIC.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.MaticX.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.wstETH.INTEREST_RATE_STRATEGY, AaveV3Polygon.ASSETS.USDCn.INTEREST_RATE_STRATEGY",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xeae9db15559877888004a03d5c72c4170b5ba454c0b0169f89dc187bb146ac81": {
          "previousValue": "0x00000000000000000000000000000000000000007530000003e8000000001194",
          "newValue": "0x00000000000000000000000000000000000000000fa0000003e8000007d01194"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xfdae0ec7002c89e3fdc586b7b310cf574e67fe20ce66b3c19fc2b0a374542548": {
          "previousValue": "0x100000000000000000000003e800000058900000030b0dac87122af811940000",
          "newValue": "0x100000000000000000000003e800000058900000030b0dac87122af800050000"
        },
        "0xfdae0ec7002c89e3fdc586b7b310cf574e67fe20ce66b3c19fc2b0a374542549": {
          "previousValue": "0x00000000000f94b58577af6d8b5a5da20000000003c092997fc352a56448724b",
          "newValue": "0x0000000000367cc7fbec2eabca36879a0000000003c0f3b4fe958e28c39ef2cf"
        },
        "0xfdae0ec7002c89e3fdc586b7b310cf574e67fe20ce66b3c19fc2b0a37454254a": {
          "previousValue": "0x000000000042616f83ecac720f5dd48400000000051cf8361ac247a1ea540759",
          "newValue": "0x0000000000e7e35a49a0eb43373847b200000000051f2c74371fd73e68f8d9bb"
        },
        "0xfdae0ec7002c89e3fdc586b7b310cf574e67fe20ce66b3c19fc2b0a37454254b": {
          "previousValue": "0x000000000000000000000c0068dc51fb000000000000000000302eb2eb86a9c2",
          "newValue": "0x000000000000000000000c0068e66894000000000000000000302eb2eb86a9c2"
        },
        "0xfdae0ec7002c89e3fdc586b7b310cf574e67fe20ce66b3c19fc2b0a374542550": {
          "previousValue": "0x000000000000000d183107590822956000000000000000000000000000000000",
          "newValue": "0x000000000000000d1831075908229560000000000000000000f613212894fcd9"
        }
      }
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Polygon.POOL_CONFIGURATOR",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x74e6e47a526bb70812fca30d11337cc62c1d468732fce78e1da7d518f876b1c7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xb023e699f5a33916ea823a16485e259257ca8bd1": {
      "label": "AaveV3Polygon.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xeae9db15559877888004a03d5c72c4170b5ba454c0b0169f89dc187bb146ac81": {
          "previousValue": "0x0000000000000000000000002e48b7924fbe04d575ba229a59b64547d9da16e9",
          "newValue": "0x000000000000000000000000105fe43207ce8331555c9be8c13718d6ded2fd97"
        }
      }
    }
  }
}
```