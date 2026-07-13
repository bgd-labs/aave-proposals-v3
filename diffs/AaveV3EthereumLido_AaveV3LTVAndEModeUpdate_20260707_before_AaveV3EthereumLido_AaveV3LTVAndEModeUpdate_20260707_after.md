## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 1 wstETH | 18,000 wstETH |


## Event logs

#### 0x342631c6CeFC9cfbf97b2fe4aa242a236e1fd517 (AaveV3EthereumLido.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | BorrowCapChanged(asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0 (symbol: wstETH), oldBorrowCap: 1, newBorrowCap: 18000) |

#### 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A (AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1783958435, withDelegatecall: true, resultData: 0x) |

#### 0xdAbad81aF85554E9ae636395611C58F7eC1aAEc5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 457) |

## Raw storage changes

### 0x4e033931ad43597d96d6bcc25c280717730b58b1 (AaveV3EthereumLido.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2 | 0x100000000000000000000103e800000f23000000000101f481122968206c2008 | 0x100000000000000000000103e800000f23000000465001f481122968206c2008 |

### 0xdabad81af85554e9ae636395611c58f7ec1aaec5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xe7b26963c6a46bc669ee69f5ec3ddaa2b4dba8fb6c66bbf247f3096d559f5641 | 0x006a550ba2000000000002000000000000000000000000000000000000000000 | 0x006a550ba2000000000003000000000000000000000000000000000000000000 |
| 0xe7b26963c6a46bc669ee69f5ec3ddaa2b4dba8fb6c66bbf247f3096d559f5642 | 0x000000000000000000093a800000000000006a83302300000000000000000000 | 0x000000000000000000093a800000000000006a8330230000000000006a550ba3 |


## Raw diff

```json
{
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowCap": {
        "from": 1,
        "to": 18000
      }
    }
  }
}
```
