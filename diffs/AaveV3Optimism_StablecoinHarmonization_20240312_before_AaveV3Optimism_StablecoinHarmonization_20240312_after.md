## Reserve changes

### Reserve altered

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 25 % |


#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 20 % |


## Raw diff

```json
{
  "reserves": {
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    }
  }
}
```