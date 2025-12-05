## Reserve changes

### Reserves altered

#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowscan.xyz/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "ltv": {
        "from": 6300,
        "to": 0
      }
    }
  },
  "raw": {
    "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
      "label": "GovernanceV3Avalanche.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xeaaacae94bbfc90c56bc9f09c078e38d09be79409287043ed56adc78213c2109": {
          "previousValue": "0x0069304353000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069304353000000000003000000000000000000000000000000000000000000"
        },
        "0xeaaacae94bbfc90c56bc9f09c078e38d09be79409287043ed56adc78213c210a": {
          "previousValue": "0x000000000000000000093a80000000000000695e67d400000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e67d400000000000069304354"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Avalanche.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x60f052c199edb853f9f894e8035b98f47b048cadb5366aed2ada8a753f3ec0db": {
          "previousValue": "0x100000000000000000000103e8000931458000659fa009c4a51229041e14189c",
          "newValue": "0x100000000000000000000103e8000931458000659fa009c4a51229041e140000"
        }
      }
    }
  }
}
```