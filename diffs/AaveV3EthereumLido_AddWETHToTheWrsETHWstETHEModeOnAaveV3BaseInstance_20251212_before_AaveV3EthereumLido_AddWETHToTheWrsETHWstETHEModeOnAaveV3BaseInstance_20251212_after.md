## Reserve changes

### Reserves altered

#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 65,000 rsETH | 15,000 rsETH |


## Raw diff

```json
{
  "reserves": {
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "supplyCap": {
        "from": 65000,
        "to": 15000
      }
    }
  },
  "raw": {
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0xed45a05ce0954e645f11725167843283bb37c29952c0335b670d63d10fcad8ef": {
          "previousValue": "0x100000000000000000000003e800000fde8000000001000f811229fe000a0005",
          "newValue": "0x100000000000000000000003e8000003a98000000001000f811229fe000a0005"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xf29a47cc56db769417bfe11e85c712aa9920cdd341de96305d778b58202ad754": {
          "previousValue": "0x00693bdf2e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693bdf2e000000000003000000000000000000000000000000000000000000"
        },
        "0xf29a47cc56db769417bfe11e85c712aa9920cdd341de96305d778b58202ad755": {
          "previousValue": "0x000000000000000000093a80000000000000696a03af00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000696a03af000000000000693bdf2f"
        }
      }
    }
  }
}
```