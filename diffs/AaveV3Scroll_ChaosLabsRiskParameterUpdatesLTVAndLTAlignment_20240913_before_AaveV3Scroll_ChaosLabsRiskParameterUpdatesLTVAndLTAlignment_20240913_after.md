## Reserve changes

### Reserve altered

#### WETH ([0x5300000000000000000000000000000000000004](https://scrollscan.com/address/0x5300000000000000000000000000000000000004))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 80 % [8000] |
| liquidationThreshold | 78 % [7800] | 83 % [8300] |


#### wstETH ([0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32](https://scrollscan.com/address/0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 78 % [7800] | 79 % [7900] |


## Raw diff

```json
{
  "reserves": {
    "0x5300000000000000000000000000000000000004": {
      "liquidationThreshold": {
        "from": 7800,
        "to": 8300
      },
      "ltv": {
        "from": 7500,
        "to": 8000
      }
    },
    "0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32": {
      "liquidationThreshold": {
        "from": 7800,
        "to": 7900
      }
    }
  }
}
```