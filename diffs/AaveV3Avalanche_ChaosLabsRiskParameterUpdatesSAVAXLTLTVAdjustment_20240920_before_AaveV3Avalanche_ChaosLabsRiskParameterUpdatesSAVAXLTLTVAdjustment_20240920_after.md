## Reserve changes

### Reserve altered

#### sAVAX ([0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE](https://snowtrace.io/address/0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE))

| description | value before | value after |
| --- | --- | --- |
| ltv | 40 % [4000] | 50 % [5000] |
| liquidationThreshold | 45 % [4500] | 55 % [5500] |
| eMode.ltv | 92.5 % | 93 % |


#### WAVAX ([0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://snowtrace.io/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7))

| description | value before | value after |
| --- | --- | --- |
| eMode.ltv | 92.5 % | 93 % |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "ltv": {
        "from": 9250,
        "to": 9300
      }
    }
  },
  "reserves": {
    "0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE": {
      "liquidationThreshold": {
        "from": 4500,
        "to": 5500
      },
      "ltv": {
        "from": 4000,
        "to": 5000
      }
    }
  }
}
```