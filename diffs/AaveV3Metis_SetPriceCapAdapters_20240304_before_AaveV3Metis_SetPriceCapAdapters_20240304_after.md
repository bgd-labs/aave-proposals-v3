## Reserve changes

### Reserve altered

#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://andromeda-explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xe0351cAAE70B5AdBD0107cD5331AD1D79c4c1CA1](https://andromeda-explorer.metis.io/address/0xe0351cAAE70B5AdBD0107cD5331AD1D79c4c1CA1) | [0xB3721282cd62Ba8F7bB02Cb843F3a34f9e109ef8](https://andromeda-explorer.metis.io/address/0xB3721282cd62Ba8F7bB02Cb843F3a34f9e109ef8) |
| oracleDescription | DAI / USD | Capped mDAI/USD |


#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://andromeda-explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x663855969c85F3BE415807250414Ca9129533a5f](https://andromeda-explorer.metis.io/address/0x663855969c85F3BE415807250414Ca9129533a5f) | [0xF2acD6aE4fcf662161eA354dA844f224bf91FF8c](https://andromeda-explorer.metis.io/address/0xF2acD6aE4fcf662161eA354dA844f224bf91FF8c) |
| oracleDescription | USDC / USD | Capped mUSDC/USD |


#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://andromeda-explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x51864b8948Aa5e35aace2BaDaF901D63418A3b9D](https://andromeda-explorer.metis.io/address/0x51864b8948Aa5e35aace2BaDaF901D63418A3b9D) | [0xD1D7DCBDE72916646A7F8AcE6Ad8C5179D8ddFbB](https://andromeda-explorer.metis.io/address/0xD1D7DCBDE72916646A7F8AcE6Ad8C5179D8ddFbB) |
| oracleDescription | USDT / USD | Capped mUSDT/USD |


## Raw diff

```json
{
  "reserves": {
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "oracle": {
        "from": "0xe0351cAAE70B5AdBD0107cD5331AD1D79c4c1CA1",
        "to": "0xB3721282cd62Ba8F7bB02Cb843F3a34f9e109ef8"
      },
      "oracleDescription": {
        "from": "DAI / USD",
        "to": "Capped mDAI/USD"
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "oracle": {
        "from": "0x663855969c85F3BE415807250414Ca9129533a5f",
        "to": "0xF2acD6aE4fcf662161eA354dA844f224bf91FF8c"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped mUSDC/USD"
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "oracle": {
        "from": "0x51864b8948Aa5e35aace2BaDaF901D63418A3b9D",
        "to": "0xD1D7DCBDE72916646A7F8AcE6Ad8C5179D8ddFbB"
      },
      "oracleDescription": {
        "from": "USDT / USD",
        "to": "Capped mUSDT/USD"
      }
    }
  }
}
```