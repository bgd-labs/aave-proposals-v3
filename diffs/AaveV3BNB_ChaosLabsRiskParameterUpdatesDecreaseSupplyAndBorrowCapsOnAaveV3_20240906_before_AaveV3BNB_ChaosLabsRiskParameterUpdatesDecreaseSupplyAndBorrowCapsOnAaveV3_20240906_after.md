## Reserve changes

### Reserves altered

#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 50,000,000 USDC | 15,000,000 USDC |
| borrowCap | 45,000,000 USDC | 10,000,000 USDC |


## Raw diff

```json
{
  "reserves": {
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "borrowCap": {
        "from": 45000000,
        "to": 10000000
      },
      "supplyCap": {
        "from": 50000000,
        "to": 15000000
      }
    }
  }
}
```