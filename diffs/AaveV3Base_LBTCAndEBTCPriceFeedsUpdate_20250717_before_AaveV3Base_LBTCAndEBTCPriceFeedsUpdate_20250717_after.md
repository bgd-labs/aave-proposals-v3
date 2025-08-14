## Reserve changes

### Reserves altered

#### LBTC ([0xecAc9C5F704e954931349Da37F60E39f515c11c1](https://basescan.org/address/0xecAc9C5F704e954931349Da37F60E39f515c11c1))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F](https://basescan.org/address/0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F) | [0xA04669FE5cba4Bb21f265B562D23e562E45A1C67](https://basescan.org/address/0xA04669FE5cba4Bb21f265B562D23e562E45A1C67) |
| oracleDescription | BTC / USD | Capped LBTC / BTC / USD |


## Raw diff

```json
{
  "reserves": {
    "0xecAc9C5F704e954931349Da37F60E39f515c11c1": {
      "oracle": {
        "from": "0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F",
        "to": "0xA04669FE5cba4Bb21f265B562D23e562E45A1C67"
      },
      "oracleDescription": {
        "from": "BTC / USD",
        "to": "Capped LBTC / BTC / USD"
      }
    }
  },
  "raw": {
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": "AaveV3Base.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x9494584aed5cd751dfda731ce708240f3b44d490b2febee994902cbe485628eb": {
          "previousValue": "0x00000000000000000000000064c911996d3c6ac71f9b455b1e8e7266bcbd848f",
          "newValue": "0x000000000000000000000000a04669fe5cba4bb21f265b562d23e562e45a1c67"
        }
      }
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xfd55fc2e9ef63e16e696580fa41a16b1359de042d9d894f9176ffec1c194a986": {
          "previousValue": "0x006894a7ca000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006894a7ca000000000003000000000000000000000000000000000000000000"
        },
        "0xfd55fc2e9ef63e16e696580fa41a16b1359de042d9d894f9176ffec1c194a987": {
          "previousValue": "0x000000000000000000093a8000000000000068c2cc4b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068c2cc4b0000000000006894a7cb"
        }
      }
    }
  }
}
```