## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xd56eE97960b1b2953e751151Fd84888cF3F3b521](https://arbiscan.io/address/0xd56eE97960b1b2953e751151Fd84888cF3F3b521) | [0x42ec99A020B78C449d17d93bC4c89e0189B5811d](https://arbiscan.io/address/0x42ec99A020B78C449d17d93bC4c89e0189B5811d) |
| variableRateSlope1 | 3 % | 2.7 % |
| baseStableBorrowRate | 6 % | 5.7 % |
| interestRate | ![before](/.assets/908311237d838343e639cb1728e1fd729c5dfb53.svg) | ![after](/.assets/6b6d7d3b24423799c0cb5cc8c539f10b55adce0b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "interestRateStrategy": {
        "from": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521",
        "to": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d"
      }
    }
  },
  "strategies": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "address": {
        "from": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521",
        "to": "0x42ec99A020B78C449d17d93bC4c89e0189B5811d"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "30000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```