## Reserve changes

### Reserves altered

#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xBc92Ab176019E9670578D029CB638C9b1022Ad30](https://polygonscan.com/address/0xBc92Ab176019E9670578D029CB638C9b1022Ad30) | [0xEe9213B77eD95BDaDcE1aDA5812A3544b159E5E3](https://polygonscan.com/address/0xEe9213B77eD95BDaDcE1aDA5812A3544b159E5E3) |
| variableRateSlope1 | 4.75 % | 2.7 % |
| interestRate | ![before](/.assets/5d3a3114d827b817a09ba93dab4a7caff4a768cf.svg) | ![after](/.assets/0873847aaeec62529a46dfb86b634cab0f24ff85.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "interestRateStrategy": {
        "from": "0xBc92Ab176019E9670578D029CB638C9b1022Ad30",
        "to": "0xEe9213B77eD95BDaDcE1aDA5812A3544b159E5E3"
      }
    }
  },
  "strategies": {
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "address": {
        "from": "0xBc92Ab176019E9670578D029CB638C9b1022Ad30",
        "to": "0xEe9213B77eD95BDaDcE1aDA5812A3544b159E5E3"
      },
      "variableRateSlope1": {
        "from": "47500000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```