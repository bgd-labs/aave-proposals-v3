## Reserve changes

### Reserves altered

#### OP ([0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042))

| description | value before | value after |
| --- | --- | --- |
| ltv | 30 % | 50 % |
| liquidationThreshold | 40 % | 60 % |


## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000042": {
      "liquidationThreshold": {
        "from": 4000,
        "to": 6000
      },
      "ltv": {
        "from": 3000,
        "to": 5000
      }
    }
  }
}
```