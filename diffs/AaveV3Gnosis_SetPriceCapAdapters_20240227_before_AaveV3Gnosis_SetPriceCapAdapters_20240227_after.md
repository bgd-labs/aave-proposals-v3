## Reserve changes

### Reserve altered

#### wstETH ([0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xcb0670258e5961CCA85D8F71D29C1167Ef20De99](https://gnosisscan.io/address/0xcb0670258e5961CCA85D8F71D29C1167Ef20De99) | [0x8Ee42Ba520cA106294163fb8b1ffE9C6Fba35507](https://gnosisscan.io/address/0x8Ee42Ba520cA106294163fb8b1ffE9C6Fba35507) |
| oracleDescription | wstETH/ETH/USD | Capped wstETH / stETH(ETH) / USD |


#### USDC ([0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83](https://gnosisscan.io/address/0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x26C31ac71010aF62E6B486D1132E266D6298857D](https://gnosisscan.io/address/0x26C31ac71010aF62E6B486D1132E266D6298857D) | [0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2](https://gnosisscan.io/address/0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2) |
| oracleDescription | USDC / USD | Capped USDC/USD |


#### WXDAI ([0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d](https://gnosisscan.io/address/0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x678df3415fc31947dA4324eC63212874be5a82f8](https://gnosisscan.io/address/0x678df3415fc31947dA4324eC63212874be5a82f8) | [0xE5269eF0CE04E509E8134624c7BF043b21e10897](https://gnosisscan.io/address/0xE5269eF0CE04E509E8134624c7BF043b21e10897) |
| oracleDescription | DAI / USD | Capped wXDAI/USD |


## Raw diff

```json
{
  "reserves": {
    "0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6": {
      "oracle": {
        "from": "0xcb0670258e5961CCA85D8F71D29C1167Ef20De99",
        "to": "0x8Ee42Ba520cA106294163fb8b1ffE9C6Fba35507"
      },
      "oracleDescription": {
        "from": "wstETH/ETH/USD",
        "to": "Capped wstETH / stETH(ETH) / USD"
      }
    },
    "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83": {
      "oracle": {
        "from": "0x26C31ac71010aF62E6B486D1132E266D6298857D",
        "to": "0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    },
    "0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d": {
      "oracle": {
        "from": "0x678df3415fc31947dA4324eC63212874be5a82f8",
        "to": "0xE5269eF0CE04E509E8134624c7BF043b21e10897"
      },
      "oracleDescription": {
        "from": "DAI / USD",
        "to": "Capped wXDAI/USD"
      }
    }
  }
}
```