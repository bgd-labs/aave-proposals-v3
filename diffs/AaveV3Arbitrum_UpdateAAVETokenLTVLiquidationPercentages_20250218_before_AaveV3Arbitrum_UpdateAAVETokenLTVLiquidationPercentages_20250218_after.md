## Reserve changes

### Reserves altered

#### AAVE ([0xba5DdD1f9d7F570dc94a51479a000E3BCE967196](https://arbiscan.io/address/0xba5DdD1f9d7F570dc94a51479a000E3BCE967196))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 66 % [6600] |
| liquidationThreshold | 70 % [7000] | 73 % [7300] |


## Raw diff

```json
{
  "reserves": {
    "0xba5DdD1f9d7F570dc94a51479a000E3BCE967196": {
      "liquidationThreshold": {
        "from": 7000,
        "to": 7300
      },
      "ltv": {
        "from": 6300,
        "to": 6600
      }
    }
  },
  "raw": {
    "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xd899c8b99c107ebd126158f0533ed068d266f28a5afc25749942d7d708638c6d": {
          "previousValue": "0x0067b825e2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067b825e2000000000003000000000000000000000000000000000000000000"
        },
        "0xd899c8b99c107ebd126158f0533ed068d266f28a5afc25749942d7d708638c6e": {
          "previousValue": "0x000000000000000000093a8000000000000067e64a6300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067e64a6300000000000067b825e3"
        }
      }
    },
    "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7a7ef57479123f26db6a0e3efbf8a3562edd65be": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x0ba91ba94fb3ecb5bcc13103bfda08c6666915f98f5b84b9d9a7d68f4cad7a82": {
          "previousValue": "0x100000000000000000000003e8000008ca0000000000000081122af81b58189c",
          "newValue": "0x100000000000000000000003e8000008ca0000000000000081122af81c8419c8"
        }
      }
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```