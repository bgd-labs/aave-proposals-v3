## Reserve changes

### Reserves altered

#### JAAA ([0x5a0F93D040De44e78F251b03c43be9CF317Dcf64](https://etherscan.io/address/0x5a0F93D040De44e78F251b03c43be9CF317Dcf64))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 13,000,000 JAAA | 22,000,000 JAAA |


## Raw diff

```json
{
  "reserves": {
    "0x5a0F93D040De44e78F251b03c43be9CF317Dcf64": {
      "supplyCap": {
        "from": 13000000,
        "to": 22000000
      }
    }
  },
  "raw": {
    "0xae05cd22df81871bc7cc2a04becfb516bfe332c8": {
      "label": null,
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x3e3cd529c7fd49079eabd02ec66b1f8c8d0cba5b926a12093d4fd96d7317f0c6": {
          "previousValue": "0x10000000000000000000000000000c65d4000000000000000106290421981fa4",
          "newValue": "0x100000000000000000000000000014fb18000000000000000106290421981fa4"
        }
      }
    },
    "0xe6ec1f0ae6cd023bd0a9b4d0253bdc755103253c": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000005": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000033",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000034"
        }
      }
    }
  }
}
```