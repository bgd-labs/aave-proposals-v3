## Reserve changes

### Reserves altered

#### WETH ([0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f](https://lineascan.build/address/0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 80 % [8000] |


## Event logs

#### 0x812E7c19421D9f41A6DDCF047d5cc2dE2Ca5Bfa2 (AaveV3Linea.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | topics: `0x6a3fa1f355f7c7ab43e41cb277d1f8471f2693c63dca91049d5ec127bb588e10`, `0x000000000000000000000000e5d7c2a44ffddf6b295a15c148167daaaf5cf34f`, data: `0x0000000000000000000000000000000000000000000000000000000000000000` |
| 1 | CollateralConfigurationChanged(asset: 0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f (symbol: WETH), ltv: 8000, liquidationThreshold: 8300, liquidationBonus: 10600) |

#### 0x8c2d95FE7aeB57b86961F3abB296A54f0ADb7F88 (AaveV3Linea.ACL_ADMIN, GovernanceV3Linea.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1778488518, withDelegatecall: true, resultData: 0x) |

#### 0x3BcE23a1363728091bc57A58a226CF2940C2e074 (GovernanceV3Linea.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 3 | PayloadExecuted(payloadId: 27) |

## Raw storage changes

### 0x3bce23a1363728091bc57a58a226cf2940c2e074 (GovernanceV3Linea.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x925be0b447003e4366d6addf976a9e5448b14e56ca3733fe4a9ca6f86b0dcbd5 | 0x006a0194c5000000000002000000000000000000000000000000000000000000 | 0x006a0194c5000000000003000000000000000000000000000000000000000000 |
| 0x925be0b447003e4366d6addf976a9e5448b14e56ca3733fe4a9ca6f86b0dcbd6 | 0x000000000000000000093a800000000000006a2fb94600000000000000000000 | 0x000000000000000000093a800000000000006a2fb9460000000000006a0194c6 |

### 0x812e7c19421d9f41a6ddcf047d5cc2de2ca5bfa2 (AaveV3Linea.POOL_CONFIGURATOR)

| slot | previous value | new value |
| --- | --- | --- |
| 0xc44967ae571c589398af538c99294c71a237f9e29faa40fc9005449efedb646f | 0x0000000000000000000000000000000000000000000000000000000000001f40 | 0x0000000000000000000000000000000000000000000000000000000000000000 |

### 0xc47b8c00b0f69a36fa203ffeac0334874574a8ac (AaveV3Linea.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x1fd84a755d3a9c78ff8b3bd554246082782d06efd21cdf78c58b0ad75e892b9e | 0x100000000000000000000003e8000009c40000008ca005dc85122968206c0000 | 0x100000000000000000000003e8000009c40000008ca005dc85122968206c1f40 |


## Raw diff

```json
{
  "reserves": {
    "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f": {
      "ltv": {
        "from": 0,
        "to": 8000
      }
    }
  }
}
```
