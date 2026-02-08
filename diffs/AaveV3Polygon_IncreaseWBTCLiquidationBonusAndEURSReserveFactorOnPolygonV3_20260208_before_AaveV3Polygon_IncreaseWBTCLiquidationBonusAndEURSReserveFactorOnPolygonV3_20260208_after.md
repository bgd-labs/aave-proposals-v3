## Reserve changes

### Reserve altered

#### WBTC ([0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6))

| description | value before | value after |
| --- | --- | --- |
| liquidationBonus | 6.5 % | 8.5 % |


#### EURS ([0xE111178A87A3BFf0c8d18DECBa5798827539Ae99](https://polygonscan.com/address/0xE111178A87A3BFf0c8d18DECBa5798827539Ae99))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 50 % [5000] | 99 % [9900] |


## Raw diff

```json
{
  "reserves": {
    "0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6": {
      "liquidationBonus": {
        "from": 10650,
        "to": 10850
      }
    },
    "0xE111178A87A3BFf0c8d18DECBa5798827539Ae99": {
      "reserveFactor": {
        "from": 5000,
        "to": 9900
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x70d52b43b3e1f9a31ab6163a901e55133bd37da50c470c7ad07e6be9a4e139f4": {
          "previousValue": "0x0069888f22000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069888f22000000000003000000000000000000000000000000000000000000"
        },
        "0x70d52b43b3e1f9a31ab6163a901e55133bd37da50c470c7ad07e6be9a4e139f5": {
          "previousValue": "0x000000000000000000093a8000000000000069b6b3a300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069b6b3a300000000000069888f23"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b3f": {
          "previousValue": "0x100000000640000000000103e80000000010000000011388850229fe1b580000",
          "newValue": "0x100000000640000000000103e800000000100000000126ac850229fe1b580000"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b40": {
          "previousValue": "0x00000000000abaf9ddbe8660c1399d6f0000000003b66958142017bdda67649e",
          "newValue": "0x00000000000036f0b15376c5b7d5bb570000000003b669f0adb344e8d557fa93"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b41": {
          "previousValue": "0x000000000035b8458ea6a1146a04cd5900000000042f50712f2904f9ea0fb397",
          "newValue": "0x000000000035b857828750d99dd435e600000000042f53ce5704fc4421dac803"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b42": {
          "previousValue": "0x000000000000000000000d00698877df000000000000000000000000000002fa",
          "newValue": "0x000000000000000000000d0069888f23000000000000000000000000000002fa"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b47": {
          "previousValue": "0x00000000000000000000000006feb03200000000000000000000000000000656",
          "newValue": "0x00000000000000000000000006feb032000000000000000000000000000007f6"
        },
        "0xc5ebd5b2073c8b001a486e0ad6da181e63a9cd81f1cc46f94ddc191acb130eff": {
          "previousValue": "0x100000000000000000000003e80000009c400000003b13888508299a1e781c84",
          "newValue": "0x100000000000000000000003e80000009c400000003b138885082a621e781c84"
        }
      }
    }
  }
}
```