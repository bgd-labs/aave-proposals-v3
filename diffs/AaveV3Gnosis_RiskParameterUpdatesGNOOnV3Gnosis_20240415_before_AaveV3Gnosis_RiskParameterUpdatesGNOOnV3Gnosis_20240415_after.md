## Reserve changes

### Reserves altered

#### GNO ([0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb](https://gnosisscan.io/address/0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 1,000,000 $ | 2,000,000 $ |
| ltv | 31 % | 45 % |
| liquidationThreshold | 36 % | 50 % |


## Raw diff

```json
{
  "reserves": {
    "0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb": {
      "debtCeiling": {
        "from": 100000000,
        "to": 200000000
      },
      "liquidationThreshold": {
        "from": 3600,
        "to": 5000
      },
      "ltv": {
        "from": 3100,
        "to": 4500
      }
    }
  }
}
```