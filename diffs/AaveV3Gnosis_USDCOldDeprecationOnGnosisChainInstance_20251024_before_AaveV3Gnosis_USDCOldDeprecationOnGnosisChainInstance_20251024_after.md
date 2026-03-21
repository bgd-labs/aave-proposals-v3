## Reserve changes

### Reserves altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 65 % [6500] | 0 % [0] |
| reserveFactor | 40 % [4000] | 80 % [8000] |


## Raw diff

```json
{
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
      "reserveFactor": {
        "from": 4000,
        "to": 8000
      }
    }
  },
  "raw": {
    "0x7304979ec9e4eaa0273b6a037a31c4e9e5a75d16": {
      "label": "AaveV3Gnosis.POOL_CONFIGURATOR",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x450ae0f7e5f639f52adae3d7f199a4bca9390d20e5a7e4ab17c4bcacd817e828": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001964"
        }
      }
    },
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xc20be026ae5ea792bd28b5908d1dfcfd8c2e447d9276607ddf6143e7dddc0fe8": {
          "previousValue": "0x0068fb3a47000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068fb3a47000000000003000000000000000000000000000000000000000000"
        },
        "0xc20be026ae5ea792bd28b5908d1dfcfd8c2e447d9276607ddf6143e7dddc0fe9": {
          "previousValue": "0x000000000000000000093a8000000000000069295ec800000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069295ec800000000000068fb3a48"
        }
      }
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": "AaveV3Gnosis.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f2768f": {
          "previousValue": "0x100000000000000000000007d00002625a00001e84800fa0a50629041e781964",
          "newValue": "0x100000000000000000000007d00002625a00001e84801f40a70629041e780000"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27690": {
          "previousValue": "0x0000000000205bd4f30a29885b82fa35000000000390fcd602fb2835aff69a47",
          "newValue": "0x00000000000ac9480716498cac312b9a000000000390fd2cd9c6e629efbfef85"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27691": {
          "previousValue": "0x000000000046677dbf0440243716cff00000000003c7f87099d463789bcef1a9",
          "newValue": "0x000000000046678127baf08a840214320000000003c7f938eb4f44e3a7affe58"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27692": {
          "previousValue": "0x00000000000000000000030068fb35b60000000000000000000000000000649a",
          "newValue": "0x00000000000000000000030068fb3a480000000000000000000000000000649a"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27697": {
          "previousValue": "0x00000000000000000000003658f28d0800000000000000000000000001b5dff3",
          "newValue": "0x00000000000000000000003658f28d0800000000000000000000000001c3381c"
        }
      }
    }
  }
}
```