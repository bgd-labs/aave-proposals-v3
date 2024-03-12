## Reserve changes

### Reserve altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x43d12Fb3AfCAd5347fA764EeAB105478337b7200](https://scrollscan.com/address/0x43d12Fb3AfCAd5347fA764EeAB105478337b7200) | [0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee](https://scrollscan.com/address/0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee) |
| oracleDescription | USDC / USD | Capped USDC/USD |


#### wstETH ([0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32](https://scrollscan.com/address/0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xdb93e2712a8B36835078f8D28c70fCC95FD6d37c](https://scrollscan.com/address/0xdb93e2712a8B36835078f8D28c70fCC95FD6d37c) | [0x4EdAbf45e78363b8Dcd763bBbd05665c6e24975C](https://scrollscan.com/address/0x4EdAbf45e78363b8Dcd763bBbd05665c6e24975C) |
| oracleDescription | wstETH/ETH/USD | Capped wstETH / stETH(ETH) / USD |


## Raw diff

```json
{
  "reserves": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "oracle": {
        "from": "0x43d12Fb3AfCAd5347fA764EeAB105478337b7200",
        "to": "0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    },
    "0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32": {
      "oracle": {
        "from": "0xdb93e2712a8B36835078f8D28c70fCC95FD6d37c",
        "to": "0x4EdAbf45e78363b8Dcd763bBbd05665c6e24975C"
      },
      "oracleDescription": {
        "from": "wstETH/ETH/USD",
        "to": "Capped wstETH / stETH(ETH) / USD"
      }
    }
  }
}
```