## Reserve changes

### Reserves altered

#### XAUt ([0x68749665FF8D2d112Fa859AA293F07A622782F38](https://etherscan.io/address/0x68749665FF8D2d112Fa859AA293F07A622782F38))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 5,000 XAUt | 10,000 XAUt |
| debtCeiling | 3,000,000 $ [300000000] | 25,000,000 $ [2500000000] |


## Raw diff

```json
{
  "reserves": {
    "0x68749665FF8D2d112Fa859AA293F07A622782F38": {
      "debtCeiling": {
        "from": 300000000,
        "to": 2500000000
      },
      "supplyCap": {
        "from": 5000,
        "to": 10000
      }
    }
  },
  "raw": {
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": "AaveV3Ethereum.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR_IMPL, AaveV3EthereumEtherFi.POOL_CONFIGURATOR_IMPL, AaveV3EthereumLido.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86577": {
          "previousValue": "0x00692e0d26000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00692e0d26000000000003000000000000000000000000000000000000000000"
        },
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86578": {
          "previousValue": "0x000000000000000000093a80000000000000695c31a700000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695c31a7000000000000692e0d27"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x97287a4f35e583d924f78ad88db8afce1379189a": {
      "label": "AaveV3Ethereum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x7687a742c1f1a8f246934e718167a1f123494d05171f7f82b68f858a6a368452": {
          "previousValue": "0x10011e1a3000000000000003e800000138800000000107d0810629681d4c1b58",
          "newValue": "0x1009502f9000000000000003e800000271000000000107d0810629681d4c1b58"
        }
      }
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": "AaveV3Ethereum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```