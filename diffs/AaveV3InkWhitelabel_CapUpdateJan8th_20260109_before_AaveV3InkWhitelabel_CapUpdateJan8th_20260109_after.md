## Reserve changes

### Reserves altered

#### USDC ([0x2D270e6886d130D724215A266106e6832161EAEd](https://explorer.inkonchain.com/address/0x2D270e6886d130D724215A266106e6832161EAEd))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 40,000,000 USDC | 80,000,000 USDC |
| borrowCap | 38,000,000 USDC | 76,000,000 USDC |


## Raw diff

```json
{
  "reserves": {
    "0x2D270e6886d130D724215A266106e6832161EAEd": {
      "borrowCap": {
        "from": 38000000,
        "to": 76000000
      },
      "supplyCap": {
        "from": 40000000,
        "to": 80000000
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
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb458": {
          "previousValue": "0x0069612d35000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069612d35000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb459": {
          "previousValue": "0x000000000000000000093a80000000000000698f51b600000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000698f51b600000000000069612d36"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981044": {
          "previousValue": "0x10000000000000000000000000002625a0000243d58003e8a506000000000000",
          "newValue": "0x10000000000000000000000000004c4b40000487ab0003e8a506000000000000"
        }
      }
    }
  }
}
```