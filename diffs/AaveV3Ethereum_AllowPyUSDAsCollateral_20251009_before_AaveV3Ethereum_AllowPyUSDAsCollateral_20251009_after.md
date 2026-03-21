## Reserve changes

### Reserves altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 75 % [7500] |


## Raw diff

```json
{
  "reserves": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "ltv": {
        "from": 0,
        "to": 7500
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x5d0932b3bfc1052ccb8f073298333897b875f4c2d9eba20cdc99f93ff1bc1875": {
          "previousValue": "0x100000000000000000000003e8007270e00001c9c38003e8850629fe1e780000",
          "newValue": "0x100000000000000000000003e8007270e00001c9c38003e8850629fe1e781d4c"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xf1b5f43cfd58433d8089d74d4b0d048639a18b3e74e203da03a300c559157a05": {
          "previousValue": "0x0068e7e31e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068e7e31e000000000003000000000000000000000000000000000000000000"
        },
        "0xf1b5f43cfd58433d8089d74d4b0d048639a18b3e74e203da03a300c559157a06": {
          "previousValue": "0x000000000000000000093a800000000000006916079f00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006916079f00000000000068e7e31f"
        }
      }
    }
  }
}
```