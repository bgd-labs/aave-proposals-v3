## Reserve changes

### Reserve altered

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://explorer.inkonchain.com/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 6,000 ezETH | 18,000 ezETH |


#### WETH ([0x4200000000000000000000000000000000000006](https://explorer.inkonchain.com/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 20,000 WETH | 70,000 WETH |


#### wrsETH ([0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4](https://explorer.inkonchain.com/address/0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 6,000 wrsETH | 18,000 wrsETH |


## Raw diff

```json
{
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "supplyCap": {
        "from": 6000,
        "to": 18000
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "borrowCap": {
        "from": 20000,
        "to": 70000
      }
    },
    "0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4": {
      "supplyCap": {
        "from": 6000,
        "to": 18000
      }
    }
  },
  "raw": {
    "0x1de9cb9420dd1f2ccefff9393e126b800d413b7a": {
      "label": "GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x1df462e2712496373a347f8ad10802a5e95f053d": {
      "label": "AaveV3InkWhitelabel.ACL_ADMIN, GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba": {
      "label": "AaveV3InkWhitelabel.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2ab3580a805fb10cbad567212c70e26c1b6769ec": {
      "label": "AaveV3InkWhitelabel.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x441c97eed5e83dc00883c4e8f7aec52e2ca37e4ede010579e435dcd4910c0d49": {
          "previousValue": "0x100000000000000000000003e800000177000000000103e881122af8000a0005",
          "newValue": "0x100000000000000000000003e800000465000000000103e881122af8000a0005"
        },
        "0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2": {
          "previousValue": "0x100000000000000000000003e800000177000000000103e881122af8000a0005",
          "newValue": "0x100000000000000000000003e800000465000000000103e881122af8000a0005"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade": {
          "previousValue": "0x100000000000000000000003e8000009c40000004e2005dc851229fe206c1f40",
          "newValue": "0x100000000000000000000003e8000009c4000001117005dc851229fe206c1f40"
        }
      }
    },
    "0x4172e6aaec070acb31aace343a58c93e4c70f44d": {
      "label": "AaveV3InkWhitelabel.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4f221e5c0b7103f7e3291e10097de6d9e3bfc02d": {
      "label": "AaveV3InkWhitelabel.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x86e2938dae289763d4e09a7e42c5ccca62cf9809": {
      "label": "AaveV3InkWhitelabel.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xccccf90c363eaf09dd89dd5330c1287ff6a945ee": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xc69056f16cbaa3c616b828e333ab7d3a32310765507f8f58359e99ebb7a885f3": {
          "previousValue": "0x00692faeff000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00692faeff000000000003000000000000000000000000000000000000000000"
        },
        "0xc69056f16cbaa3c616b828e333ab7d3a32310765507f8f58359e99ebb7a885f4": {
          "previousValue": "0x000000000000000000093a80000000000000695dd38000000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695dd380000000000000692faf00"
        }
      }
    },
    "0xe892e40c92c2e4d281be59b2e6300f271d824e75": {
      "label": "AaveV3InkWhitelabel.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```