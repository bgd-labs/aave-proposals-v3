## Reserve changes

### Reserve altered

#### USDC.e ([0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0](https://gnosisscan.io/address/0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 USDC.e | 12,000,000 USDC.e |
| borrowCap | 1 USDC.e | 11,000,000 USDC.e |


#### WETH ([0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1](https://gnosisscan.io/address/0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 WETH | 3,600 WETH |
| borrowCap | 1 WETH | 2,400 WETH |


#### wstETH ([0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 wstETH | 150,000 wstETH |
| borrowCap | 1 wstETH | 150 wstETH |


#### GNO ([0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb](https://gnosisscan.io/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 GNO | 140,000 GNO |
| borrowCap | 1 GNO | 20,000 GNO |


#### sDAI ([0xaf204776c7245bF4147c2612BF6e5972Ee483701](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 sDAI | 24,000,000 sDAI |
| borrowCap | 0 sDAI | 1 sDAI |


#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 1 EURe | 22,500,000 EURe |


#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 WXDAI | 4,000,000 WXDAI |
| borrowCap | 1 WXDAI | 3,700,000 WXDAI |


#### GHO ([0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://gnosisscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 GHO | 1,500,000 GHO |
| borrowCap | 1 GHO | 1,400,000 GHO |


## Raw diff

```json
{
  "reserves": {
    "0x2a22f9c3b484c3629090FeED35F17Ff8F88f76F0": {
      "borrowCap": {
        "from": 1,
        "to": 11000000
      },
      "supplyCap": {
        "from": 1,
        "to": 12000000
      }
    },
    "0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1": {
      "borrowCap": {
        "from": 1,
        "to": 2400
      },
      "supplyCap": {
        "from": 1,
        "to": 3600
      }
    },
    "0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6": {
      "borrowCap": {
        "from": 1,
        "to": 150
      },
      "supplyCap": {
        "from": 1,
        "to": 150000
      }
    },
    "0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb": {
      "borrowCap": {
        "from": 1,
        "to": 20000
      },
      "supplyCap": {
        "from": 1,
        "to": 140000
      }
    },
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "borrowCap": {
        "from": 0,
        "to": 1
      },
      "supplyCap": {
        "from": 1,
        "to": 24000000
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "borrowCap": {
        "from": 1,
        "to": 22500000
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "borrowCap": {
        "from": 1,
        "to": 3700000
      },
      "supplyCap": {
        "from": 1,
        "to": 4000000
      }
    },
    "0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73": {
      "borrowCap": {
        "from": 1,
        "to": 1400000
      },
      "supplyCap": {
        "from": 1,
        "to": 1500000
      }
    }
  },
  "raw": {
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xfc869d08d1790d4602743c5b6e4adb33c74c1d0d7c8c47359779d859193dcb05": {
          "previousValue": "0x00690c5016000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00690c5016000000000003000000000000000000000000000000000000000000"
        },
        "0xfc869d08d1790d4602743c5b6e4adb33c74c1d0d7c8c47359779d859193dcb06": {
          "previousValue": "0x000000000000000000093a80000000000000693a749700000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000693a7497000000000000690c5017"
        }
      }
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": "AaveV3Gnosis.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0fc8503df98d2edfc22ff983235893ec99bc6e901ad0d1a5f6fe097f182912c8": {
          "previousValue": "0x100000000000000000000003e800000000100000000103e8a50629041e781d4c",
          "newValue": "0x100000000000000000000003e8000b71b00000a7d8c003e8a50629041e781d4c"
        },
        "0x12df0d1b66951018857a1fdeef40de02520a2969b89b7c09c2f52c5e04f1c6d4": {
          "previousValue": "0x100000000000000000000000000019bfcc000000000103e88512000000000000",
          "newValue": "0x100000000000000000000000000019bfcc00015752a003e88512000000000000"
        },
        "0x8afb1de31eb6f791ce338dc0fcf3aabfcff3e4cbb1f6b2d44d14c58685cac66b": {
          "previousValue": "0x100000000000000000000003e800000000100000000107d085122af814b412c0",
          "newValue": "0x100000000000000000000003e80000222e0000004e2007d085122af814b412c0"
        },
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c27": {
          "previousValue": "0x100000000000000000000007d000000000100000000003e8811229041e781d4c",
          "newValue": "0x100000000000000000000007d00016e360000000000103e8811229041e781d4c"
        },
        "0xd65dfe8da0b5a761df1b1a8535b7c5e4a8bdd40bd305a11fa569ad02c896b907": {
          "previousValue": "0x1000000000000000000000000000000000100000000103e88512000000000000",
          "newValue": "0x1000000000000000000000000000016e360000155cc003e88512000000000000"
        },
        "0xdc3a94d7e87a167cb82c63a89cbd0c50a0f30977be246f917292fdacf90d74dd": {
          "previousValue": "0x100000000000000000000007d000000000100000000109c4a51229041e14189c",
          "newValue": "0x100000000000000000000007d00003d090000038752009c4a51229041e14189c"
        },
        "0xee00b8c53ccd9d92afea2ade430b34dbda7a33b87f08ad29d280d4683a389d07": {
          "previousValue": "0x100000000000000000000103e800000000100000000101f4851229681edc1d4c",
          "newValue": "0x100000000000000000000103e80000249f000000009601f4851229681edc1d4c"
        },
        "0xf377efb019ad32c4e8b988eeeb3b6ac930668f710207fdcf6b231ce4ccfa238a": {
          "previousValue": "0x100000000000000000000103e800000000100000000105dc85122968206c1f40",
          "newValue": "0x100000000000000000000103e8000000e1000000096005dc85122968206c1f40"
        }
      }
    }
  }
}
```