## Reserve changes

### Reserve altered

#### eBTC ([0x657e8C867D8B37dCC18fA4Caead9C45EB088C642](https://etherscan.io/address/0x657e8C867D8B37dCC18fA4Caead9C45EB088C642))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x577C217cB5b1691A500D48aA7F69346409cFd668](https://etherscan.io/address/0x577C217cB5b1691A500D48aA7F69346409cFd668) | [0x03bB418e89B75407585f8198178f253DA3216218](https://etherscan.io/address/0x03bB418e89B75407585f8198178f253DA3216218) |


#### LBTC ([0x8236a87084f8B84306f72007F36F2618A5634494](https://etherscan.io/address/0x8236a87084f8B84306f72007F36F2618A5634494))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) | [0xf8c04B50499872A5B5137219DEc0F791f7f620D0](https://etherscan.io/address/0xf8c04B50499872A5B5137219DEc0F791f7f620D0) |
| oracleDescription | BTC / USD | Capped LBTC / BTC / USD |
| oracleLatestAnswer | 119665.73 | 119667.05332541 |


## Raw diff

```json
{
  "reserves": {
    "0x657e8C867D8B37dCC18fA4Caead9C45EB088C642": {
      "oracle": {
        "from": "0x577C217cB5b1691A500D48aA7F69346409cFd668",
        "to": "0x03bB418e89B75407585f8198178f253DA3216218"
      }
    },
    "0x8236a87084f8B84306f72007F36F2618A5634494": {
      "oracle": {
        "from": "0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A",
        "to": "0xf8c04B50499872A5B5137219DEc0F791f7f620D0"
      },
      "oracleDescription": {
        "from": "BTC / USD",
        "to": "Capped LBTC / BTC / USD"
      },
      "oracleLatestAnswer": {
        "from": "11966573000000",
        "to": "11966705332541"
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
        },
        "0xd3e4f25aaf2a33c02a6679e805658e410a92450da2dfd14fa956d40c26cc3b62": {
          "previousValue": "0x000000000000000000000000577c217cb5b1691a500d48aa7f69346409cfd668",
          "newValue": "0x00000000000000000000000003bb418e89b75407585f8198178f253da3216218"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x8613957cb04fd19296f7ee1a2f10d99d956d8f54b02d0981da9848a0b28e8c1f": {
          "previousValue": "0x006899f056000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006899f056000000000003000000000000000000000000000000000000000000"
        },
        "0x8613957cb04fd19296f7ee1a2f10d99d956d8f54b02d0981da9848a0b28e8c20": {
          "previousValue": "0x000000000000000000093a8000000000000068c814d700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068c814d70000000000006899f057"
        }
      }
    }
  }
}
```