## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 1 wstETH | 180,000 wstETH |


## Event logs

#### 0x64b761D848206f447Fe2dd461b0c635Ec39EbB27 (AaveV3Ethereum.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | BorrowCapChanged(asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0 (symbol: wstETH), oldBorrowCap: 1, newBorrowCap: 180000) |

#### 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A (AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1773657575, withDelegatecall: true, resultData: 0x) |

#### 0xdAbad81aF85554E9ae636395611C58F7eC1aAEc5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 414) |

## Raw storage changes

### 0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2 (AaveV3Ethereum.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2 | 0x100000000000000000000103e80001adb000000000010dac811229681fa41eaa | 0x100000000000000000000103e80001adb0000002bf200dac811229681fa41eaa |

### 0xdabad81af85554e9ae636395611c58f7ec1aaec5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xeca4505ea32ae1a4ee824c5255e38a00422c023b789b59b6ce92c6731bc69891 | 0x0069b7dde6000000000002000000000000000000000000000000000000000000 | 0x0069b7dde6000000000003000000000000000000000000000000000000000000 |
| 0xeca4505ea32ae1a4ee824c5255e38a00422c023b789b59b6ce92c6731bc69892 | 0x000000000000000000093a8000000000000069e6026700000000000000000000 | 0x000000000000000000093a8000000000000069e6026700000000000069b7dde7 |


## Raw diff

```json
{
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowCap": {
        "from": 1,
        "to": 180000
      }
    }
  }
}
```
