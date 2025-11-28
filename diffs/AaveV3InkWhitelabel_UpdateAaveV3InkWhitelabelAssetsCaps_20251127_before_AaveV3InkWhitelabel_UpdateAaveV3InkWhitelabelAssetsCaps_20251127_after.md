## Reserve changes

### Reserve altered

#### USDC ([0x2D270e6886d130D724215A266106e6832161EAEd](https://explorer.inkonchain.com/address/0x2D270e6886d130D724215A266106e6832161EAEd))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000,000 USDC | 20,000,000 USDC |
| borrowCap | 9,500,000 USDC | 19,000,000 USDC |


#### WETH ([0x4200000000000000000000000000000000000006](https://explorer.inkonchain.com/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 40,000 WETH | 80,000 WETH |


#### GHO ([0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://explorer.inkonchain.com/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000,000 GHO | 20,000,000 GHO |
| borrowCap | 9,000,000 GHO | 18,000,000 GHO |


## Raw diff

```json
{
  "reserves": {
    "0x2D270e6886d130D724215A266106e6832161EAEd": {
      "borrowCap": {
        "from": 9500000,
        "to": 19000000
      },
      "supplyCap": {
        "from": 10000000,
        "to": 20000000
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "supplyCap": {
        "from": 40000,
        "to": 80000
      }
    },
    "0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73": {
      "borrowCap": {
        "from": 9000000,
        "to": 18000000
      },
      "supplyCap": {
        "from": 10000000,
        "to": 20000000
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
          "previousValue": "0x0069285f11000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069285f11000000000003000000000000000000000000000000000000000000"
        },
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772466": {
          "previousValue": "0x000000000000000000093a800000000000006956839200000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006956839200000000000069285f12"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x3157074825d66a4cd143024ab2f0bc00658082dadc139ee1aba99e9a39981044": {
          "previousValue": "0x1000000000000000000000000000098968000090f56003e8a506000000000000",
          "newValue": "0x10000000000000000000000000001312d0000121eac003e8a506000000000000"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade": {
          "previousValue": "0x100000000000000000000003e8000009c4000000271005dc851229fe206c1f40",
          "newValue": "0x100000000000000000000003e800001388000000271005dc851229fe206c1f40"
        },
        "0xd65dfe8da0b5a761df1b1a8535b7c5e4a8bdd40bd305a11fa569ad02c896b907": {
          "previousValue": "0x1000000000000000000000000000098968000089544003e88512000000000000",
          "newValue": "0x10000000000000000000000000001312d0000112a88003e88512000000000000"
        }
      }
    }
  }
}
```