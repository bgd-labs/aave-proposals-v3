## Reserve changes

### Reserves altered

#### Cake ([0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82](https://bscscan.com/address/0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82))

| description | value before | value after |
| --- | --- | --- |
| ltv | 55 % [5500] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82": {
      "ltv": {
        "from": 5500,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2d97f8fa96886fd923c065f5457f9ddd494e3877": {
      "label": "AaveV3BNB.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": "AaveV3BNB.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x67bdf23c7fce7c65ff7415ba3f2520b45d6f9584": {
      "label": "AaveV3BNB.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x6807dc923806fe8fd134338eabca509979a7e0cb": {
      "label": "AaveV3BNB.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9390b1735def18560c509e2d0bc090e9d6ba257a": {
      "label": "AaveV3BNB.ACL_ADMIN, GovernanceV3BNB.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb9eb5abe26f74395e7833761e76a8e82ad8436f1": {
      "label": "AaveV3BNB.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x5d54c6410275cc5a5b440259b3bdba59addb097a220aaccc7a447ece2a2b45b3": {
          "previousValue": "0x10014dc93800000000000003e8000124f8000000000107d085122af817d4157c",
          "newValue": "0x10014dc93800000000000003e8000124f8000000000107d085122af817d40000"
        }
      }
    },
    "0xbdfa4bdd705e02a2da357ddd2e543ec654529940": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x3ba015d6b845e102ce2f76836007be82508e3543856f2a3c2ff4b56eb46d920e": {
          "previousValue": "0x0068fa7407000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068fa7407000000000003000000000000000000000000000000000000000000"
        },
        "0x3ba015d6b845e102ce2f76836007be82508e3543856f2a3c2ff4b56eb46d920f": {
          "previousValue": "0x000000000000000000093a800000000000006928988800000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006928988800000000000068fa7408"
        }
      }
    },
    "0xe5ef2dd06755a97e975f7e282f828224f2c3e627": {
      "label": "GovernanceV3BNB.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff75b6da14ffbbfd355daf7a2731456b3562ba6d": {
      "label": "AaveV3BNB.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```