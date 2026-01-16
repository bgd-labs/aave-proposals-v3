## Reserve changes

### Reserve altered

#### ZK ([0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E](https://era.zksync.network//address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### WETH ([0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91](https://era.zksync.network//address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wstETH ([0x703b52F2b28fEbcB60E1372858AF5b18849FE867](https://era.zksync.network//address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867))

| description | value before | value after |
| --- | --- | --- |
| ltv | 71 % [7100] | 0 % [0] |
| borrowingEnabled | true | false |


#### sUSDe ([0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8](https://era.zksync.network//address/0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % [6500] | 0 % [0] |


#### wrsETH ([0xd4169E045bcF9a86cC00101225d9ED61D2F51af2](https://era.zksync.network//address/0xd4169E045bcF9a86cC00101225d9ED61D2F51af2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x703b52F2b28fEbcB60E1372858AF5b18849FE867": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7100,
        "to": 0
      }
    },
    "0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8": {
      "ltv": {
        "from": 6500,
        "to": 0
      }
    },
    "0xd4169E045bcF9a86cC00101225d9ED61D2F51af2": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    }
  },
  "raw": {}
}
```