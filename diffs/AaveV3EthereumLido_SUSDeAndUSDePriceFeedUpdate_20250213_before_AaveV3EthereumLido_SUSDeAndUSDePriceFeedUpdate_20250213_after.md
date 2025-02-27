## Reserve changes

### Reserves altered

#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A](https://etherscan.io/address/0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A) | [0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec](https://etherscan.io/address/0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec) |
| oracleDescription | Capped sUSDe / USDe / USD | Capped sUSDe / USDT / USD |
| oracleLatestAnswer | 1.15555258 | 1.15608889 |


## Raw diff

```json
{
  "reserves": {
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "oracle": {
        "from": "0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A",
        "to": "0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec"
      },
      "oracleDescription": {
        "from": "Capped sUSDe / USDe / USD",
        "to": "Capped sUSDe / USDT / USD"
      },
      "oracleLatestAnswer": {
        "from": "115555258",
        "to": "115608889"
      }
    }
  },
  "raw": {
    "0x013e2c7567b6231e865bb9273f8c7656103611c0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x0d5f4aadf3fde31bbb55db5f42c080f18ad54df5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x3e7d1eab13ad0104d2750b8863b489d65364e32d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x4c9edd5852cd905f086c759e8383e09bff1e68b3": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf0": {
          "previousValue": "0x0067ae6d86000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067ae6d86000000000003000000000000000000000000000000000000000000"
        },
        "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf1": {
          "previousValue": "0x000000000000000000093a8000000000000067dc920700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067dc920700000000000067ae6d87"
        }
      }
    },
    "0x9d39a5de30e57443bff2a8307a4256c8797a3497": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc26d4a1c46d884cff6de9800b6ae7a8cf48b4ff8": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xcfbf336fe147d643b9cb705648500e101504b16d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe3c061981870c0c7b1f3c4f4bb36b95f1f260be6": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4b52de242af8e0998837b071693bd8f6ce57e6a143f73600341bde1d27dd942e": {
          "previousValue": "0x000000000000000000000000b37ae8aba6c0c1bf2c509fc06e11aa4af29b665a",
          "newValue": "0x00000000000000000000000042bc86f2f08419280a99d8fbea4672e7c30a86ec"
        }
      }
    }
  }
}
```