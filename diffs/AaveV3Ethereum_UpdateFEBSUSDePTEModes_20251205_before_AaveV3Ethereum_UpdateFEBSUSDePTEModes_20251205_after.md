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



### EMode: PT-sUSDe USDe September 2025(id: 18)



### EMode: PT-USDe Stablecoins September 2025(id: 19)



### EMode: PT-USDe USDe September 2025(id: 20)



### EMode: tETH/Stablecoins(id: 21)



### EMode: ezETH/wstETH(id: 22)



### EMode: ezETH/Stablecoins(id: 23)



### EMode: PT-sUSDe Stablecoins Nov 2025(id: 24)



### EMode: PT-sUSDe USDe Nov 2025(id: 25)



### EMode: weETH/wstETH ETH Correlated(id: 26)



### EMode: PT-USDe Stablecoins Nov 2025(id: 27)



### EMode: PT-USDe USDe Nov 2025(id: 28)



### EMode: PTUSDe5FEB/Stablecoins(id: 29)



### EMode: PTUSDe5FEB/USDe(id: 30)



### EMode: PTsUSDe5FEB/Stablecoins(id: 31)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTsUSDe5FEB/Stablecoins | PTsUSDe5FEB/Stablecoins |
| eMode.ltv (unchanged) | 89.1 % | 89.1 % |
| eMode.liquidationThreshold (unchanged) | 91.1 % | 91.1 % |
| eMode.liquidationBonus (unchanged) | 4.8 % | 4.8 % |
| eMode.borrowableBitmap (unchanged) | USDC, USDT, USDe, USDtb | USDC, USDT, USDe, USDtb |
| eMode.collateralBitmap | PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 | sUSDe, PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 |


### EMode: PTsUSDe5FEB/USDe(id: 32)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTsUSDe5FEB/USDe | PTsUSDe5FEB/USDe |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 92 % | 92 % |
| eMode.liquidationBonus (unchanged) | 3.8 % | 3.8 % |
| eMode.borrowableBitmap (unchanged) | USDe | USDe |
| eMode.collateralBitmap | PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 | sUSDe, PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 |


### EMode: syrupUSDT Stablecoins(id: 33)



## Raw diff

```json
{
  "eModes": {
    "31": {
      "collateralBitmap": {
        "from": "81064793292668928",
        "to": "81064797587636224"
      }
    },
    "32": {
      "collateralBitmap": {
        "from": "81064793292668928",
        "to": "81064797587636224"
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
        "0x67ab080467e2038ede04f1298fa0f975b7783b944e351deed2c7c14b1766db37": {
          "previousValue": "0x00693255e2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693255e2000000000003000000000000000000000000000000000000000000"
        },
        "0x67ab080467e2038ede04f1298fa0f975b7783b944e351deed2c7c14b1766db38": {
          "previousValue": "0x000000000000000000093a8000000000000069607a6300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069607a63000000000000693255e3"
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
        "0x21898044632c57248207e72227fc41f5733f2f788a03dd65fae092ee6fa2a071": {
          "previousValue": "0x0000000000000000000000000000000000000120000000000000288c23f02328",
          "newValue": "0x0000000000000000000000000000000000000120000100000000288c23f02328"
        },
        "0x5540f956076d2b96d9b5ae009ef453286928245383803229a3d68bd9262d69e8": {
          "previousValue": "0x000000000000000000000000000000000000012000000000000028f0239622ce",
          "newValue": "0x000000000000000000000000000000000000012000010000000028f0239622ce"
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