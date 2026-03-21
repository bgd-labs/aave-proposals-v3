## Reserve changes

### Reserves altered

#### wstETH (0xe48D935e6C9e735463ccCf29a7F11e32bC09136E)

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 78.5 % [7850] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0xe48D935e6C9e735463ccCf29a7F11e32bC09136E": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 7850,
        "to": 0
      }
    }
  },
  "raw": {
    "0x061d8e131f26512348ee5fa42e2df1ba9d6505e9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x39ba8c26fc81e6a37a870115940ab32ed25c9ae7": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xca963fec62faed922acbb90d0b562be712c4c251e629b77d5199eccf3b17def7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001eaa"
        }
      }
    },
    "0x47aadaae1f05c978e6abb7568d11b7f6e0fc4d6a": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x7120b1f8e5b73c0c0dc99c6e52fe4937e7ea11e0": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb458": {
          "previousValue": "0x006913b365000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006913b365000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8dc4e5242ea8b1ab1d60606dae757e6c2cca9f92a2cced9f72c19960bcb459": {
          "previousValue": "0x000000000000000000093a800000000000006941d7e600000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006941d7e60000000000006913b366"
        }
      }
    },
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa119f84bc1b8083f5061e4cf53705cbf1065ba27": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xf68e00084c275144b1974bd3f2feb9cbe71b28d9383f814d793ed298fc865b93": {
          "previousValue": "0x100000000000000000000003e8000004e200000013880dac851229681fa41eaa",
          "newValue": "0x100000000000000000000003e8000004e200000013880dac871229681fa40000"
        }
      }
    },
    "0xa860355f0ccfdc823f7332ac108317b2a1509c06": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xc022b6c71c30a8ad52dac504efa132d13d99d2d9": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```