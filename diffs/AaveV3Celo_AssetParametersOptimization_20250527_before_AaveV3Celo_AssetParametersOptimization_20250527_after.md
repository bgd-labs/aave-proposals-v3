## Reserve changes

### Reserves altered

#### USD₮ ([0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e](https://celoscan.io/address/0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 20 % [2000] |


## Raw diff

```json
{
  "reserves": {
    "0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    }
  },
  "raw": {
    "0x1df462e2712496373a347f8ad10802a5e95f053d": {
      "label": "AaveV3Celo.ACL_ADMIN, GovernanceV3Celo.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e59a31363e2ad014dcbc521c4a0d5757d9f3402": {
      "label": "AaveV3Celo.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x44d38b18a99e50e51b99f05c1f418db26ded315f": {
      "label": "AaveV3Celo.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0xf54036dc390a53fcefe11f31de56ed35edaa6741fe9bf839a208c2cec27512de": {
          "previousValue": "0x100000000000000000000003e80005b8d800001b774003e8a50629041e781d4c",
          "newValue": "0x100000000000000000000003e80005b8d800001b774007d0a50629041e781d4c"
        },
        "0xf54036dc390a53fcefe11f31de56ed35edaa6741fe9bf839a208c2cec27512df": {
          "previousValue": "0x000000000000002524ec405c5145f58000000000033b5f903e85eb5c1250b5e7",
          "newValue": "0x00000000000000210463c815ab6b78df00000000033b5f905ffb36827a770186"
        },
        "0xf54036dc390a53fcefe11f31de56ed35edaa6741fe9bf839a208c2cec27512e0": {
          "previousValue": "0x00000000000031a797ddee61c4dc7b7a00000000033bcff8c0ecd9534b2b8be9",
          "newValue": "0x00000000000031a79a8addf541d4114600000000033bd025812654785b735c2b"
        },
        "0xf54036dc390a53fcefe11f31de56ed35edaa6741fe9bf839a208c2cec27512e1": {
          "previousValue": "0x00000000000000000000010068346b2c00000000000000000000000000000000",
          "newValue": "0x00000000000000000000010068361c8500000000000000000000000000000000"
        },
        "0xf54036dc390a53fcefe11f31de56ed35edaa6741fe9bf839a208c2cec27512e6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000002de8",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000000030eb"
        }
      }
    },
    "0x7567e3434cc1bef724ab595e6072367ef4914691": {
      "label": "AaveV3Celo.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7a12dcfd73c1b4cddf294da4cfce75fcabba314c": {
      "label": "AaveV3Celo.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x87f6224536d9bd1d4fe6052e06f9647b51843e33": {
      "label": "AaveV3Celo.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8b62d241bf59f40991dcd18531683156d7013355": {
      "label": "AaveV3Celo.ASSETS.USDC.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.USDT.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.cEUR.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.cUSD.INTEREST_RATE_STRATEGY, AaveV3Celo.ASSETS.CELO.INTEREST_RATE_STRATEGY",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8ff70ee5f8b607844a094a938e4ded76aebca5f0": {
      "label": "AaveV3Celo.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9f7cf9417d5251c59fe94fb9147feee1aad9cea5": {
      "label": "AaveV3Celo.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xda4b6024aa06f7565bbcaad9b8be24c3c229aab5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772465": {
          "previousValue": "0x0068361c84000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068361c84000000000003000000000000000000000000000000000000000000"
        },
        "0x83ec6a1f0257b830b5e016457c9cf1435391bf56cc98f369a58a54fe93772466": {
          "previousValue": "0x000000000000000000093a800000000000006864410500000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006864410500000000000068361c85"
        }
      }
    },
    "0xe15324a9887999803b931ac45aa89a94a9750052": {
      "label": "AaveV3Celo.ASSETS.USDT.V_TOKEN",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe48e10834c04e394a04bf22a565d063d40b9fa42": {
      "label": "GovernanceV3Celo.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```