## Reserve changes

### Reserves altered

#### WETH ([0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111](https://mantlescan.xyz//address/0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 80.5 % [8050] |


## Event logs

#### 0x719755fC1ACf2f9079B0Cbc56e23712c09Ab8626 (AaveV3Mantle.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | topics: `0x6a3fa1f355f7c7ab43e41cb277d1f8471f2693c63dca91049d5ec127bb588e10`, `0x000000000000000000000000deaddeaddeaddeaddeaddeaddeaddeaddead1111`, data: `0x0000000000000000000000000000000000000000000000000000000000000000` |
| 1 | CollateralConfigurationChanged(asset: 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111 (symbol: WETH), ltv: 8050, liquidationThreshold: 8300, liquidationBonus: 10550) |

#### 0x70884634D0098782592111A2A6B8d223be31CB7b (AaveV3Mantle.ACL_ADMIN, GovernanceV3Mantle.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1778488528, withDelegatecall: true, resultData: 0x) |

#### 0xF089f77173A3009A98c45f49D547BF714A7B1e01 (GovernanceV3Mantle.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 3 | PayloadExecuted(payloadId: 5) |

## Raw storage changes

### 0x458f293454fe0d67ec0655f3672301301dd51422 (AaveV3Mantle.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xf379616f58ee5fcf8e573e9354f6d2badd416b275e710545bec628b28298f68a | 0x100b2d05e000000000000003e800001388000001211005dc85122936206c0000 | 0x100b2d05e000000000000003e800001388000001211005dc85122936206c1f72 |

### 0x719755fc1acf2f9079b0cbc56e23712c09ab8626 (AaveV3Mantle.POOL_CONFIGURATOR)

| slot | previous value | new value |
| --- | --- | --- |
| 0x45b983c2ce02b43f543974a6e392eeafca7b4175b8cae08ef292dd3859dd23e4 | 0x0000000000000000000000000000000000000000000000000000000000001f72 | 0x0000000000000000000000000000000000000000000000000000000000000000 |

### 0xf089f77173a3009a98c45f49d547bf714a7b1e01 (GovernanceV3Mantle.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x405aad32e1adbac89bb7f176e338b8fc6e994ca210c9bb7bdca249b465942250 | 0x006a0194cf000000000002000000000000000000000000000000000000000000 | 0x006a0194cf000000000003000000000000000000000000000000000000000000 |
| 0x405aad32e1adbac89bb7f176e338b8fc6e994ca210c9bb7bdca249b465942251 | 0x000000000000000000093a800000000000006a2fb95000000000000000000000 | 0x000000000000000000093a800000000000006a2fb9500000000000006a0194d0 |


## Raw diff

```json
{
  "reserves": {
    "0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111": {
      "ltv": {
        "from": 0,
        "to": 8050
      }
    }
  }
}
```
