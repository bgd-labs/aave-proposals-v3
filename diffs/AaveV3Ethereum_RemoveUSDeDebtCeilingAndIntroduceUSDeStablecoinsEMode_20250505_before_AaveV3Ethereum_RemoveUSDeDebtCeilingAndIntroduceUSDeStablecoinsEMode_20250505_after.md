## Reserve changes

### Reserves altered

#### USDe ([0x4c9EDD5852cd905f086C759E8383e09bff1E68B3](https://etherscan.io/address/0x4c9EDD5852cd905f086C759E8383e09bff1E68B3))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 103,680,000 $ [10368000000] | 0 $ [0] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: PT-sUSDe Stablecoins Jul 2025(id: 8)



### EMode: PT-eUSDe Stablecoins May 2025(id: 9)



### EMode: USDe Stablecoin(id: 11)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | USDe Stablecoin |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 93 % |
| eMode.liquidationBonus | - | 2 % |
| eMode.borrowableBitmap | - | USDC, USDT, USDS |
| eMode.collateralBitmap | - | USDe |


## Raw diff

```json
{
  "eModes": {
    "11": {
      "from": null,
      "to": {
        "borrowableBitmap": "34359738632",
        "collateralBitmap": "1073741824",
        "eModeCategory": 11,
        "label": "USDe Stablecoin",
        "liquidationBonus": 10200,
        "liquidationThreshold": 9300,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0x4c9EDD5852cd905f086C759E8383e09bff1E68B3": {
      "debtCeiling": {
        "from": 10368000000,
        "to": 0
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
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
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
        "0x089d9dba82be10d77505d9275f10474168973fc5766b8743cf39a24de0098e95": {
          "previousValue": "0x0068188e82000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068188e82000000000003000000000000000000000000000000000000000000"
        },
        "0x089d9dba82be10d77505d9275f10474168973fc5766b8743cf39a24de0098e96": {
          "previousValue": "0x000000000000000000093a800000000000006846b30300000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006846b30300000000000068188e83"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x9aeb8aaa1ca38634aa8c0c8933e7fb4d61091327": {
      "label": "AaveV3Ethereum.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000004000000027d824542328"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12bd": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x5553446520537461626c65636f696e000000000000000000000000000000001e"
        },
        "0x21d3abaf0b58baf827d64a5111853ffc1e6960c8a404e653db18a5a25d5f12be": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000800000108"
        },
        "0x4d79142fd7484f0fb4754f31f37cd6d530cd969ea79677d59a8958787faa204d": {
          "previousValue": "0x10269fb20000000000000003e80393870000068e778009c4a5122a621d4c1c20",
          "newValue": "0x100000000000000000000003e80393870000068e778009c4a5122a621d4c1c20"
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
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Ethereum.POOL_CONFIGURATOR_IMPL, AaveV3EthereumEtherFi.POOL_CONFIGURATOR_IMPL, AaveV3EthereumLido.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xf8c97539934ee66a67c26010e8e027d77e821b0c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4d79142fd7484f0fb4754f31f37cd6d530cd969ea79677d59a8958787faa2056": {
          "previousValue": "0x0000000000fea8e5ac66118dd70a502b0000000000000000000000025813371c",
          "newValue": "0x0000000000fea8e5ac66118dd70a502b00000000000000000000000000000000"
        }
      }
    }
  }
}
```