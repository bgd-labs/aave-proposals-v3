## Reserve changes

### Reserves altered

#### syrupUSDC ([0x660975730059246A68521a3e2FBD4740173100f5](https://basescan.org/address/0x660975730059246A68521a3e2FBD4740173100f5))

| description | value before | value after |
| --- | --- | --- |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |


## Event logs

#### 0x5731a04B1E775f0fdd454Bf70f3335886e9A96be (AaveV3Base.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | LiquidationProtocolFeeChanged(asset: 0x660975730059246A68521a3e2FBD4740173100f5 (symbol: syrupUSDC), oldFee: 0, newFee: 1000) |

#### 0x9390B1735def18560c509E2d0bc090E9d6BA257a (AaveV3Base.ACL_ADMIN, GovernanceV3Base.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1769796529, withDelegatecall: true, resultData: 0x) |

#### 0x2DC219E716793fb4b21548C0f009Ba3Af753ab01 (GovernanceV3Base.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 97) |

## Raw storage changes

### 0x2dc219e716793fb4b21548c0f009ba3af753ab01 (GovernanceV3Base.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66047 | 0x00697cf3b0000000000002000000000000000000000000000000000000000000 | 0x00697cf3b0000000000003000000000000000000000000000000000000000000 |
| 0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66048 | 0x000000000000000000093a8000000000000069ab183100000000000000000000 | 0x000000000000000000093a8000000000000069ab1831000000000000697cf3b1 |

### 0xa238dd80c259a72e81d7e4664a9801593f98d1c5 (AaveV3Base.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x0449a188c6a1a04af87a897fe6d004e52c67ed9ab7a46950047a4f26f310ec00 | 0x10000000000000000000000000005f5e10000000000113888106000000000000 | 0x100000000000000000000003e8005f5e10000000000113888106000000000000 |


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
  }
}
```
