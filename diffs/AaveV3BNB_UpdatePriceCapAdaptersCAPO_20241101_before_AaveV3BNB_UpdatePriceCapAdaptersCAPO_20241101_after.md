## Reserve changes

### Reserve altered

#### USDT ([0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x0F682319Ed4A240b7a2599A48C965049515D9bC3](https://bscscan.com/address/0x0F682319Ed4A240b7a2599A48C965049515D9bC3) | [0xee845A7A40A090Da256420A293803C35B7F436b6](https://bscscan.com/address/0xee845A7A40A090Da256420A293803C35B7F436b6) |


#### USDC ([0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1](https://bscscan.com/address/0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1) | [0x9102a9553B470dbD0dC74009a870A5886C92902C](https://bscscan.com/address/0x9102a9553B470dbD0dC74009a870A5886C92902C) |


#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x60a117Fa5bAbee4d645884fB11E413Da4F893b6D](https://bscscan.com/address/0x60a117Fa5bAbee4d645884fB11E413Da4F893b6D) | [0x72Cb7a00D439296A6fC3c9face9Eca96bfdEf825](https://bscscan.com/address/0x72Cb7a00D439296A6fC3c9face9Eca96bfdEf825) |


## Raw diff

```json
{
  "reserves": {
    "0x55d398326f99059fF775485246999027B3197955": {
      "oracle": {
        "from": "0x0F682319Ed4A240b7a2599A48C965049515D9bC3",
        "to": "0xee845A7A40A090Da256420A293803C35B7F436b6"
      }
    },
    "0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d": {
      "oracle": {
        "from": "0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1",
        "to": "0x9102a9553B470dbD0dC74009a870A5886C92902C"
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "oracle": {
        "from": "0x60a117Fa5bAbee4d645884fB11E413Da4F893b6D",
        "to": "0x72Cb7a00D439296A6fC3c9face9Eca96bfdEf825"
      }
    }
  },
  "raw": {
    "0x39bc1bfda2130d6bb6dbefd366939b4c7aa7c697": {
      "label": "AaveV3BNB.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x4078230474dd5bdc247bf09d8b5fb987f142ad094173e6813c24e122b1c3d673": {
          "previousValue": "0x00000000000000000000000060a117fa5babee4d645884fb11e413da4f893b6d",
          "newValue": "0x00000000000000000000000072cb7a00d439296a6fc3c9face9eca96bfdef825"
        },
        "0x75a19152562baa2463adfc9e32b10635714b7aec97670f598eb1da6e2a56b10f": {
          "previousValue": "0x0000000000000000000000000f682319ed4a240b7a2599a48c965049515d9bc3",
          "newValue": "0x000000000000000000000000ee845a7a40a090da256420a293803c35b7f436b6"
        },
        "0xd4187960d8e14595954dfc8de3270472baacfaaf992e341d5e2ea3c02ecc7e98": {
          "previousValue": "0x000000000000000000000000afcff74ae956f4c23c27db49659d4a7f350415c1",
          "newValue": "0x0000000000000000000000009102a9553b470dbd0dc74009a870a5886c92902c"
        }
      }
    },
    "0xe5ef2dd06755a97e975f7e282f828224f2c3e627": {
      "label": "GovernanceV3BNB.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x10f3a17841c6d818ccbb16e4596978865bb77ba586b583c9de26b166e55de864": {
          "previousValue": "0x0068246ce0000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068246ce0000000000003000000000000000000000000000000000000000000"
        },
        "0x10f3a17841c6d818ccbb16e4596978865bb77ba586b583c9de26b166e55de865": {
          "previousValue": "0x000000000000000000093a800000000000006852916100000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006852916100000000000068246ce1"
        }
      }
    }
  }
}
```