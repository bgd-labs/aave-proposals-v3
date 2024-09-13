## Reserve changes

### Reserve altered

#### wstETH ([0x5979D7b546E38E414F7E9822514be443A4800529](https://arbiscan.io/address/0x5979D7b546E38E414F7E9822514be443A4800529))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 75 % [7500] |


#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 82.5 % [8250] | 80 % [8000] |
| liquidationThreshold | 85 % [8500] | 84 % [8400] |


#### rETH ([0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8](https://arbiscan.io/address/0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 67 % [6700] | 69 % [6900] |


#### AAVE ([0xba5DdD1f9d7F570dc94a51479a000E3BCE967196](https://arbiscan.io/address/0xba5DdD1f9d7F570dc94a51479a000E3BCE967196))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % [5000] | 63 % [6300] |
| liquidationThreshold | 65 % [6500] | 70 % [7000] |


#### LINK ([0xf97f4df75117a78c1A5a0DBb814Af92458539FB4](https://arbiscan.io/address/0xf97f4df75117a78c1A5a0DBb814Af92458539FB4))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 66 % [6600] |
| liquidationThreshold | 77.5 % [7750] | 75 % [7500] |


## Raw diff

```json
{
  "reserves": {
    "0x5979D7b546E38E414F7E9822514be443A4800529": {
      "ltv": {
        "from": 7000,
        "to": 7500
      }
    },
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "liquidationThreshold": {
        "from": 8500,
        "to": 8400
      },
      "ltv": {
        "from": 8250,
        "to": 8000
      }
    },
    "0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8": {
      "ltv": {
        "from": 6700,
        "to": 6900
      }
    },
    "0xba5DdD1f9d7F570dc94a51479a000E3BCE967196": {
      "liquidationThreshold": {
        "from": 6500,
        "to": 7000
      },
      "ltv": {
        "from": 5000,
        "to": 6300
      }
    },
    "0xf97f4df75117a78c1A5a0DBb814Af92458539FB4": {
      "liquidationThreshold": {
        "from": 7750,
        "to": 7500
      },
      "ltv": {
        "from": 7000,
        "to": 6600
      }
    }
  }
}
```