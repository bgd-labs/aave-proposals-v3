## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: tBTC WBTC(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | tBTC WBTC |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1.5 % |
| eMode.borrowableBitmap | - | WBTC |
| eMode.collateralBitmap | - | tBTC |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "from": null,
      "to": {
        "borrowableBitmap": "4",
        "collateralBitmap": "8589934592",
        "eModeCategory": 4,
        "label": "tBTC WBTC",
        "liquidationBonus": 10150,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  }
}
```