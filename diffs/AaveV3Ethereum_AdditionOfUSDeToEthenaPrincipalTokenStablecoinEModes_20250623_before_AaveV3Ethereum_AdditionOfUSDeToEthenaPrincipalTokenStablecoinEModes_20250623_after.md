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



### EMode: PT-USDe Stablecoins July 2025(id: 10)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PT-USDe Stablecoins July 2025 | PT-USDe Stablecoins July 2025 |
| eMode.ltv (unchanged) | 91 % | 91 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 3.3 % | 3.3 % |
| eMode.borrowableBitmap | USDC, USDT, USDS | USDC, USDT, USDe, USDS |
| eMode.collateralBitmap | USDe, PT-USDe-31JUL2025 | PT-USDe-31JUL2025 |


### EMode: USDe Stablecoin(id: 11)



### EMode: PT-USDe USDe July 2025(id: 12)



### EMode: PT-eUSDe Stablecoins August 2025(id: 13)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PT-eUSDe Stablecoins August 2025 | PT-eUSDe Stablecoins August 2025 |
| eMode.ltv (unchanged) | 90.1 % | 90.1 % |
| eMode.liquidationThreshold (unchanged) | 92.2 % | 92.2 % |
| eMode.liquidationBonus (unchanged) | 3.5 % | 3.5 % |
| eMode.borrowableBitmap | USDC, USDT, USDS | USDC, USDT, USDe, USDS |
| eMode.collateralBitmap (unchanged) | PT-eUSDE-14AUG2025, eUSDe | PT-eUSDE-14AUG2025, eUSDe |


### EMode: PT-eUSDe USDe August 2025(id: 14)



### EMode: eUSDe_Stablecoin(id: 15)



### EMode: FBTC/WBTC(id: 16)



## Raw diff

```json
{
  "eModes": {
    "10": {
      "borrowableBitmap": {
        "from": "34359738632",
        "to": "35433480456"
      },
      "collateralBitmap": {
        "from": "8797166764032",
        "to": "8796093022208"
      }
    },
    "13": {
      "borrowableBitmap": {
        "from": "34359738632",
        "to": "35433480456"
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
        "0x4b5bb5f188f00a30034cddb70659a995ec1639e10dffc4175aba8960e57f09e1": {
          "previousValue": "0x006859be1a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006859be1a000000000003000000000000000000000000000000000000000000"
        },
        "0x4b5bb5f188f00a30034cddb70659a995ec1639e10dffc4175aba8960e57f09e2": {
          "previousValue": "0x000000000000000000093a800000000000006887e29b00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006887e29b0000000000006859be1b"
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
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d6f": {
          "previousValue": "0x0000000000000000000000000000000000000000300000000000286e24042332",
          "newValue": "0x0000000000000000000000000000000000000000300000000000286e24042332"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d71": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000800000108",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000840000108"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d6": {
          "previousValue": "0x0000000000000000000000000000000000000000080040000000285a2454238c",
          "newValue": "0x0000000000000000000000000000000000000000080000000000285a2454238c"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000800000108",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000840000108"
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
    }
  }
}
```