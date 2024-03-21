## Reserve changes

### Reserve altered

#### WBTC.e ([0x50b7545627a5162F82A992c33b87aDc75187B218](https://snowscan.xyz/address/0x50b7545627a5162F82A992c33b87aDc75187B218))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 70 % | 67 % |


#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowscan.xyz/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 0 % |
| liquidationThreshold | 80 % | 77 % |
| reserveFactor | 10 % | 20 % |


#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 25 % |


## Raw diff

```json
{
  "reserves": {
    "0x50b7545627a5162F82A992c33b87aDc75187B218": {
      "liquidationThreshold": {
        "from": 7000,
        "to": 6700
      }
    },
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7700
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      }
    }
  }
}
```