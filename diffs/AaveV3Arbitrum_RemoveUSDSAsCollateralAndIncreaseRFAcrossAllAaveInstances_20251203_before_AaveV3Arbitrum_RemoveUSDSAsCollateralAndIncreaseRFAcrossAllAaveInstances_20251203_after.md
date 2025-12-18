## Reserve changes

### Reserves altered

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://arbiscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "ltv": {
        "from": 6300,
        "to": 0
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479a": {
          "previousValue": "0x100000000000000000000103e8000ee3090000b3e6b009c4a51229041e14189c",
          "newValue": "0x100000000000000000000103e8000ee3090000b3e6b009c4a51229041e140000"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x7b2f1db823434eb2c3257b921622f3b73c33ed78ab6344072b7d0d89829cce01": {
          "previousValue": "0x00693043a6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693043a6000000000003000000000000000000000000000000000000000000"
        },
        "0x7b2f1db823434eb2c3257b921622f3b73c33ed78ab6344072b7d0d89829cce02": {
          "previousValue": "0x000000000000000000093a80000000000000695e682700000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e6827000000000000693043a7"
        }
      }
    }
  }
}
```