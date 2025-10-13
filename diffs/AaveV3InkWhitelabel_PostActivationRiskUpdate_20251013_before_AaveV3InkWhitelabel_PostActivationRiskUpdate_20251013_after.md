## Reserve changes

### Reserve altered

#### USD₮0 (0x0200C29006150606B650577BBE7B6248F58470c1)

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 190,000,000 USD₮0 | 250,000,000 USD₮0 |
| borrowCap | 6,000,000 USD₮0 | 220,000,000 USD₮0 |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 0 % [0] | 78 % [7800] |
| liquidationBonus | 0 % | 4.5 % |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |
| isBorrowableInIsolation | false | true |


#### WETH (0x4200000000000000000000000000000000000006)

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 32,000 WETH | 40,000 WETH |
| borrowCap | 1,500 WETH | 10,000 WETH |


#### kBTC (0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98)

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 350 kBTC | 1,500 kBTC |
| borrowCap | 10 kBTC | 200 kBTC |


#### USDG (0xe343167631d89B6Ffc58B88d6b7fB0228795491D)

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 20,000,000 USDG | 50,000,000 USDG |
| borrowCap | 1,600,000 USDG | 40,000,000 USDG |
| isBorrowableInIsolation | false | true |


## Raw diff

```json
{
  "reserves": {
    "0x0200C29006150606B650577BBE7B6248F58470c1": {
      "borrowCap": {
        "from": 6000000,
        "to": 220000000
      },
      "isBorrowableInIsolation": {
        "from": false,
        "to": true
      },
      "liquidationBonus": {
        "from": 0,
        "to": 10450
      },
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 7800
      },
      "ltv": {
        "from": 0,
        "to": 7500
      },
      "supplyCap": {
        "from": 190000000,
        "to": 250000000
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "borrowCap": {
        "from": 1500,
        "to": 10000
      },
      "supplyCap": {
        "from": 32000,
        "to": 40000
      }
    },
    "0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98": {
      "borrowCap": {
        "from": 10,
        "to": 200
      },
      "supplyCap": {
        "from": 350,
        "to": 1500
      }
    },
    "0xe343167631d89B6Ffc58B88d6b7fB0228795491D": {
      "borrowCap": {
        "from": 1600000,
        "to": 40000000
      },
      "isBorrowableInIsolation": {
        "from": false,
        "to": true
      },
      "supplyCap": {
        "from": 20000000,
        "to": 50000000
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
        "0xa15bc60c955c405d20d9149c709e2460f1c2d9a497496a7f46004d1772c3054c": {
          "previousValue": "0x0068ecbb61000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068ecbb61000000000003000000000000000000000000000000000000000000"
        },
        "0xa15bc60c955c405d20d9149c709e2460f1c2d9a497496a7f46004d1772c3054d": {
          "previousValue": "0x000000000000000000093a80000000000000691adfe200000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000691adfe200000000000068ecbb62"
        }
      }
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0aa126583ac3a901713d8d5929bc7659f63b33065f64d43f2b2f95ddf3a5abf3": {
          "previousValue": "0x10000000000000000000000000001312d00000186a0003e88506000000000000",
          "newValue": "0x10000000000000000000000000002faf080002625a0003e8a506000000000000"
        },
        "0x52eaf0ef0d5fb4b8b7ab408cae5db0f302f467a5f7642af11e325a225ec359fd": {
          "previousValue": "0x100000000000000000000003e800000015e00000000a1388850829fe1e141c20",
          "newValue": "0x100000000000000000000003e80000005dc0000000c81388850829fe1e141c20"
        },
        "0x7e47f63b8ad37aba97855785563ef3d1cc728913e5cd518cf2e44986d45aa777": {
          "previousValue": "0x1000000000000000000000000000b532b800005b8d8003e88506000000000000",
          "newValue": "0x100000000000000000000003e800ee6b28000d1cef0003e8a50628d21e781d4c"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade": {
          "previousValue": "0x100000000000000000000003e8000007d000000005dc05dc851229fe206c1f40",
          "newValue": "0x100000000000000000000003e8000009c4000000271005dc851229fe206c1f40"
        }
      }
    }
  }
}
```