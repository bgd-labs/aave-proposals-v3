## Reserve changes

### Reserves altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 48,000,000 PYUSD | 15,000,000 PYUSD |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % [0] | 75 % [7500] |
| liquidationThreshold | 0 % [0] | 78 % [7800] |
| liquidationBonus | 0 % | 7.5 % |
| liquidationProtocolFee | 0 % [0] | 10 % [1000] |


## Raw diff

```json
{
  "reserves": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "borrowCap": {
        "from": 48000000,
        "to": 15000000
      },
      "liquidationBonus": {
        "from": 0,
        "to": 10750
      },
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 7800
      },
      "ltv": {
        "from": 0,
        "to": 7500
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  }
}
```