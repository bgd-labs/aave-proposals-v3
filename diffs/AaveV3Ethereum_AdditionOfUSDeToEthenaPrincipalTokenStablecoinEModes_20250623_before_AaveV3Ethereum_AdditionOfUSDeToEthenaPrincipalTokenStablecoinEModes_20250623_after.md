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
| eMode.collateralBitmap (unchanged) | USDe, PT-USDe-31JUL2025 | USDe, PT-USDe-31JUL2025 |


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
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
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
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000800000108",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000840000108"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
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
    }
  }
}
```