## Reserve changes

### Reserve altered

#### weETH ([0x01f0a31698C4d065659b9bdC21B3610292a1c506](https://scrollscan.com/address/0x01f0a31698C4d065659b9bdC21B3610292a1c506))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### SCR ([0xd29687c813D741E2F938F4aC377128810E217b1b](https://scrollscan.com/address/0xd29687c813D741E2F938F4aC377128810E217b1b))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wstETH ([0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32](https://scrollscan.com/address/0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x01f0a31698C4d065659b9bdC21B3610292a1c506": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xd29687c813D741E2F938F4aC377128810E217b1b": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xf610A9dfB7C89644979b4A0f27063E9e7d7Cda32": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x11fcfe756c05ad438e312a7fd934381537d3cffe": {
      "label": "AaveV3Scroll.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x2b6e571894a67fdd1c77295d9800f30a753086b57d252b5e12aa6c2fba39f4bf": {
          "previousValue": "0x100000000000000000000103e80000003e80000001f41388851229cc1edc1d4c",
          "newValue": "0x100000000000000000000103e80000003e80000001f41388811229cc1edc1d4c"
        },
        "0x3671c420e577d93728d59ca197d18934a39de4918df3378204e40369494a4f19": {
          "previousValue": "0x100000000000000000000103e80000013880000000011388851229fe1d4c1c52",
          "newValue": "0x100000000000000000000103e80000013880000000011388811229fe1d4c1c52"
        },
        "0x38fad9b7a77600d21f19a28b69cbe02e4f7247df727e8896987e9340f1fa6d60": {
          "previousValue": "0x1000000000000000000000000000016e36000000000113888512000000000000",
          "newValue": "0x1000000000000000000000000000016e36000000000113888112000000000000"
        }
      }
    },
    "0x6b6b41c0f8c223715f712be83cec3c37bbfdc3fe": {
      "label": "GovernanceV3Scroll.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x28eef39a072497d2105dcb780594e4ed840d3beb94e2ea31a78a935b50a4ae2e": {
          "previousValue": "0x00696443c7000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00696443c7000000000003000000000000000000000000000000000000000000"
        },
        "0x28eef39a072497d2105dcb780594e4ed840d3beb94e2ea31a78a935b50a4ae2f": {
          "previousValue": "0x000000000000000000093a800000000000006992684800000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069926848000000000000696443c8"
        }
      }
    }
  }
}
```