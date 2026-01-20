## Reserve changes

### Reserve altered

#### USD₮0 ([0x0200C29006150606B650577BBE7B6248F58470c1](https://explorer.inkonchain.com/address/0x0200C29006150606B650577BBE7B6248F58470c1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 250,000,000 USD₮0 | 375,000,000 USD₮0 |
| borrowCap | 220,000,000 USD₮0 | 340,000,000 USD₮0 |


#### USDC ([0x2D270e6886d130D724215A266106e6832161EAEd](https://explorer.inkonchain.com/address/0x2D270e6886d130D724215A266106e6832161EAEd))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 80,000,000 USDC | 250,000,000 USDC |
| borrowCap | 76,000,000 USDC | 225,000,000 USDC |


## Raw diff

```json
{
  "reserves": {
    "0x0200C29006150606B650577BBE7B6248F58470c1": {
      "borrowCap": {
        "from": 220000000,
        "to": 340000000
      },
      "supplyCap": {
        "from": 250000000,
        "to": 375000000
      }
    },
    "0x2D270e6886d130D724215A266106e6832161EAEd": {
      "borrowCap": {
        "from": 76000000,
        "to": 225000000
      },
      "supplyCap": {
        "from": 80000000,
        "to": 250000000
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
        "0x2d72af3c1b2b2956e6f694fb741556d5ca9524373974378cdbec16afa8b84164": {
          "previousValue": "0x00696f7743000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00696f7743000000000003000000000000000000000000000000000000000000"
        },
        "0x2d72af3c1b2b2956e6f694fb741556d5ca9524373974378cdbec16afa8b84165": {
          "previousValue": "0x000000000000000000093a80000000000000699d9bc400000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000699d9bc4000000000000696f7744"
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
          "previousValue": "0x10000000000000000000000000004c4b40000487ab0003e8a506000000000000",
          "newValue": "0x1000000000000000000000000000ee6b28000d693a4003e8a506000000000000"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa777": {
          "previousValue": "0x100000000000000000000003e800ee6b28000d1cef0003e8a50628d21e781d4c",
          "newValue": "0x100000000000000000000003e80165a0bc001443fd0003e8a50628d21e781d4c"
        }
      }
    }
  }
}
```