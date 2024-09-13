## Reserve changes

### Reserve altered

#### WETH ([0x420000000000000000000000000000000000000A](https://explorer.metis.io/address/0x420000000000000000000000000000000000000A))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 82.5 % [8250] | 83 % [8300] |


#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80 % [8000] | 75 % [7500] |
| liquidationThreshold | 85 % [8500] | 83 % [8300] |


#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % [7700] | 75 % [7500] |
| liquidationThreshold | 80 % [8000] | 78 % [7800] |


## Raw diff

```json
{
  "reserves": {
    "0x420000000000000000000000000000000000000A": {
      "liquidationThreshold": {
        "from": 8250,
        "to": 8300
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "liquidationThreshold": {
        "from": 8500,
        "to": 8300
      },
      "ltv": {
        "from": 8000,
        "to": 7500
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7800
      },
      "ltv": {
        "from": 7700,
        "to": 7500
      }
    }
  }
}
```