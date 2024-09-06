## Reserve changes

### Reserve altered

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 25,000,000 DAI | 10,000,000 DAI |
| borrowCap | 16,000,000 DAI | 7,000,000 DAI |


#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 3,000,000 LUSD | 2,000,000 LUSD |
| borrowCap | 1,210,000 LUSD | 500,000 LUSD |


## Raw diff

```json
{
  "reserves": {
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "borrowCap": {
        "from": 16000000,
        "to": 7000000
      },
      "supplyCap": {
        "from": 25000000,
        "to": 10000000
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "borrowCap": {
        "from": 1210000,
        "to": 500000
      },
      "supplyCap": {
        "from": 3000000,
        "to": 2000000
      }
    }
  }
}
```