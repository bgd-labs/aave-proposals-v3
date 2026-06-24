## Reserve changes

### Reserves altered

#### mGLOBAL ([0x7433806912Eae67919e66aea853d46Fa0aef98A8](https://etherscan.io/address/0x7433806912Eae67919e66aea853d46Fa0aef98A8))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193](https://etherscan.io/address/0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193) | [0xe034De753a3d855B6daD1A4984de75a5c443E939](https://etherscan.io/address/0xe034De753a3d855B6daD1A4984de75a5c443E939) |
| oracleDescription | mGLOBAL NAV | mGlobal NAV - Aave Llamaguard |


## Raw diff

```json
{
  "reserves": {
    "0x7433806912Eae67919e66aea853d46Fa0aef98A8": {
      "oracle": {
        "from": "0xB92A68763b2F83e094595c7B41a7FB9D0f8Da193",
        "to": "0xe034De753a3d855B6daD1A4984de75a5c443E939"
      },
      "oracleDescription": {
        "from": "mGLOBAL NAV",
        "to": "mGlobal NAV - Aave Llamaguard"
      }
    }
  },
  "raw": {
    "0x13b57382c36bab566e75c72303622af29e27e1d3": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000005": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000000b",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000000c"
        }
      }
    },
    "0x985bcfab7e0f4ef2606cc5b64fc1a16311880442": {
      "label": "AaveV3EthereumHorizon.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x447dca2401334c9e987c05155fd1fb39e56fe81ff5ff8981882cb6038ac1adfa": {
          "previousValue": "0x000000000000000000000000b92a68763b2f83e094595c7b41a7fb9d0f8da193",
          "newValue": "0x000000000000000000000000e034de753a3d855b6dad1a4984de75a5c443e939"
        }
      }
    }
  }
}
```