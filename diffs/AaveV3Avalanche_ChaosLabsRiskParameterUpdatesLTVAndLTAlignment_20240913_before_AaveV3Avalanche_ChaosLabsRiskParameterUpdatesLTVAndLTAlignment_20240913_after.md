## Reserve changes

### Reserve altered

#### WETH.e ([0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB](https://snowtrace.io/address/0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 82.5 % [8250] | 83 % [8300] |


#### LINK.e ([0x5947BB275c521040051D82396192181b413227A3](https://snowtrace.io/address/0x5947BB275c521040051D82396192181b413227A3))

| description | value before | value after |
| --- | --- | --- |
| ltv | 56 % [5600] | 66 % [6600] |


#### AAVE.e ([0x63a72806098Bd3D9520cC43356dD78afe5D386D9](https://snowtrace.io/address/0x63a72806098Bd3D9520cC43356dD78afe5D386D9))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % [6000] | 63 % [6300] |
| liquidationThreshold | 71.3 % [7130] | 70 % [7000] |


#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowtrace.io/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 81 % [8100] | 79.5 % [7950] |


## Raw diff

```json
{
  "reserves": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "liquidationThreshold": {
        "from": 8250,
        "to": 8300
      }
    },
    "0x5947BB275c521040051D82396192181b413227A3": {
      "ltv": {
        "from": 5600,
        "to": 6600
      }
    },
    "0x63a72806098Bd3D9520cC43356dD78afe5D386D9": {
      "liquidationThreshold": {
        "from": 7130,
        "to": 7000
      },
      "ltv": {
        "from": 6000,
        "to": 6300
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "liquidationThreshold": {
        "from": 8100,
        "to": 7950
      }
    }
  }
}
```