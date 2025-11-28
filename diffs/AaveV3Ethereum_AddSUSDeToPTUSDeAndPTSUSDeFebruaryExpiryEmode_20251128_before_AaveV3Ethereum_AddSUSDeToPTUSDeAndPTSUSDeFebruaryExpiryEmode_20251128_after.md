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

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTUSDe5FEB/Stablecoins | PTUSDe5FEB/Stablecoins |
| eMode.ltv (unchanged) | 89 % | 89 % |
| eMode.liquidationThreshold (unchanged) | 91 % | 91 % |
| eMode.liquidationBonus (unchanged) | 3.8 % | 3.8 % |
| eMode.borrowableBitmap (unchanged) | USDC, USDT, USDe, USDtb | USDC, USDT, USDe, USDtb |
| eMode.collateralBitmap | PT-USDe-27NOV2025, PT-USDe-5FEB2026 | sUSDe, PT-USDe-27NOV2025, PT-USDe-5FEB2026 |


### EMode: PTUSDe5FEB/USDe(id: 30)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTUSDe5FEB/USDe | PTUSDe5FEB/USDe |
| eMode.ltv (unchanged) | 89.8 % | 89.8 % |
| eMode.liquidationThreshold (unchanged) | 91.8 % | 91.8 % |
| eMode.liquidationBonus (unchanged) | 2.8 % | 2.8 % |
| eMode.borrowableBitmap (unchanged) | USDe | USDe |
| eMode.collateralBitmap | PT-USDe-27NOV2025, PT-USDe-5FEB2026 | sUSDe, PT-USDe-27NOV2025, PT-USDe-5FEB2026 |


### EMode: PTsUSDe5FEB/Stablecoins(id: 31)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTsUSDe5FEB/Stablecoins | PTsUSDe5FEB/Stablecoins |
| eMode.ltv (unchanged) | 88.1 % | 88.1 % |
| eMode.liquidationThreshold (unchanged) | 90.1 % | 90.1 % |
| eMode.liquidationBonus (unchanged) | 4.8 % | 4.8 % |
| eMode.borrowableBitmap (unchanged) | USDC, USDT, USDe, USDtb | USDC, USDT, USDe, USDtb |
| eMode.collateralBitmap | PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 | sUSDe, PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 |


### EMode: PTsUSDe5FEB/USDe(id: 32)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | PTsUSDe5FEB/USDe | PTsUSDe5FEB/USDe |
| eMode.ltv (unchanged) | 89 % | 89 % |
| eMode.liquidationThreshold (unchanged) | 91 % | 91 % |
| eMode.liquidationBonus (unchanged) | 3.8 % | 3.8 % |
| eMode.borrowableBitmap (unchanged) | USDe | USDe |
| eMode.collateralBitmap | PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 | sUSDe, PT-sUSDE-27NOV2025, PT-sUSDE-5FEB2026 |


## Raw diff

```json
{
  "eModes": {
    "29": {
      "collateralBitmap": {
        "from": "54043195528445952",
        "to": "54043199823413248"
      }
    },
    "30": {
      "collateralBitmap": {
        "from": "54043195528445952",
        "to": "54043199823413248"
      }
    },
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
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x21898044632c57248207e72227fc41f5733f2f788a03dd65fae092ee6fa2a071": {
          "previousValue": "0x0000000000000000000000000000000000000120000000000000288c238c22c4",
          "newValue": "0x0000000000000000000000000000000000000120000100000000288c238c22c4"
        },
        "0x5540f956076d2b96d9b5ae009ef453286928245383803229a3d68bd9262d69e8": {
          "previousValue": "0x000000000000000000000000000000000000012000000000000028f02332226a",
          "newValue": "0x000000000000000000000000000000000000012000010000000028f02332226a"
        },
        "0x731e6d8269400fc394cb43330fd2612574d089c0e6408edfb23ea082b7072883": {
          "previousValue": "0x00000000000000000000000000000000000000c0000000000000282823dc2314",
          "newValue": "0x00000000000000000000000000000000000000c0000100000000282823dc2314"
        },
        "0xff96dc9b2fb693edb8d05190a44f8cda48f48702b06828c27863d75ccd5a93d7": {
          "previousValue": "0x00000000000000000000000000000000000000c0000000000000288c238c22c4",
          "newValue": "0x00000000000000000000000000000000000000c0000100000000288c238c22c4"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86577": {
          "previousValue": "0x0069297676000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069297676000000000003000000000000000000000000000000000000000000"
        },
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86578": {
          "previousValue": "0x000000000000000000093a8000000000000069579af700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069579af700000000000069297677"
        }
      }
    }
  }
}
```