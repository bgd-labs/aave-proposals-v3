## Reserve changes

### Reserve altered

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 85,000,000 sUSDe | 4,000,000 sUSDe |


#### crvUSD ([0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E](https://etherscan.io/address/0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 60,000,000 crvUSD | 5,000,000 crvUSD |
| borrowCap | 50,000,000 crvUSD | 2,500,000 crvUSD |


## Raw diff

```json
{
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "supplyCap": {
        "from": 85000000,
        "to": 4000000
      }
    },
    "0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E": {
      "borrowCap": {
        "from": 50000000,
        "to": 2500000
      },
      "supplyCap": {
        "from": 60000000,
        "to": 5000000
      }
    }
  }
}
```