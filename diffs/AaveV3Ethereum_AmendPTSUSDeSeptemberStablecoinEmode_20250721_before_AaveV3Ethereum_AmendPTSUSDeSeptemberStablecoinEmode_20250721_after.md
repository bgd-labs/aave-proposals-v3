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



### EMode: USDe Stablecoin(id: 11)



### EMode: PT-USDe USDe July 2025(id: 12)



### EMode: PT-eUSDe Stablecoins August 2025(id: 13)



### EMode: PT-eUSDe USDe August 2025(id: 14)



### EMode: eUSDe_Stablecoin(id: 15)



### EMode: FBTC/WBTC(id: 16)



### EMode: PT-sUSDe Stablecoins September 2025(id: 17)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PT-sUSDe Stablecoins September 2025 | PT-sUSDe Stablecoins September 2025 |
| eMode.ltv (unchanged) | 88 % | 88 % |
| eMode.liquidationThreshold (unchanged) | 90 % | 90 % |
| eMode.liquidationBonus (unchanged) | 5 % | 5 % |
| eMode.borrowableBitmap | USDC, USDT, USDe, USDS | USDC, USDT, USDe, USDS, USDtb |
| eMode.collateralBitmap | PT-sUSDE-25SEP2025 | sUSDe, PT-sUSDE-31JUL2025, PT-sUSDE-25SEP2025 |


### EMode: PT-sUSDe USDe September 2025(id: 18)



## Raw diff

```json
{
  "eModes": {
    "17": {
      "borrowableBitmap": {
        "from": "35433480456",
        "to": "4433479991560"
      },
      "collateralBitmap": {
        "from": "281474976710656",
        "to": "283678294933504"
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
    "0x5793fe4de34532f162b4e207af872729880ec2b6": {
      "label": null,
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
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a26": {
          "previousValue": "0x00687ea016000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00687ea016000000000003000000000000000000000000000000000000000000"
        },
        "0x5e42e61f6ba243bb2d33351fdcc4ecfed25145016826881fdc8a40a4e9d16a27": {
          "previousValue": "0x000000000000000000093a8000000000000068acc49700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068acc497000000000000687ea017"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x947f0054faed3481ff4e76ca35f12fbe36cc665b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564addda": {
          "previousValue": "0x0000000000000000000000000000000000000001000000000000290423282260",
          "newValue": "0x0000000000000000000000000000000000000001020100000000290423282260"
        },
        "0x7635c6f6fb0dc990d132e97ffe82e07606fac72c3d39da71ac41d6a8564adddc": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000840000108",
          "newValue": "0x0000000000000000000000000000000000000000000000000000040840000108"
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