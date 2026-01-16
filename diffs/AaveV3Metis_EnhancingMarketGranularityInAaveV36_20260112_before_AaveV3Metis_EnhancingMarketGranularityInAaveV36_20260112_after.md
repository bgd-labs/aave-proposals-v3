## Reserve changes

### Reserve altered

#### WETH ([0x420000000000000000000000000000000000000A](https://explorer.metis.io/address/0x420000000000000000000000000000000000000A))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x420000000000000000000000000000000000000A": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2233f8a66a728fba6e1dc95570b25360d07d5524": {
      "label": "GovernanceV3Metis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xa7d0f7195d52522be008ca0e9c182cb8d5cdec7c4327b16f8f80417732546566": {
          "previousValue": "0x006964430c000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006964430c000000000003000000000000000000000000000000000000000000"
        },
        "0xa7d0f7195d52522be008ca0e9c182cb8d5cdec7c4327b16f8f80417732546567": {
          "previousValue": "0x000000000000000000093a800000000000006992678d00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006992678d0000000000006964430d"
        }
      }
    },
    "0x90df02551bb792286e8d4f13e0e357b4bf1d6a57": {
      "label": "AaveV3Metis.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768652": {
          "previousValue": "0x100000000000000000000003e800098968000089544003e8a5062904206c1d4c",
          "newValue": "0x100000000000000000000003e800098968000089544003e8a5062904206c0000"
        },
        "0x0fdccc613812532a615714d6ff77f1af23e29eb01ab5b245f4af9eb5802adaec": {
          "previousValue": "0x100000000000000000000003e80000008fc0000002d005dc851229fe206c1f40",
          "newValue": "0x100000000000000000000003e80000008fc0000002d005dc811229fe206c1f40"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49a8": {
          "previousValue": "0x100000000000000000000003e800044aa200003d090003e8a50629041e781d4c",
          "newValue": "0x100000000000000000000003e800044aa200003d090003e8a50629041e780000"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895ee9": {
          "previousValue": "0x100000000000000000000003e8000030d4000002bf2009c4851229041e140000",
          "newValue": "0x100000000000000000000003e8000030d4000002bf2009c4811229041e140000"
        }
      }
    }
  }
}
```