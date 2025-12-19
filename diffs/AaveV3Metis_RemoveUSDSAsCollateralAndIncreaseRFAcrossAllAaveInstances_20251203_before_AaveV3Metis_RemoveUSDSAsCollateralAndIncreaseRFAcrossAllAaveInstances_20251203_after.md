## Reserve changes

### Reserves altered

#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 1,000,000 m.DAI | 200,000 m.DAI |
| borrowCap | 900,000 m.DAI | 180,000 m.DAI |
| ltv | 63 % [6300] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "borrowCap": {
        "from": 900000,
        "to": 180000
      },
      "ltv": {
        "from": 6300,
        "to": 0
      },
      "supplyCap": {
        "from": 1000000,
        "to": 200000
      }
    }
  },
  "raw": {
    "0x2233f8a66a728fba6e1dc95570b25360d07d5524": {
      "label": "GovernanceV3Metis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x181ec19a0f957384e4ecbe9410e516ad0fe8cc3e53caac5ffc50eb11e64bf488": {
          "previousValue": "0x00693043b0000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693043b0000000000003000000000000000000000000000000000000000000"
        },
        "0x181ec19a0f957384e4ecbe9410e516ad0fe8cc3e53caac5ffc50eb11e64bf489": {
          "previousValue": "0x000000000000000000093a80000000000000695e683100000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e6831000000000000693043b1"
        }
      }
    },
    "0x90df02551bb792286e8d4f13e0e357b4bf1d6a57": {
      "label": "AaveV3Metis.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895ee9": {
          "previousValue": "0x100000000000000000000003e80000f42400000dbba009c4851229041e14189c",
          "newValue": "0x100000000000000000000003e8000030d4000002bf2009c4851229041e140000"
        }
      }
    }
  }
}
```