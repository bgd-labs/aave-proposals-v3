## Reserve changes

### Reserves altered

#### wstETH ([0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6](https://gnosisscan.io/address/0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


## Event logs

#### 0x7304979ec9E4EaA0273b6A037a31c4e9e5A75D16 (AaveV3Gnosis.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | CollateralConfigurationChanged(asset: 0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6 (symbol: wstETH), ltv: 0, liquidationThreshold: 7900, liquidationBonus: 10600) |

#### 0x1dF462e2712496373A347f8ad10802a5E95f053D (AaveV3Gnosis.ACL_ADMIN, GovernanceV3Gnosis.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1783958440, withDelegatecall: true, resultData: 0x) |

#### 0x9A1F491B86D09fC1484b5fab10041B189B60756b (GovernanceV3Gnosis.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 80) |

## Raw storage changes

### 0x9a1f491b86d09fc1484b5fab10041b189b60756b (GovernanceV3Gnosis.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xe7defe1a9ee2663e7f593684ebe15b56452e1fa833a7efa12070ad6443b10819 | 0x006a550ba7000000000002000000000000000000000000000000000000000000 | 0x006a550ba7000000000003000000000000000000000000000000000000000000 |
| 0xe7defe1a9ee2663e7f593684ebe15b56452e1fa833a7efa12070ad6443b1081a | 0x000000000000000000093a800000000000006a83302800000000000000000000 | 0x000000000000000000093a800000000000006a8330280000000000006a550ba8 |

### 0xb50201558b00496a145fe76f7424749556e326d8 (AaveV3Gnosis.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xee00b8c53ccd9d92afea2ade430b34dbda7a33b87f08ad29d280d4683a389d07 | 0x100000000000000000000103e80000032c800000009601f4811229681edc1d4c | 0x100000000000000000000103e80000032c800000009601f4811229681edc0000 |


## Raw diff

```json
{
  "reserves": {
    "0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    }
  }
}
```
