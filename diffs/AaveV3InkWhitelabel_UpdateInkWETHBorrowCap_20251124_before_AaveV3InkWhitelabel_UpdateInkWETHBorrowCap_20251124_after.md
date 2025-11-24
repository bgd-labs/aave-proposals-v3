## Reserve changes

### Reserves altered

#### WETH (0x4200000000000000000000000000000000000006)

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 10,000 WETH | 20,000 WETH |


## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "borrowCap": {
        "from": 10000,
        "to": 20000
      }
    }
  },
  "raw": {
    "0x1de9cb9420dd1f2ccefff9393e126b800d413b7a": {
      "label": "GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772465": {
          "previousValue": "0x006924b067000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006924b067000000000003000000000000000000000000000000000000000000"
        },
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772466": {
          "previousValue": "0x000000000000000000093a800000000000006952d4e800000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006952d4e80000000000006924b068"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade": {
          "previousValue": "0x100000000000000000000003e8000009c4000000271005dc851229fe206c1f40",
          "newValue": "0x100000000000000000000003e8000009c40000004e2005dc851229fe206c1f40"
        }
      }
    }
  }
}
```