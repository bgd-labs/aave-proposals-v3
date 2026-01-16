## Reserve changes

### Reserves altered

#### CELO ([0x471EcE3750Da237f93B8E339c536989b8978a438](https://celoscan.io/address/0x471EcE3750Da237f93B8E339c536989b8978a438))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x471EcE3750Da237f93B8E339c536989b8978a438": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x3e59a31363e2ad014dcbc521c4a0d5757d9f3402": {
      "label": "AaveV3Celo.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0xf66b05930311b16f3301fc83092844e762abfd7ebeba455fcce7dcf9b4c90364": {
          "previousValue": "0x10002faf0800000000000003e800089544000000000107d085122af817d4157c",
          "newValue": "0x10002faf0800000000000003e800089544000000000107d081122af817d4157c"
        }
      }
    },
    "0xe48e10834c04e394a04bf22a565d063d40b9fa42": {
      "label": "GovernanceV3Celo.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d53": {
          "previousValue": "0x00696444a3000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00696444a3000000000003000000000000000000000000000000000000000000"
        },
        "0x9dcb9783ba5cd0b54745f65f4f918525e461e91888c334e5342cb380ac558d54": {
          "previousValue": "0x000000000000000000093a800000000000006992692400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069926924000000000000696444a4"
        }
      }
    }
  }
}
```