## Reserve changes

### Reserve altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x736bF902680e68989886e9807CD7Db4B3E015d3C](https://etherscan.io/address/0x736bF902680e68989886e9807CD7Db4B3E015d3C) | [0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA](https://etherscan.io/address/0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA) |


#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6](https://etherscan.io/address/0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6) | [0x94C7FD62fd0506e71d8142E9D36687fC72A86B02](https://etherscan.io/address/0x94C7FD62fd0506e71d8142E9D36687fC72A86B02) |
| oracleDescription | Capped USDS <-> DAI / USD | Capped USDS/USD |
| oracleLatestAnswer | 1.00002917 | 0.99804349 |


## Raw diff

```json
{
  "reserves": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "oracle": {
        "from": "0x736bF902680e68989886e9807CD7Db4B3E015d3C",
        "to": "0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA"
      }
    },
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "oracle": {
        "from": "0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6",
        "to": "0x94C7FD62fd0506e71d8142E9D36687fC72A86B02"
      },
      "oracleDescription": {
        "from": "Capped USDS <-> DAI / USD",
        "to": "Capped USDS/USD"
      },
      "oracleLatestAnswer": {
        "from": "100002917",
        "to": "99804349"
      }
    }
  }
}
```