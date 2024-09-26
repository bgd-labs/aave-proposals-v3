## Reserve changes

### Reserve altered

#### wstETH ([0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD](https://polygonscan.com/address/0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 75 % [7500] |


#### LINK ([0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39](https://polygonscan.com/address/0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39))

| description | value before | value after |
| --- | --- | --- |
| ltv | 53 % [5300] | 66 % [6600] |
| liquidationThreshold | 68 % [6800] | 71 % [7100] |


#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 82.5 % [8250] | 83 % [8300] |


#### AAVE ([0xD6DF932A45C0f255f85145f286eA0b292B21C90B](https://polygonscan.com/address/0xD6DF932A45C0f255f85145f286eA0b292B21C90B))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % [6000] | 63 % [6300] |


## Raw diff

```json
{
  "reserves": {
    "0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD": {
      "ltv": {
        "from": 7000,
        "to": 7500
      }
    },
    "0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39": {
      "liquidationThreshold": {
        "from": 6800,
        "to": 7100
      },
      "ltv": {
        "from": 5300,
        "to": 6600
      }
    },
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "liquidationThreshold": {
        "from": 8250,
        "to": 8300
      }
    },
    "0xD6DF932A45C0f255f85145f286eA0b292B21C90B": {
      "ltv": {
        "from": 6000,
        "to": 6300
      }
    }
  }
}
```