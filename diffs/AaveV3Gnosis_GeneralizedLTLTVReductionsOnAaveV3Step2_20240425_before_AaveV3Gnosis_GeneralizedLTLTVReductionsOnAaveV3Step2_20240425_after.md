## Reserve changes

### Reserve altered

#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 75 % |
| liquidationThreshold | 79 % | 78 % |


#### sDAI ([0xaf204776c7245bF4147c2612BF6e5972Ee483701](https://gnosisscan.io/address/0xaf204776c7245bF4147c2612BF6e5972Ee483701))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % | 75 % |
| liquidationThreshold | 77 % | 78 % |


## Raw diff

```json
{
  "reserves": {
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7800
      },
      "ltv": {
        "from": 7600,
        "to": 7500
      }
    },
    "0xaf204776c7245bF4147c2612BF6e5972Ee483701": {
      "liquidationThreshold": {
        "from": 7700,
        "to": 7800
      },
      "ltv": {
        "from": 6300,
        "to": 7500
      }
    }
  }
}
```