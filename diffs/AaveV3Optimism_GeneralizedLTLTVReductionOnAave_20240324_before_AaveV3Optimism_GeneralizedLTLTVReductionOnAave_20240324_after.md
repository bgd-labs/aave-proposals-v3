## Reserve changes

### Reserve altered

#### USDC ([0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80 % | 78 % |
| liquidationThreshold | 85 % | 84 % |


#### USDT ([0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 76 % |
| liquidationThreshold | 80 % | 79 % |


#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 78 % | 75 % |
| liquidationThreshold | 83 % | 80 % |


## Raw diff

```json
{
  "reserves": {
    "0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "liquidationThreshold": {
        "from": 8500,
        "to": 8400
      },
      "ltv": {
        "from": 8000,
        "to": 7800
      }
    },
    "0x94b008aA00579c1307B0EF2c499aD98a8ce58e58": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7700,
        "to": 7600
      }
    },
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "liquidationThreshold": {
        "from": 8300,
        "to": 8000
      },
      "ltv": {
        "from": 7800,
        "to": 7500
      }
    }
  }
}
```