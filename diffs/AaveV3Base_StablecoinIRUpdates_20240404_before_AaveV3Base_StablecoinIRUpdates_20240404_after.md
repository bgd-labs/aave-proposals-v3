## Reserve changes

### Reserve altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA](https://basescan.org/address/0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA) | [0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A](https://basescan.org/address/0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A) |
| variableRateSlope1 | 6 % | 12 % |
| baseStableBorrowRate | 6 % | 12 % |
| interestRate | ![before](/.assets/44bd6c5258c27248fabcd09a99dec757454c2a7e.svg) | ![after](/.assets/2dd6d84168e4068a40122f647020c27ee3e36ed1.svg) |

#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7](https://basescan.org/address/0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7) | [0x64163263753A9610a391A5D0276ae94B0d42fB75](https://basescan.org/address/0x64163263753A9610a391A5D0276ae94B0d42fB75) |
| variableRateSlope1 | 7 % | 13 % |
| baseStableBorrowRate | 8 % | 14 % |
| interestRate | ![before](/.assets/d79d8eb0abd33ffb877708fe07140ce5c8503360.svg) | ![after](/.assets/830c41eadf476da561594683a69e91e3a5f6862f.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "interestRateStrategy": {
        "from": "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA",
        "to": "0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "interestRateStrategy": {
        "from": "0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7",
        "to": "0x64163263753A9610a391A5D0276ae94B0d42fB75"
      }
    }
  },
  "strategies": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "address": {
        "from": "0x136848FdaedEB56245bE0e61E28A3CB8c0B45CaA",
        "to": "0xcbF65e0708961Da6Dd3F1A4e1cE17D97D1E8C29A"
      },
      "baseStableBorrowRate": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "60000000000000000000000000",
        "to": "120000000000000000000000000"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "address": {
        "from": "0xDBea12F69D3Fcb4Be9FD14dd450AAe2B2a3d4de7",
        "to": "0x64163263753A9610a391A5D0276ae94B0d42fB75"
      },
      "baseStableBorrowRate": {
        "from": "80000000000000000000000000",
        "to": "140000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "130000000000000000000000000"
      }
    }
  }
}
```