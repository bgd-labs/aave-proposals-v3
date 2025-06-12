## Reserve changes

### Reserves altered

#### USDC ([0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4](https://scrollscan.com/address/0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee](https://scrollscan.com/address/0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee) | [0x1685D81212580DD4cDA287616C2f6F4794927e18](https://scrollscan.com/address/0x1685D81212580DD4cDA287616C2f6F4794927e18) |


## Raw diff

```json
{
  "reserves": {
    "0x06eFdBFf2a14a7c8E15944D1F4A48F9F95F663A4": {
      "oracle": {
        "from": "0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee",
        "to": "0x1685D81212580DD4cDA287616C2f6F4794927e18"
      }
    }
  },
  "raw": {
    "0x04421d8c506e2fa2371a08efaabf791f624054f3": {
      "label": "AaveV3Scroll.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0xd070814d1411eddff677039c37c2413a15e681c88846606935bc880f4979bdd5": {
          "previousValue": "0x000000000000000000000000427fd98dbd1dbc2d4e792350cabe7c9665f35bee",
          "newValue": "0x0000000000000000000000001685d81212580dd4cda287616c2f6f4794927e18"
        }
      }
    },
    "0x6b6b41c0f8c223715f712be83cec3c37bbfdc3fe": {
      "label": "GovernanceV3Scroll.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xa6d60d4ff1c38ae572157a43d1b8579039e4b4cc96e22c75c07379751785fe51": {
          "previousValue": "0x0068246dd9000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068246dd9000000000003000000000000000000000000000000000000000000"
        },
        "0xa6d60d4ff1c38ae572157a43d1b8579039e4b4cc96e22c75c07379751785fe52": {
          "previousValue": "0x000000000000000000093a800000000000006852925a00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006852925a00000000000068246dda"
        }
      }
    }
  }
}
```