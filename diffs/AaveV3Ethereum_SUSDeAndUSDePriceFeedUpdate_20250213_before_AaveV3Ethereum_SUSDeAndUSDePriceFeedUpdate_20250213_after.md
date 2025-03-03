## Reserve changes

### Reserve altered

#### USDe ([0x4c9EDD5852cd905f086C759E8383e09bff1E68B3](https://etherscan.io/address/0x4c9EDD5852cd905f086C759E8383e09bff1E68B3))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17](https://etherscan.io/address/0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17) | [0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8](https://etherscan.io/address/0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8) |
| oracleDescription | Capped USDe / USD | Capped USDT/USD |
| oracleLatestAnswer | 0.99957608 | 1.00004 |


#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A](https://etherscan.io/address/0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A) | [0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec](https://etherscan.io/address/0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec) |
| oracleDescription | Capped sUSDe / USDe / USD | Capped sUSDe / USDT / USD |
| oracleLatestAnswer | 1.15555105 | 1.15608736 |


## Raw diff

```json
{
  "reserves": {
    "0x4c9EDD5852cd905f086C759E8383e09bff1E68B3": {
      "oracle": {
        "from": "0x55B6C4D3E8A27b8A1F5a263321b602e0fdEEcC17",
        "to": "0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8"
      },
      "oracleDescription": {
        "from": "Capped USDe / USD",
        "to": "Capped USDT/USD"
      },
      "oracleLatestAnswer": {
        "from": "99957608",
        "to": "100004000"
      }
    },
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
        "from": "115555105",
        "to": "115608736"
      }
    }
  },
  "raw": {
    "0x0d5f4aadf3fde31bbb55db5f42c080f18ad54df5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x2f39d218133afab8f2b819b1066c7e434ad94e9e": {
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
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x4b52de242af8e0998837b071693bd8f6ce57e6a143f73600341bde1d27dd942e": {
          "previousValue": "0x000000000000000000000000b37ae8aba6c0c1bf2c509fc06e11aa4af29b665a",
          "newValue": "0x00000000000000000000000042bc86f2f08419280a99d8fbea4672e7c30a86ec"
        },
        "0x90d628ded44f1f261dfa9f63c16c15780e5b0951340049b5a0739eb33d7c014f": {
          "previousValue": "0x00000000000000000000000055b6c4d3e8a27b8a1f5a263321b602e0fdeecc17",
          "newValue": "0x000000000000000000000000c26d4a1c46d884cff6de9800b6ae7a8cf48b4ff8"
        }
      }
    },
    "0x7222182cb9c5320587b5148bf03eee107ad64578": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf0": {
          "previousValue": "0x0067ae6af2000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067ae6af2000000000003000000000000000000000000000000000000000000"
        },
        "0xe7484af6bbc8157ed372968cb5ffae804c38bcbc5773bb07433d44bbcc6ebbf1": {
          "previousValue": "0x000000000000000000093a8000000000000067dc8f7300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067dc8f7300000000000067ae6af3"
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
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```