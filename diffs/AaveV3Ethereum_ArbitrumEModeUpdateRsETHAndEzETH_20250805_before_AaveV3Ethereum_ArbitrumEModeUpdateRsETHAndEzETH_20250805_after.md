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



### EMode: weETH/wstETH ETH Correlated(id: 24)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | weETH/wstETH ETH Correlated |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WETH, wstETH |
| eMode.collateralBitmap | - | weETH |


## Raw diff

```json
{
  "eModes": {
    "24": {
      "from": null,
      "to": {
        "borrowableBitmap": "3",
        "collateralBitmap": "268435456",
        "eModeCategory": 24,
        "label": "weETH/wstETH ETH Correlated",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x8ac003b432f8dd1ea98d6e03375ae9962317ecfe1306c0a504bc33db24b14282": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000100000002774251c2454"
        },
        "0x8ac003b432f8dd1ea98d6e03375ae9962317ecfe1306c0a504bc33db24b14283": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x77654554482f7773744554482045544820436f7272656c617465640000000036"
        },
        "0x8ac003b432f8dd1ea98d6e03375ae9962317ecfe1306c0a504bc33db24b14284": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000003"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x6090624016facd16d5b0ac903a50b2dc35f4004f6a8c25246e2dddee13b01a36": {
          "previousValue": "0x0068a4ce6a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068a4ce6a000000000003000000000000000000000000000000000000000000"
        },
        "0x6090624016facd16d5b0ac903a50b2dc35f4004f6a8c25246e2dddee13b01a37": {
          "previousValue": "0x000000000000000000093a8000000000000068d2f2eb00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068d2f2eb00000000000068a4ce6b"
        }
      }
    }
  }
}
```