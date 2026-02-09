## Reserve changes

### Reserve altered

#### WETH ([0x420000000000000000000000000000000000000A](https://explorer.metis.io/address/0x420000000000000000000000000000000000000A))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 80 % [8000] | 0 % [0] |


#### m.DAI ([0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0](https://explorer.metis.io/address/0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |


#### Metis ([0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000](https://explorer.metis.io/address/0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |


#### m.USDC ([0xEA32A96608495e54156Ae48931A7c20f0dcc1a21](https://explorer.metis.io/address/0xEA32A96608495e54156Ae48931A7c20f0dcc1a21))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |


#### m.USDT ([0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC](https://explorer.metis.io/address/0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |


## Raw diff

```json
{
  "reserves": {
    "0x420000000000000000000000000000000000000A": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 8000,
        "to": 0
      }
    },
    "0x4c078361FC9BbB78DF910800A991C7c3DD2F6ce0": {
      "isFrozen": {
        "from": false,
        "to": true
      }
    },
    "0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000": {
      "isFrozen": {
        "from": false,
        "to": true
      }
    },
    "0xEA32A96608495e54156Ae48931A7c20f0dcc1a21": {
      "isFrozen": {
        "from": false,
        "to": true
      }
    },
    "0xbB06DCA3AE6887fAbF931640f67cab3e3a16F4dC": {
      "isFrozen": {
        "from": false,
        "to": true
      }
    }
  },
  "raw": {
    "0x2233f8a66a728fba6e1dc95570b25360d07d5524": {
      "label": "GovernanceV3Metis.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248f9": {
          "previousValue": "0x00698a0f90000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00698a0f90000000000003000000000000000000000000000000000000000000"
        },
        "0x8a3a0b6f6fa9438554c4aa5bdaf7838f6c90507836aabb33d6ebaeb414e248fa": {
          "previousValue": "0x000000000000000000093a8000000000000069b8341100000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069b83411000000000000698a0f91"
        }
      }
    },
    "0x69fee8f261e004453be0800bc9039717528645a6": {
      "label": "AaveV3Metis.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {
        "0xe6ac5b48650da611f38d9b918dff0ceb72ea19ae55c2cfec1bdbcc1740bdfdec": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001f40"
        }
      }
    },
    "0x90df02551bb792286e8d4f13e0e357b4bf1d6a57": {
      "label": "AaveV3Metis.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0b6d228d0a542c8a13256f0d04f81feb86131d8eb94f38c672add20de2768652": {
          "previousValue": "0x100000000000000000000003e800098968000089544003e8a5062904206c0000",
          "newValue": "0x100000000000000000000003e800098968000089544003e8a7062904206c0000"
        },
        "0x0fdccc613812532a615714d6ff77f1af23e29eb01ab5b245f4af9eb5802adaec": {
          "previousValue": "0x100000000000000000000003e80000008fc0000002d005dc811229fe206c1f40",
          "newValue": "0x100000000000000000000003e80000008fc0000002d005dc831229fe206c0000"
        },
        "0x950cc9b008213e183ae8d4fefc21a94651d44aecae390f359fefcdd3cc5e49a8": {
          "previousValue": "0x100000000000000000000003e800044aa200003d090003e8a50629041e780000",
          "newValue": "0x100000000000000000000003e800044aa200003d090003e8a70629041e780000"
        },
        "0xe06d26d8dffff310995f37741a6aedc9d679c36a326a4d84c0cf3a089a895ee9": {
          "previousValue": "0x100000000000000000000003e8000030d4000002bf2009c4811229041e140000",
          "newValue": "0x100000000000000000000003e8000030d4000002bf2009c4831229041e140000"
        },
        "0xf2b6bcad364da3f80b21ab04ff3a9b042b5d7669746a5fb320b7d0f0c088c3fd": {
          "previousValue": "0x10005f5e1000000000000003e80000927c000000000105dc85122af80fa00000",
          "newValue": "0x10005f5e1000000000000003e80000927c000000000105dc87122af80fa00000"
        }
      }
    }
  }
}
```