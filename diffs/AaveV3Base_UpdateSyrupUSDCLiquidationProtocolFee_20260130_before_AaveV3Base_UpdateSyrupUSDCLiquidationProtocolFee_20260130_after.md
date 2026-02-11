## Reserve changes

### Reserves altered

#### syrupUSDC ([0x660975730059246A68521a3e2FBD4740173100f5](https://basescan.org/address/0x660975730059246A68521a3e2FBD4740173100f5))

| description | value before | value after |
| --- | --- | --- |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |


## Raw diff

```json
{
  "reserves": {
    "0x660975730059246A68521a3e2FBD4740173100f5": {
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66047": {
          "previousValue": "0x00697cf3b0000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00697cf3b0000000000003000000000000000000000000000000000000000000"
        },
        "0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66048": {
          "previousValue": "0x000000000000000000093a8000000000000069ab183100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069ab1831000000000000697cf3b1"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec00": {
          "previousValue": "0x10000000000000000000000000005f5e10000000000113888106000000000000",
          "newValue": "0x100000000000000000000003e8005f5e10000000000113888106000000000000"
        }
      }
    }
  }
}
```