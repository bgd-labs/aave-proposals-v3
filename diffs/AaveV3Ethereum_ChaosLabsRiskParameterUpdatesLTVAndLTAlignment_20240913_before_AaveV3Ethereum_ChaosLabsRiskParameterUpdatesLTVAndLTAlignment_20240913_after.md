## Reserve changes

### Reserve altered

#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| ltv | 53 % [5300] | 66 % [6600] |
| liquidationThreshold | 68 % [6800] | 71 % [7100] |


#### cbETH ([0xBe9895146f7AF43049ca1c1AE358B0541Ea49704](https://etherscan.io/address/0xBe9895146f7AF43049ca1c1AE358B0541Ea49704))

| description | value before | value after |
| --- | --- | --- |
| ltv | 74.5 % [7450] | 75 % [7500] |
| liquidationThreshold | 77 % [7700] | 79 % [7900] |


#### rETH ([0xae78736Cd615f374D3085123A210448E74Fc6393](https://etherscan.io/address/0xae78736Cd615f374D3085123A210448E74Fc6393))

| description | value before | value after |
| --- | --- | --- |
| ltv | 74.5 % [7450] | 75 % [7500] |
| liquidationThreshold | 77 % [7700] | 79 % [7900] |


## Raw diff

```json
{
  "reserves": {
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "liquidationThreshold": {
        "from": 6800,
        "to": 7100
      },
      "ltv": {
        "from": 5300,
        "to": 6600
      }
    },
    "0xBe9895146f7AF43049ca1c1AE358B0541Ea49704": {
      "liquidationThreshold": {
        "from": 7700,
        "to": 7900
      },
      "ltv": {
        "from": 7450,
        "to": 7500
      }
    },
    "0xae78736Cd615f374D3085123A210448E74Fc6393": {
      "liquidationThreshold": {
        "from": 7700,
        "to": 7900
      },
      "ltv": {
        "from": 7450,
        "to": 7500
      }
    }
  }
}
```