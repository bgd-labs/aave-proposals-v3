## Hub Spoke Config Changes

### USDC (assetId: 2) on Hub [0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e](https://snowscan.xyz/address/0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e) / Spoke [0x6a37776B5E026dBdF043b4F933c323C84DD1B514](https://snowscan.xyz/address/0x6a37776B5E026dBdF043b4F933c323C84DD1B514)

| description | value before | value after |
| --- | --- | --- |
| addCap | 200,000 (2e5) USDC | 400,000 (4e5) USDC |
| drawCap | 150,000 (1.5e5) USDC | 350,000 (3.5e5) USDC |

### USDt (assetId: 3) on Hub [0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e](https://snowscan.xyz/address/0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e) / Spoke [0x6a37776B5E026dBdF043b4F933c323C84DD1B514](https://snowscan.xyz/address/0x6a37776B5E026dBdF043b4F933c323C84DD1B514)

| description | value before | value after |
| --- | --- | --- |
| addCap | 200,000 (2e5) USDt | 400,000 (4e5) USDt |
| drawCap | 150,000 (1.5e5) USDt | 350,000 (3.5e5) USDt |

## Event logs

#### 0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e (AaveV4Avalanche.ALL_HUBS[0], AaveV4Avalanche.HUBS.CORE_HUB)

| index | event |
| --- | --- |
| 0 | UpdateSpokeConfig(assetId: 2, spoke: 0x6a37776B5E026dBdF043b4F933c323C84DD1B514, config: {addCap: 400000, drawCap: 350000, riskPremiumThreshold: 0, active: true, halted: false}) |
| 1 | UpdateSpokeConfig(assetId: 3, spoke: 0x6a37776B5E026dBdF043b4F933c323C84DD1B514, config: {addCap: 400000, drawCap: 350000, riskPremiumThreshold: 0, active: true, halted: false}) |

#### 0xb619fA61e795D47f517702e63ce50292370561F1

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1784807075, withDelegatecall: true, resultData: 0x) |

## Raw storage changes

### 0xd07369fae4a5bb13c9ce446b052c7867b1abdf6e (AaveV4Avalanche.ALL_HUBS[0], AaveV4Avalanche.HUBS.CORE_HUB)

| slot | previous value | new value |
| --- | --- | --- |
| 0x91cc139c3ecf77fff04c15491bcef0b4b96d035fe67e78778222cc1c13cf88ff | 0x0000000100000000000249f00000030d400000000000000000000027e2b4b239 | 0x0000000100000000000557300000061a800000000000000000000027e2b4b239 |
| 0xb6910ad7f9cb00bfac48ebaffad7429821f847eb31ea6142257707b03d7c6fdc | 0x0000000100000000000249f00000030d400000000000000000000027c8951796 | 0x0000000100000000000557300000061a800000000000000000000027c8951796 |


## Raw diff

```json
{
  "spokeConfigs": {
    "0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e_2_0x6a37776B5E026dBdF043b4F933c323C84DD1B514": {
      "addCap": {
        "from": 200000,
        "to": 400000
      },
      "drawCap": {
        "from": 150000,
        "to": 350000
      }
    },
    "0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e_3_0x6a37776B5E026dBdF043b4F933c323C84DD1B514": {
      "addCap": {
        "from": 200000,
        "to": 400000
      },
      "drawCap": {
        "from": 150000,
        "to": 350000
      }
    }
  }
}
```
