## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: cbBTC WBTC(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | cbBTC WBTC |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | WBTC |
| eMode.collateralBitmap | - | cbBTC |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "17179869184",
        "eModeCategory": 4,
        "label": "cbBTC WBTC",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  }
}
```