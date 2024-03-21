## Reserve changes

### Reserve altered

#### FRAX ([0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % | 0 % |
| liquidationThreshold | 75 % | 72 % |
| reserveFactor | 10 % | 20 % |


#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 20 % |


#### EURS ([0xD22a58f79e9481D1a88e00c343885A588b34b68B](https://arbiscan.io/address/0xD22a58f79e9481D1a88e00c343885A588b34b68B))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 65 % | 0 % |
| liquidationThreshold | 70 % | 67 % |
| reserveFactor | 10 % | 20 % |


#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://arbiscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 25 % |


## Raw diff

```json
{
  "reserves": {
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
      "liquidationThreshold": {
        "from": 7500,
        "to": 7200
      },
      "ltv": {
        "from": 7000,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0xD22a58f79e9481D1a88e00c343885A588b34b68B": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "liquidationThreshold": {
        "from": 7000,
        "to": 6700
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
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
    }
  }
}
```