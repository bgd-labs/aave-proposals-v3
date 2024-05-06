## Reserve changes

### Reserve altered

#### USDC ([0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85](https://optimistic.etherscan.io/address/0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 75 % |
| liquidationThreshold | 79 % | 78 % |


#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| ltv | 78 % | 75 % |
| liquidationThreshold | 84 % | 80 % |


#### USDT ([0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58))

| description | value before | value after |
| --- | --- | --- |
| ltv | 76 % | 75 % |
| liquidationThreshold | 79 % | 78 % |


## Raw diff

```json
{
  "reserves": {
    "0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7800
      },
      "ltv": {
        "from": 7600,
        "to": 7500
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "liquidationThreshold": {
        "from": 8400,
        "to": 8000
      },
      "ltv": {
        "from": 7800,
        "to": 7500
      }
    },
    "0x94b008aA00579c1307B0EF2c499aD98a8ce58e58": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 7800
      },
      "ltv": {
        "from": 7600,
        "to": 7500
      }
    }
  }
}
```