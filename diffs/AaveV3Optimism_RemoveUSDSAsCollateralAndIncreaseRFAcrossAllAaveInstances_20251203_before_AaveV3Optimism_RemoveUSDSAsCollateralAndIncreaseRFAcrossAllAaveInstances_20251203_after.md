## Reserve changes

### Reserves altered

#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 10,000,000 DAI | 2,000,000 DAI |
| borrowCap | 7,000,000 DAI | 1,800,000 DAI |
| ltv | 63 % [6300] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "borrowCap": {
        "from": 7000000,
        "to": 1800000
      },
      "ltv": {
        "from": 6300,
        "to": 0
      },
      "supplyCap": {
        "from": 10000000,
        "to": 2000000
      }
    }
  },
  "raw": {
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": "GovernanceV3Optimism.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x2642cbfa046d8004053cd054e488df5b74257ae1e497e38d227e7244ef11bf2d": {
          "previousValue": "0x0069304368000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069304368000000000003000000000000000000000000000000000000000000"
        },
        "0x2642cbfa046d8004053cd054e488df5b74257ae1e497e38d227e7244ef11bf2e": {
          "previousValue": "0x000000000000000000093a80000000000000695e67e900000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e67e900000000000069304369"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Optimism.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x737d92e4f754ad0901f4ba2f145786361957fa4b3c4c8367f2da2a3a09a9479a": {
          "previousValue": "0x100000000000000000000103e80009896800006acfc009c4a51229041e14189c",
          "newValue": "0x100000000000000000000103e80001e84800001b774009c4a51229041e140000"
        }
      }
    }
  }
}
```