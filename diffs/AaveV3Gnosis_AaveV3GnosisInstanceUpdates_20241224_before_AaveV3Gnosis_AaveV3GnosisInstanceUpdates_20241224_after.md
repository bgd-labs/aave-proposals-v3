## Reserve changes

### Reserve altered

#### GNO ([0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb](https://gnosisscan.io/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 2,000,000 $ [200000000] | 0 $ [0] |


#### EURe ([0xcB444e90D8198415266c6a2724b7900fb12FC56E](https://gnosisscan.io/address/0xcB444e90D8198415266c6a2724b7900fb12FC56E))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 20 % [2000] | 10 % [1000] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sDAI / EURe(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | sDAI / EURe |
| eMode.ltv | - | 85 % |
| eMode.liquidationThreshold | - | 87.5 % |
| eMode.liquidationBonus | - | 5 % |
| eMode.borrowableBitmap | - | EURe |
| eMode.collateralBitmap | - | sDAI |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "from": null,
      "to": {
        "borrowableBitmap": "32",
        "collateralBitmap": "64",
        "eModeCategory": 2,
        "label": "sDAI / EURe",
        "liquidationBonus": 10500,
        "liquidationThreshold": 8750,
        "ltv": 8500
      }
    }
  },
  "reserves": {
    "0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb": {
      "debtCeiling": {
        "from": 200000000,
        "to": 0
      }
    },
    "0xcB444e90D8198415266c6a2724b7900fb12FC56E": {
      "reserveFactor": {
        "from": 2000,
        "to": 1000
      }
    }
  }
}
```