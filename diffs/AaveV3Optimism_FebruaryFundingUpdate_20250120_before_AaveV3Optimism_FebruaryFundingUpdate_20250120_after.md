## Reserve changes

### Reserve altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 4,000.4553 WETH [4000455388648726998815] | 4,004.8888 WETH [4004888876661351023123] |
| virtualBalance | 4,000.4553 WETH [4000455388648726998815] | 4,004.8888 WETH [4004888876661351023123] |


#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 410,124.1280 USDC [410124128074] | 414,554.0078 USDC [414554007831] |
| virtualBalance | 410,047.0812 USDC [410047081212] | 414,476.9609 USDC [414476960969] |


#### USDT ([0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 3,131,348.2900 USDT [3131348290005] | 3,133,406.7514 USDT [3133406751481] |
| virtualBalance | 3,131,289.0356 USDT [3131289035605] | 3,133,347.4970 USDT [3133347497081] |


## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "aTokenUnderlyingBalance": {
        "from": "4000455388648726998815",
        "to": "4004888876661351023123"
      },
      "virtualBalance": {
        "from": "4000455388648726998815",
        "to": "4004888876661351023123"
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "aTokenUnderlyingBalance": {
        "from": "410124128074",
        "to": "414554007831"
      },
      "virtualBalance": {
        "from": "410047081212",
        "to": "414476960969"
      }
    },
    "0x94b008aA00579c1307B0EF2c499aD98a8ce58e58": {
      "aTokenUnderlyingBalance": {
        "from": "3131348290005",
        "to": "3133406751481"
      },
      "virtualBalance": {
        "from": "3131289035605",
        "to": "3133347497081"
      }
    }
  }
}
```