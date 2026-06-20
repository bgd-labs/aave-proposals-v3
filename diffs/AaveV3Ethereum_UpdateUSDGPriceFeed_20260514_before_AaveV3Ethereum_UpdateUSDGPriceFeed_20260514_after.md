## Reserve changes

### Reserves altered

#### USDG ([0xe343167631d89B6Ffc58B88d6b7fB0228795491D](https://etherscan.io/address/0xe343167631d89B6Ffc58B88d6b7fB0228795491D))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF29b1e3b68Fd59DD0a413811fD5d0AbaE653216d](https://etherscan.io/address/0xF29b1e3b68Fd59DD0a413811fD5d0AbaE653216d) | [0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4](https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4) |
| oracleDescription | Fixed USDG/USD | Capped USDG / USD |
| oracleLatestAnswer | 1 $ | 0.99992 $ |


## Event logs

#### 0x54586bE62E3c3580375aE3723C145253060Ca0C2 (AaveV3Ethereum.ORACLE)

| index | event |
| --- | --- |
| 0 | AssetSourceUpdated(asset: 0xe343167631d89B6Ffc58B88d6b7fB0228795491D (symbol: USDG), source: 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4) |

#### 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A (AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1781886491, withDelegatecall: true, resultData: 0x) |

#### 0xdAbad81aF85554E9ae636395611C58F7eC1aAEc5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 449) |

## Raw storage changes

### 0x54586be62e3c3580375ae3723c145253060ca0c2 (AaveV3Ethereum.ORACLE)

| slot | previous value | new value |
| --- | --- | --- |
| 0x21508b8977913ef2fad21ad8ad40729a198a718db58f3c42aecfa5ba00331466 | 0x000000000000000000000000f29b1e3b68fd59dd0a413811fd5d0abae653216d | 0x00000000000000000000000083d20deedcd4ac1313496c8cbcaad0fa298c0ce4 |

### 0xdabad81af85554e9ae636395611c58f7ec1aaec5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xfbdb07ae6730ca001dd73f75ba925e2759100f81cb56e0d9a4e3a2356640d473 | 0x006a356e1a000000000002000000000000000000000000000000000000000000 | 0x006a356e1a000000000003000000000000000000000000000000000000000000 |
| 0xfbdb07ae6730ca001dd73f75ba925e2759100f81cb56e0d9a4e3a2356640d474 | 0x000000000000000000093a800000000000006a63929b00000000000000000000 | 0x000000000000000000093a800000000000006a63929b0000000000006a356e1b |


## Raw diff

```json
{
  "reserves": {
    "0xe343167631d89B6Ffc58B88d6b7fB0228795491D": {
      "oracle": {
        "from": "0xF29b1e3b68Fd59DD0a413811fD5d0AbaE653216d",
        "to": "0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4"
      },
      "oracleDescription": {
        "from": "Fixed USDG/USD",
        "to": "Capped USDG / USD"
      },
      "oracleLatestAnswer": {
        "from": "100000000",
        "to": "99992000"
      }
    }
  }
}
```
