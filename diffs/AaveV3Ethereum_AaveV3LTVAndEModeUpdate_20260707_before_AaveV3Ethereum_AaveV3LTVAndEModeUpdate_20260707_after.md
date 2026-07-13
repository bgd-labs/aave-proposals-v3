## Reserve changes

### Reserves altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 1 wstETH | 7,000 wstETH |


## Event logs

#### 0x64b761D848206f447Fe2dd461b0c635Ec39EbB27 (AaveV3Ethereum.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | CollateralConfigurationChanged(asset: 0x6c3ea9036406852006290770BEdFcAbA0e23A0e8 (symbol: PYUSD), ltv: 0, liquidationThreshold: 7800, liquidationBonus: 10750) |
| 1 | BorrowCapChanged(asset: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0 (symbol: wstETH), oldBorrowCap: 1, newBorrowCap: 7000) |

#### 0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A (AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1)

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1783958435, withDelegatecall: true, resultData: 0x) |

#### 0xdAbad81aF85554E9ae636395611C58F7eC1aAEc5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 3 | PayloadExecuted(payloadId: 457) |

## Raw storage changes

### 0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2 (AaveV3Ethereum.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x5d0932b3bfc1052ccb8f073298333897b875f4c2d9eba20cdc99f93ff1bc1875 | 0x100000000000000000000003e8001406f4000112a88003e8850629fe1e781d4c | 0x100000000000000000000003e8001406f4000112a88003e8850629fe1e780000 |
| 0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2 | 0x100000000000000000000103e80000f42400000000010dac811229681fa41eaa | 0x100000000000000000000103e80000f4240000001b580dac811229681fa41eaa |

### 0xdabad81af85554e9ae636395611c58f7ec1aaec5 (GovernanceV3Ethereum.PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0xe7b26963c6a46bc669ee69f5ec3ddaa2b4dba8fb6c66bbf247f3096d559f5641 | 0x006a550ba2000000000002000000000000000000000000000000000000000000 | 0x006a550ba2000000000003000000000000000000000000000000000000000000 |
| 0xe7b26963c6a46bc669ee69f5ec3ddaa2b4dba8fb6c66bbf247f3096d559f5642 | 0x000000000000000000093a800000000000006a83302300000000000000000000 | 0x000000000000000000093a800000000000006a8330230000000000006a550ba3 |


## Raw diff

```json
{
  "reserves": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowCap": {
        "from": 1,
        "to": 7000
      }
    }
  }
}
```
