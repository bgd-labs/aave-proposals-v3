## Reserve changes

### Reserves altered

#### mUSD ([0xacA92E438df0B2401fF60dA7E4337B687a2435DA](https://lineascan.build/address/0xacA92E438df0B2401fF60dA7E4337B687a2435DA))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 mUSD | 20,000,000 mUSD |
| borrowCap | 1 mUSD | 18,000,000 mUSD |
| oracle | [0xB8454f3b48395103F23c88B699d4F6A81fD1DCff](https://lineascan.build/address/0xB8454f3b48395103F23c88B699d4F6A81fD1DCff) | [0xA77b1C51a76bbB72D17BF467393a540868103097](https://lineascan.build/address/0xA77b1C51a76bbB72D17BF467393a540868103097) |
| oracleDescription | Capped mUSD / USD | Fixed mUSD/USD |
| oracleLatestAnswer | 0.99984807 | 1 |


## Raw diff

```json
{
  "reserves": {
    "0xacA92E438df0B2401fF60dA7E4337B687a2435DA": {
      "borrowCap": {
        "from": 1,
        "to": 18000000
      },
      "oracle": {
        "from": "0xB8454f3b48395103F23c88B699d4F6A81fD1DCff",
        "to": "0xA77b1C51a76bbB72D17BF467393a540868103097"
      },
      "oracleDescription": {
        "from": "Capped mUSD / USD",
        "to": "Fixed mUSD/USD"
      },
      "oracleLatestAnswer": {
        "from": "99984807",
        "to": "100000000"
      },
      "supplyCap": {
        "from": 1,
        "to": 20000000
      }
    }
  },
  "raw": {
    "0x3bce23a1363728091bc57a58a226cf2940c2e074": {
      "label": "GovernanceV3Linea.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xfc111d09a6e2f0958402cbe16a5aef32c9d8ddb9a4df7271140de57bfed6525a": {
          "previousValue": "0x0069314eb4000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069314eb4000000000003000000000000000000000000000000000000000000"
        },
        "0xfc111d09a6e2f0958402cbe16a5aef32c9d8ddb9a4df7271140de57bfed6525b": {
          "previousValue": "0x000000000000000000093a80000000000000695f733500000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695f733500000000000069314eb5"
        }
      }
    },
    "0xc47b8c00b0f69a36fa203ffeac0334874574a8ac": {
      "label": "AaveV3Linea.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x8f5b7ec3ba0b1a1f62932bfdeda70f16d3201a6d4c63c0fe7837c42a195e39b2": {
          "previousValue": "0x1000000000000000000000000000000000100000000107d08506000000000000",
          "newValue": "0x10000000000000000000000000001312d0000112a88007d08506000000000000"
        }
      }
    },
    "0xcfdada7dcd2e785cf706badbc2b8af5084d595e9": {
      "label": "AaveV3Linea.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x29e584c5354ca771221778db82a5682af19153c4df2cf4defc029245284380f7": {
          "previousValue": "0x000000000000000000000000b8454f3b48395103f23c88b699d4f6a81fd1dcff",
          "newValue": "0x000000000000000000000000a77b1c51a76bbb72d17bf467393a540868103097"
        }
      }
    }
  }
}
```