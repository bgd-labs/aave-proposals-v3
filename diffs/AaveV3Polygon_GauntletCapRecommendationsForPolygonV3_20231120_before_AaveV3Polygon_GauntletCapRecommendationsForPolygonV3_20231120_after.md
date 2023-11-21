## Reserve changes

### Reserve altered

#### jEUR ([0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c](https://polygonscan.com/address/0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 0 jEUR | 120,000 jEUR |
| borrowCap | 0 jEUR | 100,000 jEUR |


#### agEUR ([0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4](https://polygonscan.com/address/0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 0 agEUR | 300,000 agEUR |
| borrowCap | 0 agEUR | 250,000 agEUR |


## Raw diff

```json
{
  "reserves": {
    "0x4e3Decbb3645551B8A19f0eA1678079FCB33fB4c": {
      "borrowCap": {
        "from": 0,
        "to": 100000
      },
      "supplyCap": {
        "from": 0,
        "to": 120000
      }
    },
    "0xE0B52e49357Fd4DAf2c15e02058DCE6BC0057db4": {
      "borrowCap": {
        "from": 0,
        "to": 250000
      },
      "supplyCap": {
        "from": 0,
        "to": 300000
      }
    }
  }
}
```