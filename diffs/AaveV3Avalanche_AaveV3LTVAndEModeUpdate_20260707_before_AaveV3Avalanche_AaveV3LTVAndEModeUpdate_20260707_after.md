## Reserve changes

### Reserves altered

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowscan.xyz/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value before | value after |
| --- | --- | --- |
| ltv | 69 % [6900] | 0 % [0] |


## Event logs

#### 0x8145eddDf43f50276641b55bd3AD95944510021E (AaveV3Avalanche.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | CollateralConfigurationChanged(asset: 0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a (symbol: AUSD), ltv: 0, liquidationThreshold: 7200, liquidationBonus: 10600) |

#### 0x3C06dce358add17aAf230f2234bCCC4afd50d090 (AaveV2Avalanche.POOL_ADMIN, AaveV3Avalanche.ACL_ADMIN, GovernanceV3Avalanche.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1783452309, withDelegatecall: true, resultData: 0x) |

#### 0x1140CB7CAfAcC745771C2Ea31e7B5C653c5d0B80 (GovernanceV3Avalanche.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 118) |

## Raw storage changes

### 0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80 (GovernanceV3Avalanche.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xbaba906220955b09fec23b575e20afa7d08161b8520bb9d5ec850371b93edf98 | 0x006a4d5294000000000002000000000000000000000000000000000000000000 | 0x006a4d5294000000000003000000000000000000000000000000000000000000 |
| 0xbaba906220955b09fec23b575e20afa7d08161b8520bb9d5ec850371b93edf99 | 0x000000000000000000093a800000000000006a7b771500000000000000000000 | 0x000000000000000000093a800000000000006a7b77150000000000006a4d5295 |

### 0x794a61358d6845594f94dc1db02a252b5b4814ad (AaveV3Avalanche.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xe9e70c2e013e87e2e0cf393188509aa8bfb10967c8d1e3359f7dda7eb1648e4f | 0x100000000000000000000003e80000f42400000dbba003e8850629681c201af4 | 0x100000000000000000000003e80000f42400000dbba003e8850629681c200000 |


## Raw diff

```json
{
  "reserves": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "ltv": {
        "from": 6900,
        "to": 0
      }
    }
  }
}
```
