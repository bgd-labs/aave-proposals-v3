## Reserve changes

### Reserves altered

#### AAVE ([0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9](https://etherscan.io/address/0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9))

| description | value before | value after |
| --- | --- | --- |
| ltv | 66 % [6600] | 69 % [6900] |
| liquidationThreshold | 73 % [7300] | 76 % [7600] |


## Raw diff

```json
{
  "reserves": {
    "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9": {
      "liquidationThreshold": {
        "from": 7300,
        "to": 7600
      },
      "ltv": {
        "from": 6600,
        "to": 6900
      }
    }
  },
  "raw": {
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x64b761d848206f447fe2dd461b0c635ec39ebb27": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x2365e0ce0defc8344c79251e10c13bda9f60f98c7b76a120b28b1a0e8fcfc361": {
          "previousValue": "0x0067b5108e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067b5108e000000000003000000000000000000000000000000000000000000"
        },
        "0x2365e0ce0defc8344c79251e10c13bda9f60f98c7b76a120b28b1a0e8fcfc362": {
          "previousValue": "0x000000000000000000093a8000000000000067e3350f00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067e3350f00000000000067b5108f"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xef434e4573b90b6ecd4a00f4888381e4d0cc5ccd": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x070a95ec3546cae47592e0bcea195bf8f96287077fbb7a23785cc2887152941c": {
          "previousValue": "0x100000000000000000000003e80001c3a900000000000000011229fe1c8419c8",
          "newValue": "0x100000000000000000000003e80001c3a900000000000000011229fe1db01af4"
        }
      }
    }
  }
}
```