## Reserve changes

### Reserves altered

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 40,000,000 $ [4000000000] | 0 $ [0] |


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
        "borrowableBitmap": "34359738376",
        "collateralBitmap": "4294967296",
        "eModeCategory": 2,
        "label": "sUSDe Stablecoins",
        "liquidationBonus": 10300,
        "liquidationThreshold": 9200,
        "ltv": 9000
      }
    }
  },
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "debtCeiling": {
        "from": 4000000000,
        "to": 0
      }
    }
  }
}
```