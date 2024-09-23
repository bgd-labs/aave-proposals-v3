## Reserve changes

### Reserve altered

#### USDC ([0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4](https://era.zksync.network//address/0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000 USDC | 1,000,000 USDC |
| borrowCap | 9,000 USDC | 900,000 USDC |


#### USDT ([0x493257fD37EDB34451f62EDf8D2a0C418852bA4C](https://era.zksync.network//address/0x493257fD37EDB34451f62EDf8D2a0C418852bA4C))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000 USDT | 3,000,000 USDT |
| borrowCap | 9,000 USDT | 2,700,000 USDT |


#### ZK ([0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E](https://era.zksync.network//address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 100,000 ZK | 18,000,000 ZK |
| borrowCap | 55,000 ZK | 10,000,000 ZK |


#### WETH ([0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91](https://era.zksync.network//address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 5 WETH | 1,000 WETH |
| borrowCap | 4 WETH | 900 WETH |


#### wstETH ([0x703b52F2b28fEbcB60E1372858AF5b18849FE867](https://era.zksync.network//address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 3 wstETH | 300 wstETH |
| borrowCap | 1 wstETH | 30 wstETH |

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
      }
    }
  }
}
```
