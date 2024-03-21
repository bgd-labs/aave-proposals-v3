## Reserve changes

### Reserve altered

#### sUSD ([0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 20 % |


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
    "0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
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