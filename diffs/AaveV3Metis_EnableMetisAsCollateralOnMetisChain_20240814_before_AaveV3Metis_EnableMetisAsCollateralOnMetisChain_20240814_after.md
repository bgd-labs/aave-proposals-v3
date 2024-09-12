## Reserve changes

### Reserves altered

#### Metis ([0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000](https://explorer.metis.io/address/0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 0 $ [0] | 1,000,000 $ [100000000] |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % [0] | 30 % [3000] |
| liquidationThreshold | 0 % [0] | 40 % [4000] |
| liquidationBonus | 0 % | 10 % |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |


## Raw diff

```json
{
  "reserves": {
    "0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000": {
      "debtCeiling": {
        "from": 0,
        "to": 100000000
      },
      "liquidationBonus": {
        "from": 0,
        "to": 11000
      },
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 4000
      },
      "ltv": {
        "from": 0,
        "to": 3000
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  }
}
```