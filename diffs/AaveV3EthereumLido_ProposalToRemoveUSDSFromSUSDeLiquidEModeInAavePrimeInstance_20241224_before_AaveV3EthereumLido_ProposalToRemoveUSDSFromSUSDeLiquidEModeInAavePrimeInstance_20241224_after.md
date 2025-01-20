## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | sUSDe Stablecoins | sUSDe Stablecoins |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 92 % | 92 % |
| eMode.liquidationBonus | 3 % | 4 % |
| eMode.borrowableBitmap | USDS, USDC, GHO | USDC, GHO |
| eMode.collateralBitmap (unchanged) | sUSDe | sUSDe |


### EMode: rsETH LST main(id: 5)



## Raw diff

```json
{
  "eModes": {
    "4": {
      "borrowableBitmap": {
        "from": "76",
        "to": "72"
      },
      "liquidationBonus": {
        "from": 10300,
        "to": 10400
      }
    }
  }
}
```