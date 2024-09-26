## Reserve changes

### Reserve altered

#### WETH ([0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1](https://gnosisscan.io/address/0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 80 % [8000] |
| liquidationThreshold | 78 % [7800] | 83 % [8300] |


#### wstETH ([0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 78 % [7800] | 79 % [7900] |


## Raw diff

```json
{
  "reserves": {
    "0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1": {
      "liquidationThreshold": {
        "from": 7800,
        "to": 8300
      },
      "ltv": {
        "from": 7500,
        "to": 8000
      }
    },
    "0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6": {
      "liquidationThreshold": {
        "from": 7800,
        "to": 7900
      }
    }
  }
}
```