## Reserve changes

### Reserve altered

#### cbETH ([0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22](https://basescan.org/address/0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22))

| description | value before | value after |
| --- | --- | --- |
| ltv | 67 % [6700] | 75 % [7500] |
| liquidationThreshold | 74 % [7400] | 79 % [7900] |


#### wstETH ([0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452](https://basescan.org/address/0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452))

| description | value before | value after |
| --- | --- | --- |
| ltv | 71 % [7100] | 75 % [7500] |
| liquidationThreshold | 76 % [7600] | 79 % [7900] |


## Raw diff

```json
{
  "reserves": {
    "0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22": {
      "liquidationThreshold": {
        "from": 7400,
        "to": 7900
      },
      "ltv": {
        "from": 6700,
        "to": 7500
      }
    },
    "0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452": {
      "liquidationThreshold": {
        "from": 7600,
        "to": 7900
      },
      "ltv": {
        "from": 7100,
        "to": 7500
      }
    }
  }
}
```