## Reserve changes

### Reserve altered

#### WBTC ([0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6))

| description | value before | value after |
| --- | --- | --- |
| liquidationBonus | 7 % | 8.5 % |


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
        "from": 10700,
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
          "previousValue": "0x006989f3ec000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006989f3ec000000000003000000000000000000000000000000000000000000"
        },
        "0x70d52b43b3e1f9a31ab6163a901e55133bd37da50c470c7ad07e6be9a4e139f5": {
          "previousValue": "0x000000000000000000093a8000000000000069b8186d00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069b8186d0000000000006989f3ed"
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
          "previousValue": "0x000000000008fc94d80f8b4c1b1f9e460000000003b67125e4531ed1438dca86",
          "newValue": "0x0000000000002e03565a83160b5352240000000003b672666fc8c7f9ca518b41"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b41": {
          "previousValue": "0x000000000031ff35d03aca6d9211643f00000000042f7dee011f1f63b0306765",
          "newValue": "0x000000000031ff5e01bea20948db442800000000042f85c880bcaf656ea4e984"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b42": {
          "previousValue": "0x000000000000000000000d006989b993000000000000000000000000000002fc",
          "newValue": "0x000000000000000000000d006989f3ed000000000000000000000000000002fc"
        },
        "0x4eb4e5a6e8e7d99cfc6b20a4316cf17fcae80ee90389b4de8cfd0d3328359b47": {
          "previousValue": "0x00000000000000000000000007761be100000000000000000000000000000b58",
          "newValue": "0x00000000000000000000000007761be100000000000000000000000000000ec3"
        },
        "0xc5ebd5b2073c8b001a486e0ad6da181e63a9cd81f1cc46f94ddc191acb130eff": {
          "previousValue": "0x100000000000000000000003e80000009c400000003b1388850829cc1e781c84",
          "newValue": "0x100000000000000000000003e80000009c400000003b138885082a621e781c84"
        }
      }
    }
  }
}
```