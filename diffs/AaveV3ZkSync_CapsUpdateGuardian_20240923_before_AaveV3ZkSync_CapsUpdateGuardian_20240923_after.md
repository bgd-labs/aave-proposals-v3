## Reserve changes

### Reserve altered

#### USDC ([0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4](https://era.zksync.network//address/0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000 USDC | 1,000,000 USDC |
| borrowCap | 9,000 USDC | 900,000 USDC |
| address | null | [0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1](https://era.zksync.network//address/0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1) |
| baseVariableBorrowRate | null | 0 |
| maxVariableBorrowRate | null | 655000000000000000000000000 |
| optimalUsageRatio | null | 900000000000000000000000000 |
| variableRateSlope1 | null | 55000000000000000000000000 |
| variableRateSlope2 | null | 600000000000000000000000000 |


#### USDT ([0x493257fD37EDB34451f62EDf8D2a0C418852bA4C](https://era.zksync.network//address/0x493257fD37EDB34451f62EDf8D2a0C418852bA4C))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000 USDT | 3,000,000 USDT |
| borrowCap | 9,000 USDT | 2,700,000 USDT |
| address | null | [0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1](https://era.zksync.network//address/0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1) |
| baseVariableBorrowRate | null | 0 |
| maxVariableBorrowRate | null | 655000000000000000000000000 |
| optimalUsageRatio | null | 900000000000000000000000000 |
| variableRateSlope1 | null | 55000000000000000000000000 |
| variableRateSlope2 | null | 600000000000000000000000000 |


#### ZK ([0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E](https://era.zksync.network//address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 100,000 ZK | 18,000,000 ZK |
| borrowCap | 55,000 ZK | 10,000,000 ZK |
| address | null | [0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1](https://era.zksync.network//address/0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1) |
| baseVariableBorrowRate | null | 0 |
| maxVariableBorrowRate | null | 3090000000000000000000000000 |
| optimalUsageRatio | null | 450000000000000000000000000 |
| variableRateSlope1 | null | 90000000000000000000000000 |
| variableRateSlope2 | null | 3000000000000000000000000000 |


#### WETH ([0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91](https://era.zksync.network//address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 5 WETH | 1,000 WETH |
| borrowCap | 4 WETH | 900 WETH |
| address | null | [0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1](https://era.zksync.network//address/0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1) |
| baseVariableBorrowRate | null | 0 |
| maxVariableBorrowRate | null | 827000000000000000000000000 |
| optimalUsageRatio | null | 900000000000000000000000000 |
| variableRateSlope1 | null | 27000000000000000000000000 |
| variableRateSlope2 | null | 800000000000000000000000000 |


#### wstETH ([0x703b52F2b28fEbcB60E1372858AF5b18849FE867](https://era.zksync.network//address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 3 wstETH | 300 wstETH |
| borrowCap | 1 wstETH | 30 wstETH |
| address | null | [0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1](https://era.zksync.network//address/0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1) |
| baseVariableBorrowRate | null | 0 |
| maxVariableBorrowRate | null | 845000000000000000000000000 |
| optimalUsageRatio | null | 450000000000000000000000000 |
| variableRateSlope1 | null | 45000000000000000000000000 |
| variableRateSlope2 | null | 800000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4": {
      "borrowCap": {
        "from": 9000,
        "to": 900000
      },
      "supplyCap": {
        "from": 10000,
        "to": 1000000
      },
      "address": {
        "from": null,
        "to": "0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1"
      },
      "baseVariableBorrowRate": {
        "from": null,
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": null,
        "to": "655000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": null,
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": null,
        "to": "55000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": null,
        "to": "600000000000000000000000000"
      }
    },
    "0x493257fD37EDB34451f62EDf8D2a0C418852bA4C": {
      "borrowCap": {
        "from": 9000,
        "to": 2700000
      },
      "supplyCap": {
        "from": 10000,
        "to": 3000000
      },
      "address": {
        "from": null,
        "to": "0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1"
      },
      "baseVariableBorrowRate": {
        "from": null,
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": null,
        "to": "655000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": null,
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": null,
        "to": "55000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": null,
        "to": "600000000000000000000000000"
      }
    },
    "0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E": {
      "borrowCap": {
        "from": 55000,
        "to": 10000000
      },
      "supplyCap": {
        "from": 100000,
        "to": 18000000
      },
      "address": {
        "from": null,
        "to": "0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1"
      },
      "baseVariableBorrowRate": {
        "from": null,
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": null,
        "to": "3090000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": null,
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": null,
        "to": "90000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": null,
        "to": "3000000000000000000000000000"
      }
    },
    "0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91": {
      "borrowCap": {
        "from": 4,
        "to": 900
      },
      "supplyCap": {
        "from": 5,
        "to": 1000
      },
      "address": {
        "from": null,
        "to": "0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1"
      },
      "baseVariableBorrowRate": {
        "from": null,
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": null,
        "to": "827000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": null,
        "to": "900000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": null,
        "to": "27000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": null,
        "to": "800000000000000000000000000"
      }
    },
    "0x703b52F2b28fEbcB60E1372858AF5b18849FE867": {
      "borrowCap": {
        "from": 1,
        "to": 30
      },
      "supplyCap": {
        "from": 3,
        "to": 300
      },
      "address": {
        "from": null,
        "to": "0x73E2D854e809504b8e6d4e29ddae4ac5b40d5be1"
      },
      "baseVariableBorrowRate": {
        "from": null,
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": null,
        "to": "845000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": null,
        "to": "450000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": null,
        "to": "45000000000000000000000000"
      },
      "variableRateSlope2": {
        "from": null,
        "to": "800000000000000000000000000"
      }
    }
  }
}
```