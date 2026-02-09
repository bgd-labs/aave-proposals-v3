## Reserve changes

### Reserve altered

#### USDT ([0x3A337a6adA9d885b6Ad95ec48F9b75f197b5AE35](https://soneium.blockscout.com/address/0x3A337a6adA9d885b6Ad95ec48F9b75f197b5AE35))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 75 % [7500] | 0 % [0] |


#### WETH ([0x4200000000000000000000000000000000000006](https://soneium.blockscout.com/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 80 % [8000] | 0 % [0] |


#### USDC.e ([0xbA9986D2381edf1DA03B0B9c1f8b00dc4AacC369](https://soneium.blockscout.com/address/0xbA9986D2381edf1DA03B0B9c1f8b00dc4AacC369))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 75 % [7500] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x3A337a6adA9d885b6Ad95ec48F9b75f197b5AE35": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 8000,
        "to": 0
      }
    },
    "0xbA9986D2381edf1DA03B0B9c1f8b00dc4AacC369": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7500,
        "to": 0
      }
    }
  },
  "raw": {
    "0x1607fceec8deba4d5da66d620b2363066d025a02": {
      "label": "AaveV3Soneium.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {
        "0x03f80ab3b4640a38b8f08515ae914173693d0cd8c4cd0304d67c7d03eaecee7a": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001d4c"
        },
        "0xa23086c015a66d555a3fbf24329b30d3a0bcf7aaefe378d610638568f95bdfb5": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001f40"
        },
        "0xda8eeb4287d0362cea06ea5d4664a976bf418a718bf4cc3b36c562a01874e905": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001d4c"
        }
      }
    },
    "0x44d73d7c4b2f98f426bf8b5e87628d9ee38ef0cf": {
      "label": "GovernanceV3Soneium.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x405aad32e1adbac89bb7f176e338b8fc6e994ca210c9bb7bdca249b465942250": {
          "previousValue": "0x00698a101c000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00698a101c000000000003000000000000000000000000000000000000000000"
        },
        "0x405aad32e1adbac89bb7f176e338b8fc6e994ca210c9bb7bdca249b465942251": {
          "previousValue": "0x000000000000000000093a8000000000000069b8349d00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069b8349d000000000000698a101d"
        }
      }
    },
    "0xdd3d7a7d03d9fd9ef45f3e587287922ef65ca38b": {
      "label": "AaveV3Soneium.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x31101186433072fd3e464177ed05d67f9316c0cb4425bd40e9179e6038da741a": {
          "previousValue": "0x100000000000000000000003e80007a12000006ddd0003e8850629041e781d4c",
          "newValue": "0x100000000000000000000003e80007a12000006ddd0003e8870629041e780000"
        },
        "0x69333e1e245e3ec00fd5ec5edc58b86ba7a38387833b3990f23f23111089400b": {
          "previousValue": "0x100000000000000000000003e80004c4b4000044aa2003e8850629041e781d4c",
          "newValue": "0x100000000000000000000003e80004c4b4000044aa2003e8870629041e780000"
        },
        "0x9f34118313d08abcbe5d630066a42015e9c14ddd958820a505759421525c3ade": {
          "previousValue": "0x100000000000000000000003e80000003200000002d005dc85122968206c1f40",
          "newValue": "0x100000000000000000000003e80000003200000002d005dc87122968206c0000"
        }
      }
    }
  }
}
```