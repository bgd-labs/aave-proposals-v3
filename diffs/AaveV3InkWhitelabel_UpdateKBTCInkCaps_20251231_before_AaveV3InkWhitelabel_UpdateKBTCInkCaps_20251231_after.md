## Reserve changes

### Reserves altered

#### kBTC ([0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98](https://explorer.inkonchain.com/address/0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1,500 kBTC | 2,750 kBTC |


## Raw diff

```json
{
  "reserves": {
    "0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98": {
      "supplyCap": {
        "from": 1500,
        "to": 2750
      }
    }
  },
  "raw": {
    "0x1de9cb9420dd1f2ccefff9393e126b800d413b7a": {
      "label": "GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x85aaa47b6dc46495bb8824fad4583769726fea36efd831a35556690b830a8fbe": {
          "previousValue": "0x006955826c000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006955826c000000000003000000000000000000000000000000000000000000"
        },
        "0x85aaa47b6dc46495bb8824fad4583769726fea36efd831a35556690b830a8fbf": {
          "previousValue": "0x000000000000000000093a800000000000006983a6ed00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006983a6ed0000000000006955826d"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x52eaf0ef0d5fb4b8b7ab408cae5db0f302f467a5f7642af11e325a225ec359fd": {
          "previousValue": "0x100000000000000000000003e80000005dc0000000c81388850829fe1e141c20",
          "newValue": "0x100000000000000000000003e8000000abe0000000c81388850829fe1e141c20"
        }
      }
    }
  }
}
```