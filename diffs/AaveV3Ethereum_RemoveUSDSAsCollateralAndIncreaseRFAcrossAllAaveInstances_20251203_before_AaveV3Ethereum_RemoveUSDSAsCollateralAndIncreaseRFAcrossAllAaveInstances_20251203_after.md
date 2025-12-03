## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 338,000,000 DAI | 200,000,000 DAI |
| borrowCap | 271,000,000 DAI | 180,000,000 DAI |
| ltv | 63 % [6300] | 0 % [0] |


#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 800,000,000 USDS | 160,000,000 USDS |
| borrowCap | 360,000,000 USDS | 144,000,000 USDS |
| ltv | 75 % [7500] | 0 % [0] |
| reserveFactor | 10 % [1000] | 25 % [2500] |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "borrowCap": {
        "from": 271000000,
        "to": 180000000
      },
      "ltv": {
        "from": 6300,
        "to": 0
      },
      "supplyCap": {
        "from": 338000000,
        "to": 200000000
      }
    },
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "borrowCap": {
        "from": 360000000,
        "to": 144000000
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      },
      "supplyCap": {
        "from": 800000000,
        "to": 160000000
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c3": {
          "previousValue": "0x100000000000000000000003e802faf0800015752a0003e8851229fe1e781d4c",
          "newValue": "0x100000000000000000000003e800989680000895440009c4851229fe1e780000"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c4": {
          "previousValue": "0x00000000000a682b9e4fa0131371b7aa0000000003590ca8bb3a3bad7263f200",
          "newValue": "0x000000000008ac25724f77ecb8747eb60000000003590cc762a6008457e9e373"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c5": {
          "previousValue": "0x00000000002f26137ac4610baf46b7910000000003816b116f535370639dddb8",
          "newValue": "0x00000000002f2613ae8bdcabace80d540000000003816ba2dae14b8086a95a52"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550c6": {
          "previousValue": "0x00000000000000000000230069303cd700000000000000000000000000000000",
          "newValue": "0x0000000000000000000023006930422f00000000000000000000000000000000"
        },
        "0x4ef18721e98712b47bd659171158f093c47a5bb2c0ced3ed1c21e431251550cb": {
          "previousValue": "0x0000000000242c4adf91e086f285b53e0000000000000027adafae870b57a7e9",
          "newValue": "0x0000000000242c4adf91e086f285b53e0000000000000027dcbf2135a837fa32"
        },
        "0x5e14560e314427eb9d0c466a6058089f672317c8e26719a770a709c3f2481e48": {
          "previousValue": "0x100000000000000000000007d00142578800102721c009c4a51229041e14189c",
          "newValue": "0x100000000000000000000007d000bebc20000aba950009c4a51229041e140000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86577": {
          "previousValue": "0x006930422e000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006930422e000000000003000000000000000000000000000000000000000000"
        },
        "0xd6209e3e3321d5ffded79c758ae1554dd2f9916af03cb81a843ed73242b86578": {
          "previousValue": "0x000000000000000000093a80000000000000695e66af00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000695e66af0000000000006930422f"
        }
      }
    }
  }
}
```