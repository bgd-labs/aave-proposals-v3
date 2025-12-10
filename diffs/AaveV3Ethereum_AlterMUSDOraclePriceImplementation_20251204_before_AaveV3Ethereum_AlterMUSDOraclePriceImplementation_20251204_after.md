## Reserve changes

### Reserves altered

#### mUSD ([0xacA92E438df0B2401fF60dA7E4337B687a2435DA](https://etherscan.io/address/0xacA92E438df0B2401fF60dA7E4337B687a2435DA))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1 mUSD | 5,000,000 mUSD |
| borrowCap | 1 mUSD | 4,500,000 mUSD |
| oracle | [0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312](https://etherscan.io/address/0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312) | [0x8adb5187695F773513dEC4b569d21db0341931dA](https://etherscan.io/address/0x8adb5187695F773513dEC4b569d21db0341931dA) |
| oracleDescription | Capped mUSD / USD | Fixed mUSD/USD |
| oracleLatestAnswer | 0.99991087 | 1 |


## Raw diff

```json
{
  "reserves": {
    "0xacA92E438df0B2401fF60dA7E4337B687a2435DA": {
      "borrowCap": {
        "from": 1,
        "to": 4500000
      },
      "oracle": {
        "from": "0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312",
        "to": "0x8adb5187695F773513dEC4b569d21db0341931dA"
      },
      "oracleDescription": {
        "from": "Capped mUSD / USD",
        "to": "Fixed mUSD/USD"
      },
      "oracleLatestAnswer": {
        "from": "99991087",
        "to": "100000000"
      },
      "supplyCap": {
        "from": 1,
        "to": 5000000
      }
    }
  },
  "raw": {
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x29e584c5354ca771221778db82a5682af19153c4df2cf4defc029245284380f7": {
          "previousValue": "0x000000000000000000000000f22de319901c3b9baec7fa14fdf013ede40e7312",
          "newValue": "0x0000000000000000000000008adb5187695f773513dec4b569d21db0341931da"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x8f5b7ec3ba0b1a1f62932bfdeda70f16d3201a6d4c63c0fe7837c42a195e39b2": {
          "previousValue": "0x1000000000000000000000000000000000100000000107d08506000000000000",
          "newValue": "0x100000000000000000000000000004c4b4000044aa2007d08506000000000000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xc2f95515cd605887ba0ce1eb52fa05042c3e99698fb4e343a21c15736a9dbf72": {
          "previousValue": "0x0069314ea2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069314ea2000000000003000000000000000000000000000000000000000000"
        },
        "0xc2f95515cd605887ba0ce1eb52fa05042c3e99698fb4e343a21c15736a9dbf73": {
          "previousValue": "0x000000000000000000093a80000000000000695f732300000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695f732300000000000069314ea3"
        }
      }
    }
  }
}
```