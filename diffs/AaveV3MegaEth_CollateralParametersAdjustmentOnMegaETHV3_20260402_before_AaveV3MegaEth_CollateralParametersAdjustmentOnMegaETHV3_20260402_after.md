## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://mega.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | :x: | :white_check_mark: |
| ltv | 0 % [0] | 78 % [7800] |
| liquidationThreshold | 0 % [0] | 81 % [8100] |
| liquidationBonus | 0 % | 5.5 % [10550] |


#### wstETH ([0x601aC63637933D88285A025C685AC4e9a92a98dA](https://mega.etherscan.io/address/0x601aC63637933D88285A025C685AC4e9a92a98dA))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | :x: | :white_check_mark: |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 0 % [0] | 79 % [7900] |
| liquidationBonus | 0 % | 6.5 % [10650] |


#### BTC.b ([0xB0F70C0bD6FD87dbEb7C10dC692a2a6106817072](https://mega.etherscan.io/address/0xB0F70C0bD6FD87dbEb7C10dC692a2a6106817072))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | :x: | :white_check_mark: |
| ltv | 0 % [0] | 68 % [6800] |
| liquidationThreshold | 0 % [0] | 73 % [7300] |
| liquidationBonus | 0 % | 6.5 % [10650] |


## EMode changes

### EMode: wstETH Stablecoins (id: 3)

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 78.5 % |
| liquidationThreshold | 79 % | 81 % |


## Event logs

#### 0xF15D31Bc839A853C9068686043cEc6EC5995DAbB (AaveV3MegaEth.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | EModeCategoryAdded(categoryId: 3, ltv: 7850, liquidationThreshold: 8100, liquidationBonus: 10650, oracle: 0x0000000000000000000000000000000000000000, label: wstETH Stablecoins) |
| 1 | CollateralConfigurationChanged(asset: 0x4200000000000000000000000000000000000006 (symbol: WETH), ltv: 7800, liquidationThreshold: 8100, liquidationBonus: 10550) |
| 2 | CollateralConfigurationChanged(asset: 0xB0F70C0bD6FD87dbEb7C10dC692a2a6106817072 (symbol: BTC.b), ltv: 6800, liquidationThreshold: 7300, liquidationBonus: 10650) |
| 3 | CollateralConfigurationChanged(asset: 0x601aC63637933D88285A025C685AC4e9a92a98dA (symbol: wstETH), ltv: 7500, liquidationThreshold: 7900, liquidationBonus: 10650) |

#### 0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19 (AaveV3MegaEth.ACL_ADMIN, GovernanceV3MegaEth.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 4 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1775145436, withDelegatecall: true, resultData: 0x) |

#### 0x80e11cB895a23C901a990239E5534054C66476B5 (GovernanceV3MegaEth.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 5 | PayloadExecuted(payloadId: 2) |

## Raw storage changes

### 0x7e324abc5de01d112afc03a584966ff199741c28 (AaveV3MegaEth.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x4853baaf8dbe8a1046261c0b8387595b5dac8597867ac12c5138507a4775d92c | 0x100000000000000000000003e8000002ee000000000107d08112000000000000 | 0x100000000000000000000003e8000002ee000000000107d08112299a1edc1d4c |
| 0x7a18f972cb3c30997624be86bf2fd31e3cd44e3df901d4f88e0579aa778bb37b | 0x100000000000000000000003e800000007800000000107d08108000000000000 | 0x100000000000000000000003e800000007800000000107d08108299a1c841a90 |
| 0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155 | 0x0000000000000000000000000000000000000000000000000010299a1edc1d4c | 0x0000000000000000000000000000000000000000000000000010299a1fa41eaa |
| 0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156 | 0x77737445544820537461626c65636f696e730000000000000000000000000024 | 0x77737445544820537461626c65636f696e730000000000000000000000000024 |
| 0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade | 0x100000000000000000000003e800000c35000000b3b005dc8112000000000000 | 0x100000000000000000000003e800000c35000000b3b005dc811229361fa41e78 |

### 0x80e11cb895a23c901a990239e5534054c66476b5 (GovernanceV3MegaEth.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xc3a24b0501bd2c13a7e57f2db4369ec4c223447539fc0724a9d55ac4a06ebd4d | 0x0069ce91db000000000002000000000000000000000000000000000000000000 | 0x0069ce91db000000000003000000000000000000000000000000000000000000 |
| 0xc3a24b0501bd2c13a7e57f2db4369ec4c223447539fc0724a9d55ac4a06ebd4e | 0x000000000000000000093a8000000000000069fcb65c00000000000000000000 | 0x000000000000000000093a8000000000000069fcb65c00000000000069ce91dc |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 8100
      },
      "ltv": {
        "from": 7500,
        "to": 7850
      }
    }
  },
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "liquidationBonus": {
        "from": 0,
        "to": 10550
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 8100
      },
      "ltv": {
        "from": 0,
        "to": 7800
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    },
    "0x601aC63637933D88285A025C685AC4e9a92a98dA": {
      "liquidationBonus": {
        "from": 0,
        "to": 10650
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 7900
      },
      "ltv": {
        "from": 0,
        "to": 7500
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    },
    "0xB0F70C0bD6FD87dbEb7C10dC692a2a6106817072": {
      "liquidationBonus": {
        "from": 0,
        "to": 10650
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 7300
      },
      "ltv": {
        "from": 0,
        "to": 6800
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  }
}
```
