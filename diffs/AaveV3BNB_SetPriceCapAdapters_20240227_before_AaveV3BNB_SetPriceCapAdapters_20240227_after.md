## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xB97Ad0E74fa7d920791E90258A6E2085088b4320](https://bscscan.com/address/0xB97Ad0E74fa7d920791E90258A6E2085088b4320) | [0x0F682319Ed4A240b7a2599A48C965049515D9bC3](https://bscscan.com/address/0x0F682319Ed4A240b7a2599A48C965049515D9bC3) |
| oracleDescription | USDT / USD | Capped USDT/USD |


#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x51597f405303C4377E36123cBc172b13269EA163](https://bscscan.com/address/0x51597f405303C4377E36123cBc172b13269EA163) | [0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1](https://bscscan.com/address/0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1) |
| oracleDescription | USDC / USD | Capped USDC/USD |


## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "oracle": {
        "from": "0xB97Ad0E74fa7d920791E90258A6E2085088b4320",
        "to": "0x0F682319Ed4A240b7a2599A48C965049515D9bC3"
      },
      "oracleDescription": {
        "from": "USDT / USD",
        "to": "Capped USDT/USD"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "oracle": {
        "from": "0x51597f405303C4377E36123cBc172b13269EA163",
        "to": "0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    }
  }
}
```