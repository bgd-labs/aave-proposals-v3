## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 84 % [8400] |


## Event logs

#### 0x342631c6CeFC9cfbf97b2fe4aa242a236e1fd517 (AaveV3EthereumLido.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | topics: `0x6a3fa1f355f7c7ab43e41cb277d1f8471f2693c63dca91049d5ec127bb588e10`, `0x000000000000000000000000c02aaa39b223fe8d0a0e5c4f27ead9083c756cc2`, data: `0x0000000000000000000000000000000000000000000000000000000000000000` |
| 1 | CollateralConfigurationChanged(asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 (symbol: WETH), ltv: 8400, liquidationThreshold: 8500, liquidationBonus: 10500) |

#### 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A (AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1778488523, withDelegatecall: true, resultData: 0x) |

#### 0xdAbad81aF85554E9ae636395611C58F7eC1aAEc5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 3 | PayloadExecuted(payloadId: 437) |

## Raw storage changes

### 0x342631c6cefc9cfbf97b2fe4aa242a236e1fd517 (AaveV3EthereumLido.POOL_CONFIGURATOR)

| slot | previous value | new value |
| --- | --- | --- |
| 0x459c0b9f63eabebc83331170f4affb8716ea56d7c237fceb15b998360ce31b84 | 0x00000000000000000000000000000000000000000000000000000000000020d0 | 0x0000000000000000000000000000000000000000000000000000000000000000 |

### 0x4e033931ad43597d96d6bcc25c280717730b58b1 (AaveV3EthereumLido.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ebf | 0x100000000000000000000103e800000ea6000000d2f005dc8512290421340000 | 0x100000000000000000000103e800000ea6000000d2f005dc85122904213420d0 |

### 0xdabad81af85554e9ae636395611c58f7ec1aaec5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x80c5e3b8ac23d18b9c1ca010bc8409224dee1ed85306151c47f57e65cb73932f | 0x006a0194ca000000000002000000000000000000000000000000000000000000 | 0x006a0194ca000000000003000000000000000000000000000000000000000000 |
| 0x80c5e3b8ac23d18b9c1ca010bc8409224dee1ed85306151c47f57e65cb739330 | 0x000000000000000000093a800000000000006a2fb94b00000000000000000000 | 0x000000000000000000093a800000000000006a2fb94b0000000000006a0194cb |


## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "ltv": {
        "from": 0,
        "to": 8400
      }
    }
  }
}
```
