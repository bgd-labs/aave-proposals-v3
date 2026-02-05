## Reserve changes

### Reserve altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### sUSDe ([0x9D39A5DE30e57443BfF2A8307A4256c8797A3497](https://etherscan.io/address/0x9D39A5DE30e57443BfF2A8307A4256c8797A3497))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### tETH ([0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8](https://etherscan.io/address/0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### ezETH ([0xbf5495Efe5DB9ce00f80364C8B423567e58d2110](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x9D39A5DE30e57443BfF2A8307A4256c8797A3497": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xD11c452fc99cF405034ee446803b6F6c1F6d5ED8": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xbf5495Efe5DB9ce00f80364C8B423567e58d2110": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    }
  },
  "raw": {
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x6c3847a02c991876166c8be676e3ca84a3c105eb60433934c4091c1a7cd316ee": {
          "previousValue": "0x100000000000000000000003e800003a98000000006405dc011229fe000a0005",
          "newValue": "0x100000000000000000000003e800003a98000000006405dc011229fe000a0000"
        },
        "0xb175b141cba0cc992ab972ad55e21f463dc10a5251e5513e6498931ace66c014": {
          "previousValue": "0x100000000000000000000003e800000ea600000000011388811229fe000a0005",
          "newValue": "0x100000000000000000000003e800000ea600000000011388811229fe000a0000"
        },
        "0xb587e101db980eb9a3d4491a64340bd6e10aa0a7bfd3cc48f4b5cadccf068ded": {
          "previousValue": "0x100000000000000000000003e80039387000000003e803e8811229fe000a0005",
          "newValue": "0x100000000000000000000003e80039387000000003e803e8811229fe000a0000"
        },
        "0xc9d7ec48cd0d839522455f78914adfeda8686316bb6819e0888e4bcd349e01b2": {
          "previousValue": "0x100000000000000000000103e800009eb100000445c001f485122968206c2008",
          "newValue": "0x100000000000000000000103e800009eb100000445c001f481122968206c2008"
        },
        "0xed45a05ce0954e645f11725167843283bb37c29952c0335b670d63d10fcad8ef": {
          "previousValue": "0x100000000000000000000003e8000003a98000000001000f811229fe000a0005",
          "newValue": "0x100000000000000000000003e8000003a98000000001000f811229fe000a0000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xbe350a38cc5c51bfe2e30b263c389ff98a218ceae2d1822ba1ebb7c4dda05c2e": {
          "previousValue": "0x006978000a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006978000a000000000003000000000000000000000000000000000000000000"
        },
        "0xbe350a38cc5c51bfe2e30b263c389ff98a218ceae2d1822ba1ebb7c4dda05c2f": {
          "previousValue": "0x000000000000000000093a8000000000000069a6248b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a6248b0000000000006978000b"
        }
      }
    }
  }
}
```