## Reserve changes

### Reserve altered

#### wstETH ([0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### LINK ([0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6](https://optimistic.etherscan.io/address/0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 66 % [6600] | 0 % [0] |
| borrowingEnabled | true | false |


#### OP ([0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042))

| description | value before | value after |
| --- | --- | --- |
| ltv | 58 % [5800] | 0 % [0] |
| borrowingEnabled | true | false |


#### AAVE ([0x76FB31fb4af56892A25e32cFC43De717950c9278](https://optimistic.etherscan.io/address/0x76FB31fb4af56892A25e32cFC43De717950c9278))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 0 % [0] |


#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| borrowingEnabled | true | false |


#### rETH ([0x9Bcef72be871e61ED4fBbc7630889beE758eb81D](https://optimistic.etherscan.io/address/0x9Bcef72be871e61ED4fBbc7630889beE758eb81D))

| description | value before | value after |
| --- | --- | --- |
| ltv | 69 % [6900] | 0 % [0] |
| borrowingEnabled | true | false |


#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 6600,
        "to": 0
      }
    },
    "0x4200000000000000000000000000000000000042": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 5800,
        "to": 0
      }
    },
    "0x76FB31fb4af56892A25e32cFC43De717950c9278": {
      "ltv": {
        "from": 6300,
        "to": 0
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0x9Bcef72be871e61ED4fBbc7630889beE758eb81D": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 6900,
        "to": 0
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x0e1a3af1f9cc76a62ed31ededca291e63632e7c4": {
      "label": "GovernanceV3Optimism.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x81df324fbe7ec2f6d6affc089132b5517e4c091511c539ecfb5003bac7e24648": {
          "previousValue": "0x0069643e68000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069643e68000000000003000000000000000000000000000000000000000000"
        },
        "0x81df324fbe7ec2f6d6affc089132b5517e4c091511c539ecfb5003bac7e24649": {
          "previousValue": "0x000000000000000000093a80000000000000699262e900000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000699262e900000000000069643e69"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Optimism.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x7bc4c94189e16da80443826b0fd9737b693203cefa05dc514825d9c1f7c5d031": {
          "previousValue": "0x100000000000000000000203e80000086c40000000be01f4851229e01edc1d4c",
          "newValue": "0x100000000000000000000203e80000086c40000000be01f4811229e01edc1d4c"
        },
        "0x856845219b63e8d45b358ae184fc72e7f8cbde44b8dfca0ddb2b5897366c80b4": {
          "previousValue": "0x100000000000000000000003e80000395f800000000107d085122af81bbc19c8",
          "newValue": "0x100000000000000000000003e80000395f800000000107d081122af81bbc0000"
        },
        "0x8cee8bbd821b6580e77e2af658f032b95735f4513ee645cc11dcce6d3c18cc5b": {
          "previousValue": "0x100000000000000000000203e80000008fc00000000105dc851229fe1ce81af4",
          "newValue": "0x100000000000000000000203e80000008fc00000000105dc811229fe1ce80000"
        },
        "0x999a28994fd329fbb33c1de5f7d344e757804721b9631af4101beaae2c325286": {
          "previousValue": "0x100000000000000000000103e800112a880000ec82e01388a50629041eaa1d4c",
          "newValue": "0x100000000000000000000103e800112a880000ec82e01388a10629041eaa0000"
        },
        "0x9ce6278e184d22158c3363fe1536b1e1145cc69f8509682543862c8febee6087": {
          "previousValue": "0x100000000000000000000003e8001312d0000000000107d085122af8189c16a8",
          "newValue": "0x100000000000000000000003e8001312d0000000000107d081122af8189c0000"
        },
        "0xa982d1cb7d68220294ac63c5092ec5248aee8c7ea585ba78b39b5d7ef7f89cb2": {
          "previousValue": "0x100000000000000000000103e800000000100000000107d08112292c1b580000",
          "newValue": "0x100000000000000000000103e800000000100000000107d08112292c1b580000"
        },
        "0xd6d0b7b9827920ce783ea0df077a51137f789e17390f39ee341359db9757ae95": {
          "previousValue": "0x1000000000000000000000000000000000100000000113888512000000000000",
          "newValue": "0x1000000000000000000000000000000000100000000113888112000000000000"
        },
        "0xe6a0997edc1b503377bbd4d33a56db187554c38e98ae1d78488c623dfc38abef": {
          "previousValue": "0x100000000000000000000003e8000004650000000000000081122af81b58189c",
          "newValue": "0x100000000000000000000003e8000004650000000000000081122af81b580000"
        }
      }
    }
  }
}
```