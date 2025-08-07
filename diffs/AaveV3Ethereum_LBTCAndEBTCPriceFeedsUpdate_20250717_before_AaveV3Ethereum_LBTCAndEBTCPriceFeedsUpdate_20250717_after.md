## Reserve changes

### Reserves altered

#### LBTC ([0x8236a87084f8B84306f72007F36F2618A5634494](https://etherscan.io/address/0x8236a87084f8B84306f72007F36F2618A5634494))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) | [0xf8c04B50499872A5B5137219DEc0F791f7f620D0](https://etherscan.io/address/0xf8c04B50499872A5B5137219DEc0F791f7f620D0) |
| oracleDescription | BTC / USD | Capped LBTC / BTC / USD |


## Raw diff

```json
{
  "reserves": {
    "0x8236a87084f8B84306f72007F36F2618A5634494": {
      "oracle": {
        "from": "0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A",
        "to": "0xf8c04B50499872A5B5137219DEc0F791f7f620D0"
      },
      "oracleDescription": {
        "from": "BTC / USD",
        "to": "Capped LBTC / BTC / USD"
      }
    }
  },
  "raw": {
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x0d822d63469ab72b7f00991445ce1436949c97775f8d0e44f498337ae450a252": {
          "previousValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a",
          "newValue": "0x000000000000000000000000f8c04b50499872a5b5137219dec0f791f7f620d0"
        }
      }
    },
    "0x577c217cb5b1691a500d48aa7f69346409cfd668": {
      "label": "AaveV3Ethereum.ASSETS.eBTC.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000001": {
          "previousValue": "0x00000000000000000000000000000067dabdef00000000000000000005f5e100",
          "newValue": "0x000000000000000000000000000000684f3c7700000000000000000005f5e100"
        },
        "0x0000000000000000000000000000000000000000000000000000000000000002": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000000000000000be"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xf5647cf2573625ccbe9a0b30aa78a110d0e7ac736f8a0e5ccc4022496f1a33b3": {
          "previousValue": "0x00689480e6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00689480e6000000000003000000000000000000000000000000000000000000"
        },
        "0xf5647cf2573625ccbe9a0b30aa78a110d0e7ac736f8a0e5ccc4022496f1a33b4": {
          "previousValue": "0x000000000000000000093a8000000000000068c2a56700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068c2a567000000000000689480e7"
        }
      }
    }
  }
}
```