## Reserve changes

### Reserve altered

#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowscan.xyz/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 75 % |
| liquidationThreshold | 80 % | 78 % |


#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowscan.xyz/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| ltv | 82.5 % | 80 % |
| liquidationThreshold | 86.25 % | 85 % |


#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 82 % | 80 % |


## Raw diff

```json
{
  "reserves": {
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7800
      },
      "ltv": {
        "from": 7700,
        "to": 7500
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "liquidationThreshold": {
        "from": 8625,
        "to": 8500
      },
      "ltv": {
        "from": 8250,
        "to": 8000
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "liquidationThreshold": {
        "from": 8200,
        "to": 8000
      }
    }
  }
}
```