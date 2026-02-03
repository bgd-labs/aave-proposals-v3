## Reserve changes

### Reserve altered

#### XAUt0 ([0x1B64B9025EEbb9A6239575dF9Ea4b9Ac46D4d193](https://plasmascan.to/address/0x1B64B9025EEbb9A6239575dF9Ea4b9Ac46D4d193))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 18,000,000 $ [1800000000] | 0 $ [0] |
| ltv | 70 % [7000] | 0 % [0] |


#### sUSDe ([0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2](https://plasmascan.to/address/0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### USDe ([0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34](https://plasmascan.to/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34))

| description | value before | value after |
| --- | --- | --- |
| ltv | 72 % [7200] | 0 % [0] |


#### weETH ([0xA3D68b74bF0528fdD07263c60d6488749044914b](https://plasmascan.to/address/0xA3D68b74bF0528fdD07263c60d6488749044914b))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### syrupUSDT ([0xC4374775489CB9C56003BF2C9b12495fC64F0771](https://plasmascan.to/address/0xC4374775489CB9C56003BF2C9b12495fC64F0771))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### wrsETH ([0xe561FE05C39075312Aa9Bc6af79DdaE981461359](https://plasmascan.to/address/0xe561FE05C39075312Aa9Bc6af79DdaE981461359))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


## Emodes changed

### EMode: USDe Stablecoins(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: weETH WETH(id: 3)



### EMode: weETH Stablecoins(id: 4)



### EMode: PT-USDe Stablecoins Jan 2026(id: 5)



### EMode: PT-USDe USDe Jan 2026(id: 6)



### EMode: PT-sUSDe Stablecoins Jan 2026(id: 7)



### EMode: PT-sUSDe USDe Jan 2026(id: 8)



### EMode: wrsETH/WETH(id: 9)



### EMode: wstETH/WETH(id: 10)



### EMode: syrupUSDT/USDT0(id: 11)



### EMode: WXPL Stablecoins(id: 12)



### EMode: PT_USDe_9APR2026__Stablecoins(id: 13)



### EMode: PT_USDe_9APR2026__USDe(id: 14)



### EMode: PT_sUSDe_9APR2026__Stablecoins(id: 15)



### EMode: PT_sUSDe_9APR2026__USDe(id: 16)



### EMode: XAUt__USDT(id: 17)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | XAUt__USDT |
| eMode.ltv | - | 70 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDT0 |
| eMode.collateralBitmap | - | XAUt0 |


## Raw diff

```json
{
  "eModes": {
    "17": {
      "from": null,
      "to": {
        "borrowableBitmap": "1",
        "collateralBitmap": "8",
        "eModeCategory": 17,
        "label": "XAUt__USDT",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7000
      }
    }
  },
  "reserves": {
    "0x1B64B9025EEbb9A6239575dF9Ea4b9Ac46D4d193": {
      "debtCeiling": {
        "from": 1800000000,
        "to": 0
      },
      "ltv": {
        "from": 7000,
        "to": 0
      }
    },
    "0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34": {
      "ltv": {
        "from": 7200,
        "to": 0
      }
    },
    "0xA3D68b74bF0528fdD07263c60d6488749044914b": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xC4374775489CB9C56003BF2C9b12495fC64F0771": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xe561FE05C39075312Aa9Bc6af79DdaE981461359": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    }
  },
  "raw": {
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": "AaveV3Plasma.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0ee1b4748ece9938d60c5a08c06fdcc57c304bfbc0758f61e612ab3ee93ce023": {
          "previousValue": "0x100000000000000000000003e80684ee180017d7840009c485122a621d4c1c20",
          "newValue": "0x100000000000000000000003e80684ee180017d7840009c485122a621d4c0000"
        },
        "0x0f69e495df4462160fbe947b1aac24bd3791eb88f23edd1cd5f46506f4070e42": {
          "previousValue": "0x1006b49d2000000000000003e8000001b5800000000107d0810629fe1d4c1b58",
          "newValue": "0x100000000000000000000003e8000001b5800000000107d0810629fe1d4c0000"
        },
        "0x0f69e495df4462160fbe947b1aac24bd3791eb88f23edd1cd5f46506f4070e4b": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000230db9e0",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x52f7f1440ab20fcadde51b79423bd2f17e1c58bc3878efc43624e8de64ae798f": {
          "previousValue": "0x100000000000000000000003e800003a98000000000107d0811229cc000a0005",
          "newValue": "0x100000000000000000000003e800003a98000000000107d0811229cc000a0000"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564addda": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000829fe1d4c1b58"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564adddb": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x584155745f5f5553445400000000000000000000000000000000000000000014"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564adddc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xa2611fffb1563e77311e06c60d4d847b1804f1b210a636975fa6e9c20cb74aaa": {
          "previousValue": "0x100000000000000000000003e8017d78400000000001119481062968000a0005",
          "newValue": "0x100000000000000000000003e8017d78400000000001119481062968000a0000"
        },
        "0xb69e101291cae8ac8885e4f60b77f31b4a9feff65bb4172464a0e8f08242ae35": {
          "previousValue": "0x100000000000000000000003e805de097c000000000107d081122a62000a0005",
          "newValue": "0x100000000000000000000003e805de097c000000000107d081122a62000a0000"
        },
        "0xf235290065507aca56dd1272ea508d53a3f4f7d822b50f8bbe62ce44a2aace13": {
          "previousValue": "0x100000000000000000000003e8000004e200000000011194811229cc000a0005",
          "newValue": "0x100000000000000000000003e8000004e200000000011194811229cc000a0000"
        }
      }
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": "GovernanceV3Plasma.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xfc111d09a6e2f0958402cbe16a5aef32c9d8ddb9a4df7271140de57bfed6525a": {
          "previousValue": "0x0069780dbe000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069780dbe000000000003000000000000000000000000000000000000000000"
        },
        "0xfc111d09a6e2f0958402cbe16a5aef32c9d8ddb9a4df7271140de57bfed6525b": {
          "previousValue": "0x000000000000000000093a8000000000000069a6323f00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a6323f00000000000069780dbf"
        }
      }
    }
  }
}
```