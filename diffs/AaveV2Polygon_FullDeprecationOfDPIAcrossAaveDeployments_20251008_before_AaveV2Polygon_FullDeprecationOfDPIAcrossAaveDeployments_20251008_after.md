## Reserve changes

### Reserves altered

#### DPI ([0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369](https://polygonscan.com/address/0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xC70aAF9092De3a4E5000956E672cDf5E996B4610](https://polygonscan.com/address/0xC70aAF9092De3a4E5000956E672cDf5E996B4610) | [0xD550Bce1a506F48802C9A4464c64E14A3141cE73](https://polygonscan.com/address/0xD550Bce1a506F48802C9A4464c64E14A3141cE73) |
| oracleDescription | DPI / ETH | Fixed DPI/ETH |
| oracleLatestAnswer | 0.02294791668344909 | 0.022767 |


## Raw diff

```json
{
  "reserves": {
    "0x85955046DF4668e1DD369D2DE9f3AEB98DD2A369": {
      "oracle": {
        "from": "0xC70aAF9092De3a4E5000956E672cDf5E996B4610",
        "to": "0xD550Bce1a506F48802C9A4464c64E14A3141cE73"
      },
      "oracleDescription": {
        "from": "DPI / ETH",
        "to": "Fixed DPI/ETH"
      },
      "oracleLatestAnswer": {
        "from": "22947916683449090",
        "to": "22767000000000000"
      }
    }
  },
  "raw": {
    "0x0229f777b0fab107f9591a41d5f02e4e98db6f2d": {
      "label": "AaveV2Polygon.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x839c335b050aa389552a6744d5bf292c4aab87f5a912e79904ae9ac082238c07": {
          "previousValue": "0x000000000000000000000000c70aaf9092de3a4e5000956e672cdf5e996b4610",
          "newValue": "0x000000000000000000000000d550bce1a506f48802c9a4464c64e14a3141ce73"
        }
      }
    },
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x93d1935305b2d38c36a29894407d9e2a1bc6d663aa42bffc7b7c21e606326569": {
          "previousValue": "0x0068e66887000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068e66887000000000003000000000000000000000000000000000000000000"
        },
        "0x93d1935305b2d38c36a29894407d9e2a1bc6d663aa42bffc7b7c21e60632656a": {
          "previousValue": "0x000000000000000000093a8000000000000069148d0800000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069148d0800000000000068e66888"
        }
      }
    }
  }
}
```