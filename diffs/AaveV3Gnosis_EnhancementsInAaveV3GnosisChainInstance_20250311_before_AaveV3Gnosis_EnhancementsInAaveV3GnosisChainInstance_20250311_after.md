## Reserve changes

### Reserves altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 11,000,000 USDC | 2,500,000 USDC |
| borrowCap | 11,000,000 USDC | 2,000,000 USDC |
| ltv | 75 % [7500] | 65 % [6500] |
| reserveFactor | 25 % [2500] | 40 % [4000] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sDAI / EURe(id: 2)



### EMode: sDAI/USDCe(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sDAI/USDCe |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 4 % |
| eMode.borrowableBitmap | - | USDC.e |
| eMode.collateralBitmap | - | sDAI |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "borrowableBitmap": "128",
        "collateralBitmap": "64",
        "eModeCategory": 3,
        "label": "sDAI/USDCe",
        "liquidationBonus": 10400,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "borrowCap": {
        "from": 11000000,
        "to": 2000000
      },
      "ltv": {
        "from": 7500,
        "to": 6500
      },
      "reserveFactor": {
        "from": 2500,
        "to": 4000
      },
      "supplyCap": {
        "from": 11000000,
        "to": 2500000
      }
    }
  },
  "raw": {
    "0x9a1f491b86d09fc1484b5fab10041b189b60756b": {
      "label": "GovernanceV3Gnosis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x5f3ffac152518418b730c1b4427b48de47a050e582434504c9ffd15088f0d196": {
          "previousValue": "0x0067d9bec7000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d9bec7000000000003000000000000000000000000000000000000000000"
        },
        "0x5f3ffac152518418b730c1b4427b48de47a050e582434504c9ffd15088f0d197": {
          "previousValue": "0x000000000000000000093a800000000000006807e34800000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006807e34800000000000067d9bec8"
        }
      }
    },
    "0xb50201558b00496a145fe76f7424749556e326d8": {
      "label": "AaveV3Gnosis.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f2768f": {
          "previousValue": "0x100000000000000000000007d0000a7d8c0000a7d8c009c4a50629041e781d4c",
          "newValue": "0x100000000000000000000007d00002625a00001e84800fa0a50629041e781964"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27690": {
          "previousValue": "0x000000000022c0321254a051b64e477700000000037f3445cba051d2a9adc2a9",
          "newValue": "0x00000000001bccf57056235a7715121c00000000037f3456fd57caf97c2941b1"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27691": {
          "previousValue": "0x00000000004141ebda15b07c807ec5cf00000000039c6773b52556818312d809",
          "newValue": "0x00000000004141ec88cfb6caaa95988a00000000039c67950ca0da1577148cf8"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27692": {
          "previousValue": "0x00000000000000000000030067d9bdec00000000000000000000000000000000",
          "newValue": "0x00000000000000000000030067d9bec800000000000000000000000000000000"
        },
        "0x45fb21bff46f3219261e8dfd39448f990f239040f94fb8fbbbea3b4a28f27697": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000af40dc",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000b14d0d"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000004028a023f02328"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x734441492f555344436500000000000000000000000000000000000000000014"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000080"
        }
      }
    }
  }
}
```