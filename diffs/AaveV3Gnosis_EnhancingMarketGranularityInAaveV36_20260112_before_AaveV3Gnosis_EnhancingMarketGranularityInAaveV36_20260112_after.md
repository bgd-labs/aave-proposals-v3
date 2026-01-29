## Reserve changes

### Reserve altered

#### WETH ([0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1](https://gnosisscan.io/address/0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wstETH ([0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### sDAI ([0xaf204776c7245bF4147c2612BF6e5972Ee483701](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    }
  },
  "raw": {
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a5": {
          "previousValue": "0x0069644361000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069644361000000000003000000000000000000000000000000000000000000"
        },
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a6": {
          "previousValue": "0x000000000000000000093a80000000000000699267e200000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000699267e200000000000069644362"
        }
      }
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": "AaveV3Gnosis.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x92f844314898b12448ab6e2a1cca9eec63a65c2047adeeaec3e6245d83e31c27": {
          "previousValue": "0x100000000000000000000007d00016e360000000000103e8811229041e781d4c",
          "newValue": "0x100000000000000000000007d00016e360000000000103e8811229041e780000"
        },
        "0xee00b8c53ccd9d92afea2ade430b34dbda7a33b87f08ad29d280d4683a389d07": {
          "previousValue": "0x100000000000000000000103e8000003a9800000009601f4851229681edc1d4c",
          "newValue": "0x100000000000000000000103e8000003a9800000009601f4811229681edc1d4c"
        },
        "0xf377efb019ad32c4e8b988eeeb3b6ac930668f710207fdcf6b231ce4ccfa238a": {
          "previousValue": "0x100000000000000000000103e8000000e1000000096005dc85122968206c1f40",
          "newValue": "0x100000000000000000000103e8000000e1000000096005dc81122968206c1f40"
        }
      }
    }
  }
}
```