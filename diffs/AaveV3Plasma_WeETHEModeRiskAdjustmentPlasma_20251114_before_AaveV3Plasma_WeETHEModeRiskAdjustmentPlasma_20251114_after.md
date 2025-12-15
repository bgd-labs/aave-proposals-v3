## Emodes changed

### EMode: USDe Stablecoins(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: weETH WETH(id: 3)



### EMode: weETH Stablecoins(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | weETH Stablecoins | weETH Stablecoins |
| eMode.ltv | 75 % | 77.5 % |
| eMode.liquidationThreshold | 78 % | 80 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap (unchanged) | USDT0 | USDT0 |
| eMode.collateralBitmap (unchanged) | weETH | weETH |


### EMode: PT-USDe Stablecoins Jan 2026(id: 5)



### EMode: PT-USDe USDe Jan 2026(id: 6)



### EMode: PT-sUSDe Stablecoins Jan 2026(id: 7)



### EMode: PT-sUSDe USDe Jan 2026(id: 8)



### EMode: wrsETH/WETH(id: 9)



### EMode: wstETH/WETH(id: 10)



### EMode: syrupUSDT/USDT0(id: 11)



### EMode: WXPL Stablecoins(id: 12)



## Raw diff

```json
{
  "eModes": {
    "4": {
      "liquidationThreshold": {
        "from": 7800,
        "to": 8000
      },
      "ltv": {
        "from": 7500,
        "to": 7750
      }
    }
  },
  "raw": {
    "0x061d8e131f26512348ee5fa42e2df1ba9d6505e9": {
      "label": "AaveV3Plasma.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x39ba8c26fc81e6a37a870115940ab32ed25c9ae7": {
      "label": "AaveV3Plasma.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x47aadaae1f05c978e6abb7568d11b7f6e0fc4d6a": {
      "label": "AaveV3Plasma.ACL_ADMIN, GovernanceV3Plasma.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7120b1f8e5b73c0c0dc99c6e52fe4937e7ea11e0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d53": {
          "previousValue": "0x00691742b6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00691742b6000000000003000000000000000000000000000000000000000000"
        },
        "0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d54": {
          "previousValue": "0x000000000000000000093a800000000000006945673700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069456737000000000000691742b7"
        }
      }
    },
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": "AaveV3Plasma.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa119f84bc1b8083f5061e4cf53705cbf1065ba27": {
      "label": "AaveV3Plasma.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x000000000000000000000000000000000000000000000000001029fe1e781d4c",
          "newValue": "0x000000000000000000000000000000000000000000000000001029fe1f401e46"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354d": {
          "previousValue": "0x776545544820537461626c65636f696e73000000000000000000000000000022",
          "newValue": "0x776545544820537461626c65636f696e73000000000000000000000000000022"
        }
      }
    },
    "0xa860355f0ccfdc823f7332ac108317b2a1509c06": {
      "label": "AaveV3Plasma.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc022b6c71c30a8ad52dac504efa132d13d99d2d9": {
      "label": "AaveV3Plasma.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": "GovernanceV3Plasma.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```