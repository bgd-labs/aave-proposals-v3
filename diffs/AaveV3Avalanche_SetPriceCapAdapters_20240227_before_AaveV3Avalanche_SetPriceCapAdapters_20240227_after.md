## Reserve changes

### Reserve altered

#### sAVAX ([0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE](https://snowscan.xyz/address/0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xc9245871D69BF4c36c6F2D15E0D68Ffa883FE1A7](https://snowscan.xyz/address/0xc9245871D69BF4c36c6F2D15E0D68Ffa883FE1A7) | [0xB2B332f27e4B7305649a228C31Ed9858c5a6bAD9](https://snowscan.xyz/address/0xB2B332f27e4B7305649a228C31Ed9858c5a6bAD9) |
| oracleDecimals | null | 8 |
| oracleDescription | null | Capped sAVAX / AVAX / USD |


#### MAI ([0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b](https://snowscan.xyz/address/0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x5D1F504211c17365CA66353442a74D4435A8b778](https://snowscan.xyz/address/0x5D1F504211c17365CA66353442a74D4435A8b778) | [0xCcC55Db26B78a19Dba1beE0066F9c1665575439A](https://snowscan.xyz/address/0xCcC55Db26B78a19Dba1beE0066F9c1665575439A) |
| oracleDescription | MIMATIC / USD | Capped MAI/USD |


#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowscan.xyz/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a](https://snowscan.xyz/address/0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a) | [0x39185f2236A6022b682e8BB93C040d125DA093CF](https://snowscan.xyz/address/0x39185f2236A6022b682e8BB93C040d125DA093CF) |
| oracleDescription | USDT / USD | Capped USDt/USD |


#### USDC ([0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowscan.xyz/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF096872672F44d6EBA71458D74fe67F9a77a23B9](https://snowscan.xyz/address/0xF096872672F44d6EBA71458D74fe67F9a77a23B9) | [0xD8277249e871BE9A402fa286C2C5ec16046dC512](https://snowscan.xyz/address/0xD8277249e871BE9A402fa286C2C5ec16046dC512) |
| oracleDescription | USDC / USD | Capped USDC/USD |


#### FRAX ([0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowscan.xyz/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xbBa56eF1565354217a3353a466edB82E8F25b08e](https://snowscan.xyz/address/0xbBa56eF1565354217a3353a466edB82E8F25b08e) | [0x6208576378D06ce69A27987b7A524A9B15d499a4](https://snowscan.xyz/address/0x6208576378D06ce69A27987b7A524A9B15d499a4) |
| oracleDescription | FRAX / USD | Capped FRAX/USD |


#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x51D7180edA2260cc4F6e4EebB82FEF5c3c2B8300](https://snowscan.xyz/address/0x51D7180edA2260cc4F6e4EebB82FEF5c3c2B8300) | [0xf82da795727633aFA9BB0f1B08A87c0F6A38723f](https://snowscan.xyz/address/0xf82da795727633aFA9BB0f1B08A87c0F6A38723f) |
| oracleDescription | DAI / USD | Capped DAI.e/USD |


## Raw diff

```json
{
  "reserves": {
    "0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE": {
      "oracle": {
        "from": "0xc9245871D69BF4c36c6F2D15E0D68Ffa883FE1A7",
        "to": "0xB2B332f27e4B7305649a228C31Ed9858c5a6bAD9"
      },
      "oracleDecimals": {
        "from": null,
        "to": 8
      },
      "oracleDescription": {
        "from": null,
        "to": "Capped sAVAX / AVAX / USD"
      }
    },
    "0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b": {
      "oracle": {
        "from": "0x5D1F504211c17365CA66353442a74D4435A8b778",
        "to": "0xCcC55Db26B78a19Dba1beE0066F9c1665575439A"
      },
      "oracleDescription": {
        "from": "MIMATIC / USD",
        "to": "Capped MAI/USD"
      }
    },
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "oracle": {
        "from": "0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a",
        "to": "0x39185f2236A6022b682e8BB93C040d125DA093CF"
      },
      "oracleDescription": {
        "from": "USDT / USD",
        "to": "Capped USDt/USD"
      }
    },
    "0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E": {
      "oracle": {
        "from": "0xF096872672F44d6EBA71458D74fe67F9a77a23B9",
        "to": "0xD8277249e871BE9A402fa286C2C5ec16046dC512"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    },
    "0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64": {
      "oracle": {
        "from": "0xbBa56eF1565354217a3353a466edB82E8F25b08e",
        "to": "0x6208576378D06ce69A27987b7A524A9B15d499a4"
      },
      "oracleDescription": {
        "from": "FRAX / USD",
        "to": "Capped FRAX/USD"
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "oracle": {
        "from": "0x51D7180edA2260cc4F6e4EebB82FEF5c3c2B8300",
        "to": "0xf82da795727633aFA9BB0f1B08A87c0F6A38723f"
      },
      "oracleDescription": {
        "from": "DAI / USD",
        "to": "Capped DAI.e/USD"
      }
    }
  }
}
```