## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sUSDe Stablecoins |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 92 % |
| eMode.liquidationBonus | - | 3 % |
| eMode.borrowableBitmap | - | USDC, USDS |
| eMode.collateralBitmap | - | sUSDe |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "from": null,
      "to": {
        "borrowableBitmap": 34359738376,
        "collateralBitmap": 4294967296,
        "eModeCategory": 2,
        "label": "sUSDe Stablecoins",
        "liquidationBonus": 10300,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  }
}
```