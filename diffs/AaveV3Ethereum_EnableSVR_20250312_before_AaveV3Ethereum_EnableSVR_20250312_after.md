## Reserve changes

### Reserve altered

#### tBTC ([0x18084fbA666a33d37592fA2633fD49a74DD93a88](https://etherscan.io/address/0x18084fbA666a33d37592fA2633fD49a74DD93a88))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) | [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) |
| oracleLatestAnswer | 82662.7618 | 82824.87 |


#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c](https://etherscan.io/address/0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c) | [0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183](https://etherscan.io/address/0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183) |
| oracleLatestAnswer | 13.0056 | 12.9983 |


#### AAVE ([0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9](https://etherscan.io/address/0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x547a514d5e3769680Ce22B2361c10Ea13619e8a9](https://etherscan.io/address/0x547a514d5e3769680Ce22B2361c10Ea13619e8a9) | [0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85](https://etherscan.io/address/0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85) |
| oracleLatestAnswer | 169.8599 | 170.1206 |


#### LBTC ([0x8236a87084f8B84306f72007F36F2618A5634494](https://etherscan.io/address/0x8236a87084f8B84306f72007F36F2618A5634494))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) | [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) |
| oracleLatestAnswer | 82662.7618 | 82824.87 |


## Raw diff

```json
{
  "reserves": {
    "0x18084fbA666a33d37592fA2633fD49a74DD93a88": {
      "oracle": {
        "from": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "to": "0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A"
      },
      "oracleLatestAnswer": {
        "from": "8266276180000",
        "to": "8282487000000"
      }
    },
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "oracle": {
        "from": "0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c",
        "to": "0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183"
      },
      "oracleLatestAnswer": {
        "from": "1300560000",
        "to": "1299830000"
      }
    },
    "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9": {
      "oracle": {
        "from": "0x547a514d5e3769680Ce22B2361c10Ea13619e8a9",
        "to": "0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85"
      },
      "oracleLatestAnswer": {
        "from": "16985990000",
        "to": "17012060000"
      }
    },
    "0x8236a87084f8B84306f72007F36F2618A5634494": {
      "oracle": {
        "from": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "to": "0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A"
      },
      "oracleLatestAnswer": {
        "from": "8266276180000",
        "to": "8282487000000"
      }
    }
  },
  "raw": {
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x0d822d63469ab72b7f00991445ce1436949c97775f8d0e44f498337ae450a252": {
          "previousValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        },
        "0x32feeefce75ce500b7e13282ca15382c6b3ea60fcece07987211390bdef2b0af": {
          "previousValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        },
        "0x7145bb02480b505fc02ccfdba07d3ba3a9d821606f0688263abedd0ac6e5bec5": {
          "previousValue": "0x000000000000000000000000547a514d5e3769680ce22b2361c10ea13619e8a9",
          "newValue": "0x000000000000000000000000f02c1e2a3b77c1cacc72f72b44f7d0a4c62e4a85"
        },
        "0x730d6fdf8f2d5e5e75a62ad49cc4d175b7750703aa72e452e1e22258c77079fb": {
          "previousValue": "0x0000000000000000000000002c1d072e956affc0d435cb7ac38ef18d24d9127c",
          "newValue": "0x000000000000000000000000c7e9b623ed51f033b32ae7f1282b1ad62c28c183"
        }
      }
    },
    "0x8b493f416f5f7933cc146b1899c069f2361cad60": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1a9803c4d7ba78027a36dac30b4c220d5ddf96cf88d69f62492c3dcc1ebd2947": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        },
        "0x44f27d1ed7e3dbc4c42ea1b3e4f90dd504d74a66ac560b950f647b0b2e756ab9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        },
        "0x698237dfa634d11da10159d70f72b31f9b252a79768d52db914572ce99f0c7b0": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000c7e9b623ed51f033b32ae7f1282b1ad62c28c183"
        },
        "0x9d5a8bd3c2286e55a8e91fbdca575acf743f7c7234e79feaf7fb7607da450096": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f02c1e2a3b77c1cacc72f72b44f7d0a4c62e4a85"
        },
        "0xa80852e0e925ac55bfae86386962c96e7e4b51db75d65b9850e7df493e986f83": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000547a514d5e3769680ce22b2361c10ea13619e8a9"
        },
        "0xb02aa09314ddb9ef8e4a8245dc03651bca545d696bb87fe2face858d508809d1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c"
        },
        "0xb0f6a387c3cc35caa784926ae31d026f503a00fd7c0730ce0e8c9b4bdcdbf579": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c"
        },
        "0xf521275bc127671174f9c4bab19091b46c0a61f91ea1d386a327c1b501baa44f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000002c1d072e956affc0d435cb7ac38ef18d24d9127c"
        }
      }
    },
    "0xc2aacf6553d20d1e9d78e365aaba8032af9c85b0": {
      "label": "AaveV3Ethereum.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {
        "0xa417905273ed58b61b06b339f84a1592e8c9feae3dcd42b6df432af13776b489": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x5930bb25cb489b555415b7efb12f9cb00a48defc0192276c8118358784264ff9": {
          "previousValue": "0x0067d29a86000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067d29a86000000000003000000000000000000000000000000000000000000"
        },
        "0x5930bb25cb489b555415b7efb12f9cb00a48defc0192276c8118358784264ffa": {
          "previousValue": "0x000000000000000000093a800000000000006800bf0700000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006800bf0700000000000067d29a87"
        }
      }
    }
  }
}
```