## Reserve changes

### Reserves altered

#### ZK ([0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E](https://era.zksync.network//address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E))

| description | value before | value after |
| --- | --- | --- |
| ltv | 40 % [4000] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E": {
      "ltv": {
        "from": 4000,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2e79349c3f5e4751e87b966812c9e65e805996f1": {
      "label": "GovernanceV3ZkSync.PAYLOADS_CONTROLLER",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xbb7ea1d025e27e153f156855239b4b128e9da3a64a6f0a0270f8920989588142": {
          "previousValue": "0x0068fa7419000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068fa7419000000000003000000000000000000000000000000000000000000"
        },
        "0xbb7ea1d025e27e153f156855239b4b128e9da3a64a6f0a0270f8920989588143": {
          "previousValue": "0x000000000000000000093a800000000000006928989a00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006928989a00000000000068fa741a"
        }
      }
    },
    "0x78e30497a3c7527d953c6b1e3541b021a98ac43c": {
      "label": "AaveV3ZkSync.POOL",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xaab9473d3c2d823ad831e02d9c613808f1256c8d227ca0ebdfd0d67e251a0560": {
          "previousValue": "0x10003d090000000000000007d000773594000098968007d085122af811940fa0",
          "newValue": "0x10003d090000000000000007d000773594000098968007d085122af811940000"
        }
      }
    }
  }
}
```