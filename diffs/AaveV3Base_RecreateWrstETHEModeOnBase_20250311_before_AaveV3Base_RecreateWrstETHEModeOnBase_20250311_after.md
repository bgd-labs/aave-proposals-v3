## Reserve changes

### Reserve altered

#### wrsETH ([0xEDfa23602D0EC14714057867A78d01e94176BEA0](https://basescan.org/address/0xEDfa23602D0EC14714057867A78d01e94176BEA0))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | true | false |
| ltv | 0 % [0] | 0.05 % [5] |


#### LBTC ([0xecAc9C5F704e954931349Da37F60E39f515c11c1](https://basescan.org/address/0xecAc9C5F704e954931349Da37F60E39f515c11c1))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | true | false |
| ltv | 0 % [0] | 68 % [6800] |


## Emodes changed

### EMode: LBTC_cbBTC(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LBTC_cbBTC | LBTC_cbBTC |
| eMode.ltv (unchanged) | 82 % | 82 % |
| eMode.liquidationThreshold (unchanged) | 84 % | 84 % |
| eMode.liquidationBonus (unchanged) | 3 % | 3 % |
| eMode.borrowableBitmap | wstETH, cbBTC | cbBTC |
| eMode.collateralBitmap | wrsETH, LBTC | LBTC |


### EMode: rsETH/wstETH(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | rsETH/wstETH |
| eMode.ltv | - | 92.5 % |
| eMode.liquidationThreshold | - | 94.5 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | wstETH |
| eMode.collateralBitmap | - | wrsETH |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "borrowableBitmap": {
        "from": "72",
        "to": "64"
      },
      "collateralBitmap": {
        "from": "1536",
        "to": "1024"
      }
    },
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "8",
        "collateralBitmap": "512",
        "eModeCategory": 5,
        "label": "rsETH/wstETH",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9450,
        "ltv": 9250
      }
    }
  },
  "reserves": {
    "0xEDfa23602D0EC14714057867A78d01e94176BEA0": {
      "isFrozen": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 0,
        "to": 5
      }
    },
    "0xecAc9C5F704e954931349Da37F60E39f515c11c1": {
      "isFrozen": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 0,
        "to": 6800
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x319d156ea750b20d5370ef7b348b6ff1ab5d0256": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xa171e6dff2e291b2403638b36fa1900bfb6d28056b9cc28339adf04ff3e24b88": {
          "previousValue": "0x0067d05340000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d05340000000000003000000000000000000000000000000000000000000"
        },
        "0xa171e6dff2e291b2403638b36fa1900bfb6d28056b9cc28339adf04ff3e24b89": {
          "previousValue": "0x000000000000000000093a8000000000000067fe77c100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067fe77c100000000000067d05341"
        }
      }
    },
    "0x43955b0899ab7232e3a454cf84aedd22ad46fd33": {
      "label": "AaveV3Base.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5731a04b1e775f0fdd454bf70f3335886e9a96be": {
      "label": "AaveV3Base.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6ef6b6176091f94a8ad52c08e571f81598b226a2": {
      "label": "AaveV3Base.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x142b8024331e7a0999f0b47d24464879477fb31a681c25e930aab464ba948f9d": {
          "previousValue": "0x100000000000000000000003e8000000190000000001138883082a621c840000",
          "newValue": "0x100000000000000000000003e8000000190000000001138881082a621c841a90"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000200277424ea2422"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x72734554482f7773744554480000000000000000000000000000000000000018"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000008"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000600283c20d02008",
          "newValue": "0x0000000000000000000000000000000000000000000000000400283c20d02008"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000048",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000040"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e693": {
          "previousValue": "0x100000000000000000000003e800000019000000000107d0831229fe000a0000",
          "newValue": "0x100000000000000000000003e800000019000000000107d0811229fe000a0005"
        }
      }
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": "AaveV3Base.ACL_ADMIN, GovernanceV3Base.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe20fcbdbffc4dd138ce8b2e6fbb6cb49777ad64d": {
      "label": "AaveV3Base.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Base.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x64eb02d8950ba2fb73b97a5fa897304583f61bf9bca347f5ed150b8a8ccb0fad": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000001a90",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x694c97bcbe8dc798bf87d58a316d249359700089aa3388332ac48c434021a862": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000005",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    }
  }
}
```
