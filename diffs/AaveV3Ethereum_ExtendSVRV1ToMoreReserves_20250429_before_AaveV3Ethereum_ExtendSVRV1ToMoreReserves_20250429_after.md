## Reserve changes

### Reserve altered

#### WBTC ([0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x230E0321Cf38F09e247e50Afc7801EA2351fe56F](https://etherscan.io/address/0x230E0321Cf38F09e247e50Afc7801EA2351fe56F) | [0xDaa4B74C6bAc4e25188e64ebc68DB5050b690cAc](https://etherscan.io/address/0xDaa4B74C6bAc4e25188e64ebc68DB5050b690cAc) |
| oracleDescription | null | wBTC/BTC/USD |
| oracleLatestAnswer | 95299.90648669 | 95372.45893366 |


#### eBTC ([0x657e8C867D8B37dCC18fA4Caead9C45EB088C642](https://etherscan.io/address/0x657e8C867D8B37dCC18fA4Caead9C45EB088C642))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x95a85D0d2f3115702d813549a80040387738A430](https://etherscan.io/address/0x95a85D0d2f3115702d813549a80040387738A430) | [0x577C217cB5b1691A500D48aA7F69346409cFd668](https://etherscan.io/address/0x577C217cB5b1691A500D48aA7F69346409cFd668) |
| oracleLatestAnswer | 95334.05323788 | 95406.631681 |


#### cbBTC ([0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf](https://etherscan.io/address/0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c](https://etherscan.io/address/0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c) | [0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A](https://etherscan.io/address/0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A) |
| oracleLatestAnswer | 95334.05323788 | 95406.631681 |


## Raw diff

```json
{
  "reserves": {
    "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599": {
      "oracle": {
        "from": "0x230E0321Cf38F09e247e50Afc7801EA2351fe56F",
        "to": "0xDaa4B74C6bAc4e25188e64ebc68DB5050b690cAc"
      },
      "oracleLatestAnswer": {
        "from": "9529990648669",
        "to": "9537245893366"
      },
      "oracleDescription": {
        "from": null,
        "to": "wBTC/BTC/USD"
      }
    },
    "0x657e8C867D8B37dCC18fA4Caead9C45EB088C642": {
      "oracle": {
        "from": "0x95a85D0d2f3115702d813549a80040387738A430",
        "to": "0x577C217cB5b1691A500D48aA7F69346409cFd668"
      },
      "oracleLatestAnswer": {
        "from": "9533405323788",
        "to": "9540663168100"
      }
    },
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "oracle": {
        "from": "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c",
        "to": "0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A"
      },
      "oracleLatestAnswer": {
        "from": "9533405323788",
        "to": "9540663168100"
      }
    }
  },
  "raw": {
    "0x54586be62e3c3580375ae3723c145253060ca0c2": {
      "label": "AaveV3Ethereum.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x1df6378d90dbe801fca9d47d5375a5a229ffa4eb34516b72a9e9ff9483681050": {
          "previousValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        },
        "0xd3e4f25aaf2a33c02a6679e805658e410a92450da2dfd14fa956d40c26cc3b62": {
          "previousValue": "0x00000000000000000000000095a85d0d2f3115702d813549a80040387738a430",
          "newValue": "0x000000000000000000000000577c217cb5b1691a500d48aa7f69346409cfd668"
        },
        "0xf0b998666205e50af945dcd5198861491334a6162cc24264d9a801634ee07ec8": {
          "previousValue": "0x000000000000000000000000230e0321cf38f09e247e50afc7801ea2351fe56f",
          "newValue": "0x000000000000000000000000daa4b74c6bac4e25188e64ebc68db5050b690cac"
        }
      }
    },
    "0x8b493f416f5f7933cc146b1899c069f2361cad60": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1fbc299623e491ef606f8696f7181eea324289a5bd4dfdd74623a3ab157a14df": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000095a85d0d2f3115702d813549a80040387738a430"
        },
        "0x292c1cbcd8fcde54e8ba0732ed4e92022ba7ccc86bf9c562e47c88a765f35ad1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000230e0321cf38f09e247e50afc7801ea2351fe56f"
        },
        "0x3459054d09ae8631455b798b2b5d106e17bb4e68a39d2d2a935f5f1b7253988b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000daa4b74c6bac4e25188e64ebc68db5050b690cac"
        },
        "0x7d5204dd648f3f1aff95b0476d155dca041e031ce9fb2b8dcb0e5b4a9c2502c8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000f4030086522a5beea4988f8ca5b36dbc97bee88c"
        },
        "0xe37b025715e738345c89c9dca322948a28a7ca157c1a381efc3e07e578df8366": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000577c217cb5b1691a500d48aa7f69346409cfd668"
        },
        "0xea8a828f131f1937da0a3d826cebd3ca867369c850bc764097e012a683813059": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000b41e773f507f7a7ea890b1afb7d2b660c30c8b0a"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x57c0d0964870c24387de1cb96a1c0d1e031544394130654a48994b8a35b62a81": {
          "previousValue": "0x0068113096000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068113096000000000003000000000000000000000000000000000000000000"
        },
        "0x57c0d0964870c24387de1cb96a1c0d1e031544394130654a48994b8a35b62a82": {
          "previousValue": "0x000000000000000000093a80000000000000683f551700000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000683f551700000000000068113097"
        }
      }
    }
  }
}
```