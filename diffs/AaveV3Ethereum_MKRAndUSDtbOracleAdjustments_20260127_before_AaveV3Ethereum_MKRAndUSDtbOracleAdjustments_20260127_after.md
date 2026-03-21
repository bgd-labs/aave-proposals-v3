## Reserve changes

### Reserve altered

#### MKR ([0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xec1D1B3b0443256cc3860e24a46F108e699484Aa](https://etherscan.io/address/0xec1D1B3b0443256cc3860e24a46F108e699484Aa) | [0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478](https://etherscan.io/address/0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478) |
| oracleDescription | MKR / USD | MKR/USD (calculated) |
| oracleLatestAnswer | 1501.49941844 | 1494.9540144 |


#### USDtb ([0xC139190F447e929f090Edeb554D95AbB8b18aC1C](https://etherscan.io/address/0xC139190F447e929f090Edeb554D95AbB8b18aC1C))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x2FA6A78E3d617c1013a22938411602dc9Da98dBa](https://etherscan.io/address/0x2FA6A78E3d617c1013a22938411602dc9Da98dBa) | [0x88025072A7dB6Db5e54E46d43850bb44CA93D6C0](https://etherscan.io/address/0x88025072A7dB6Db5e54E46d43850bb44CA93D6C0) |
| oracleDescription | Capped USDtb / USD | ONE USD |
| oracleLatestAnswer | 0.99930788 | 1 |


## Raw diff

```json
{
  "reserves": {
    "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2": {
      "oracle": {
        "from": "0xec1D1B3b0443256cc3860e24a46F108e699484Aa",
        "to": "0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478"
      },
      "oracleDescription": {
        "from": "MKR / USD",
        "to": "MKR/USD (calculated)"
      },
      "oracleLatestAnswer": {
        "from": "150149941844",
        "to": "149495401440"
      }
    },
    "0xC139190F447e929f090Edeb554D95AbB8b18aC1C": {
      "oracle": {
        "from": "0x2FA6A78E3d617c1013a22938411602dc9Da98dBa",
        "to": "0x88025072A7dB6Db5e54E46d43850bb44CA93D6C0"
      },
      "oracleDescription": {
        "from": "Capped USDtb / USD",
        "to": "ONE USD"
      },
      "oracleLatestAnswer": {
        "from": "99930788",
        "to": "100000000"
      }
    }
  },
  "raw": {
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x6e8a06919cb268cba6b5c4b6e72b281a2aa7ec0a7c2865f3cb4cc8afbd2b3f75": {
          "previousValue": "0x0000000000000000000000002fa6a78e3d617c1013a22938411602dc9da98dba",
          "newValue": "0x00000000000000000000000088025072a7db6db5e54e46d43850bb44ca93d6c0"
        },
        "0xdda00a57bee26ed4ac93f73d0238caf2b0b80d455de521e247ae994efa80def5": {
          "previousValue": "0x000000000000000000000000ec1d1b3b0443256cc3860e24a46f108e699484aa",
          "newValue": "0x00000000000000000000000044bb2a64baf94210b583338d3d97b1e8288bd478"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xbe350a38cc5c51bfe2e30b263c389ff98a218ceae2d1822ba1ebb7c4dda05c2e": {
          "previousValue": "0x0069786af6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069786af6000000000003000000000000000000000000000000000000000000"
        },
        "0xbe350a38cc5c51bfe2e30b263c389ff98a218ceae2d1822ba1ebb7c4dda05c2f": {
          "previousValue": "0x000000000000000000093a8000000000000069a68f7700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a68f7700000000000069786af7"
        }
      }
    }
  }
}
```