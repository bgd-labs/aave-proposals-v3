## Reserve changes

### Reserves altered

#### USTB ([0x43415eB6ff9DB7E26A15b704e7A3eDCe97d31C4e](https://etherscan.io/address/0x43415eB6ff9DB7E26A15b704e7A3eDCe97d31C4e))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 6,000,000 USTB | 8,000,000 USTB |


## Raw diff

```json
{
  "reserves": {
    "0x43415eB6ff9DB7E26A15b704e7A3eDCe97d31C4e": {
      "supplyCap": {
        "from": 6000000,
        "to": 8000000
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
        "0x11567aab4cd72d4842d11c42514ff879ac1d304b8bb2969ce8bddb1f43474e61": {
          "previousValue": "0x100000000000000000000000000005b8d8000000000000000106283c23282260",
          "newValue": "0x100000000000000000000000000007a120000000000000000106283c23282260"
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
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000031",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000032"
        }
      }
    }
  }
}
```