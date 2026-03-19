## Reserve changes

### Reserves altered

#### Metis ([0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000](https://explorer.metis.io/address/0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000))

| description | value before | value after |
| --- | --- | --- |
| ltv | 30 % [3000] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000": {
      "ltv": {
        "from": 3000,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2233f8a66a728fba6e1dc95570b25360d07d5524": {
      "label": "GovernanceV3Metis.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x47bd603b2672149df187087e649a417345c22ebc601af252344b2472b5a5fea8": {
          "previousValue": "0x0068fa73de000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068fa73de000000000003000000000000000000000000000000000000000000"
        },
        "0x47bd603b2672149df187087e649a417345c22ebc601af252344b2472b5a5fea9": {
          "previousValue": "0x000000000000000000093a800000000000006928985f00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006928985f00000000000068fa73df"
        }
      }
    },
    "0x90df02551bb792286e8d4f13e0e357b4bf1d6a57": {
      "label": "AaveV3Metis.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xf2b6bcad364da3f80b21ab04ff3a9b042b5d7669746a5fb320b7d0f0c088c3fd": {
          "previousValue": "0x10005f5e1000000000000003e80000927c0000007d0005dc85122af80fa00bb8",
          "newValue": "0x10005f5e1000000000000003e80000927c0000007d0005dc85122af80fa00000"
        }
      }
    }
  }
}
```