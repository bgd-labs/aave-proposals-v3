## Reserve changes

### Reserve altered

#### stMATIC ([0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4](https://polygonscan.com/address/0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4))

| description | value before | value after |
| --- | --- | --- |
| ltv | 45 % | 48 % |
| liquidationThreshold | 56 % | 58 % |


#### MaticX ([0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6](https://polygonscan.com/address/0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 45 % | 50 % |
| liquidationThreshold | 58 % | 60 % |


## Raw diff

```json
{
  "reserves": {
    "0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4": {
      "liquidationThreshold": {
        "from": 5600,
        "to": 5800
      },
      "ltv": {
        "from": 4500,
        "to": 4800
      }
    },
    "0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6": {
      "liquidationThreshold": {
        "from": 5800,
        "to": 6000
      },
      "ltv": {
        "from": 4500,
        "to": 5000
      }
    }
  }
}
```