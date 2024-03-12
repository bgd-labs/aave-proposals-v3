## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514](https://arbiscan.io/address/0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514) | [0xd56eE97960b1b2953e751151Fd84888cF3F3b521](https://arbiscan.io/address/0xd56eE97960b1b2953e751151Fd84888cF3F3b521) |
| variableRateSlope1 | 3.3 % | 3 % |
| baseStableBorrowRate | 6.3 % | 6 % |
| interestRate | ![before](/.assets/4870b62e3dee98639241facda7590d661b69fb62.svg) | ![after](/.assets/908311237d838343e639cb1728e1fd729c5dfb53.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "interestRateStrategy": {
        "from": "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514",
        "to": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521"
      }
    }
  },
  "strategies": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "address": {
        "from": "0xAC4f9019608f3A359Ba6a576DC4deC9561D2e514",
        "to": "0xd56eE97960b1b2953e751151Fd84888cF3F3b521"
      },
      "baseStableBorrowRate": {
        "from": "63000000000000000000000000",
        "to": "60000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "33000000000000000000000000",
        "to": "30000000000000000000000000"
      }
    }
  }
}
```