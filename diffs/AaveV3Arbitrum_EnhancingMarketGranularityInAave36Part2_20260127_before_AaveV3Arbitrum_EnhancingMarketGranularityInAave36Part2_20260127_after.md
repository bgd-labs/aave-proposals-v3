## Reserve changes

### Reserve altered

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://arbiscan.io/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### weETH ([0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe](https://arbiscan.io/address/0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### rsETH ([0x4186BFC76E2E237523CBC30FD220FE055156b41F](https://arbiscan.io/address/0x4186BFC76E2E237523CBC30FD220FE055156b41F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### wstETH ([0x5979D7b546E38E414F7E9822514be443A4800529](https://arbiscan.io/address/0x5979D7b546E38E414F7E9822514be443A4800529))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### tBTC ([0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40](https://arbiscan.io/address/0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40))

| description | value before | value after |
| --- | --- | --- |
| ltv | 73 % [7300] | 0 % [0] |


#### ARB ([0x912CE59144191C1204E64559FE8253a0e49E6548](https://arbiscan.io/address/0x912CE59144191C1204E64559FE8253a0e49E6548))

| description | value before | value after |
| --- | --- | --- |
| ltv | 58 % [5800] | 0 % [0] |
| borrowingEnabled | true | false |


#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### rETH ([0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8](https://arbiscan.io/address/0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### USDC ([0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8](https://arbiscan.io/address/0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| borrowingEnabled | true | false |


#### AAVE ([0xba5DdD1f9d7F570dc94a51479a000E3BCE967196](https://arbiscan.io/address/0xba5DdD1f9d7F570dc94a51479a000E3BCE967196))

| description | value before | value after |
| --- | --- | --- |
| ltv | 66 % [6600] | 0 % [0] |


#### LINK ([0xf97f4df75117a78c1A5a0DBb814Af92458539FB4](https://arbiscan.io/address/0xf97f4df75117a78c1A5a0DBb814Af92458539FB4))

| description | value before | value after |
| --- | --- | --- |
| ltv | 66 % [6600] | 0 % [0] |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: ETH correlated(id: 2)



### EMode: ezETH/wstETH/WETH ETH Correlated(id: 3)



### EMode: ezETH Stablecoins(id: 4)



### EMode: rsETH/wstETH/WETH ETH Correlated(id: 5)



### EMode: rsETH/Stablecoins(id: 6)



### EMode: wstETH/WETH ETH Correlated(id: 7)



### EMode: AAVE__USDC_USDT(id: 8)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | AAVE__USDC_USDT |
| eMode.ltv | - | 66 % |
| eMode.liquidationThreshold | - | 73 % |
| eMode.liquidationBonus | - | 10 % |
| eMode.borrowableBitmap | - | USD₮0, USDC |
| eMode.collateralBitmap | - | AAVE |


### EMode: ARB__USDC_USDT(id: 9)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ARB__USDC_USDT |
| eMode.ltv | - | 58 % |
| eMode.liquidationThreshold | - | 63 % |
| eMode.liquidationBonus | - | 10 % |
| eMode.borrowableBitmap | - | USD₮0, USDC |
| eMode.collateralBitmap | - | ARB |


### EMode: tBTC__USDC_USDT(id: 10)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | tBTC__USDC_USDT |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USD₮0, USDC |
| eMode.collateralBitmap | - | tBTC |


## Raw diff

```json
{
  "eModes": {
    "8": {
      "from": null,
      "to": {
        "borrowableBitmap": "4128",
        "collateralBitmap": "64",
        "eModeCategory": 8,
        "label": "AAVE__USDC_USDT",
        "liquidationBonus": 11000,
        "liquidationThreshold": 7300,
        "ltv": 6600
      }
    },
    "9": {
      "from": null,
      "to": {
        "borrowableBitmap": "4128",
        "collateralBitmap": "16384",
        "eModeCategory": 9,
        "label": "ARB__USDC_USDT",
        "liquidationBonus": 11000,
        "liquidationThreshold": 6300,
        "ltv": 5800
      }
    },
    "10": {
      "from": null,
      "to": {
        "borrowableBitmap": "4128",
        "collateralBitmap": "524288",
        "eModeCategory": 10,
        "label": "tBTC__USDC_USDT",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
      }
    }
  },
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x4186BFC76E2E237523CBC30FD220FE055156b41F": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0x5979D7b546E38E414F7E9822514be443A4800529": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40": {
      "ltv": {
        "from": 7300,
        "to": 0
      }
    },
    "0x912CE59144191C1204E64559FE8253a0e49E6548": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 5800,
        "to": 0
      }
    },
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0xba5DdD1f9d7F570dc94a51479a000E3BCE967196": {
      "ltv": {
        "from": 6600,
        "to": 0
      }
    },
    "0xf97f4df75117a78c1A5a0DBb814Af92458539FB4": {
      "ltv": {
        "from": 6600,
        "to": 0
      }
    }
  },
  "raw": {
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Arbitrum.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0759a6732214d7158205bec68b5a7f67b7fdcbd877069dbbd0160859418a56f1": {
          "previousValue": "0x100000000000000000000203e8000010d880000006a401f4851229e01edc1d4c",
          "newValue": "0x100000000000000000000203e8000010d880000006a401f4811229e01edc1d4c"
        },
        "0x0ba91ba94fb3ecb5bcc13103bfda08c6666915f98f5b84b9d9a7d68f4cad7a82": {
          "previousValue": "0x100000000000000000000003e800000e678000000000000081122af81c8419c8",
          "newValue": "0x100000000000000000000003e800000e678000000000000081122af81c840000"
        },
        "0x2859d83f3ac0b6030c43a15461b481b294a95afa24590070b4c0e64400b1f9bb": {
          "previousValue": "0x100000000000000000000003e800030d40000000000107d085122af81d4c19c8",
          "newValue": "0x100000000000000000000003e800030d40000000000107d085122af81d4c0000"
        },
        "0x2fb1ad43c3875564c9e17e163f725f9a9a0608795fdc720b7ce5631c6c97e9a5": {
          "previousValue": "0x100000000000000000000003e800000003200000001907d0811229fe1e781c84",
          "newValue": "0x100000000000000000000003e800000003200000001907d0811229fe1e780000"
        },
        "0x36ce690a3e41633995fb479a7fd89cf51578df5d336828d9f194d6be37a2ee39": {
          "previousValue": "0x100000000000000000000003e800000064000000000105dc851229fe1ce81af4",
          "newValue": "0x100000000000000000000003e800000064000000000105dc811229fe1ce81af4"
        },
        "0x4f0da5bca7ea3ed2a5fd7fbf6d310bc05d68502cf438424218eeef530670c853": {
          "previousValue": "0x100000000000000000000203e800001d8a80000000011194851229fe1e141d4c",
          "newValue": "0x100000000000000000000203e800001d8a80000000011194811229fe1e141d4c"
        },
        "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e84": {
          "previousValue": "0x1000000000000000000000000000000000100000000113888512000000000000",
          "newValue": "0x1000000000000000000000000000000000100000000113888112000000000000"
        },
        "0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2": {
          "previousValue": "0x100000000000000000000003e800000a41000000000105dc811229fe000a0005",
          "newValue": "0x100000000000000000000003e800000a41000000000105dc811229fe000a0000"
        },
        "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa167": {
          "previousValue": "0x100000000000000000000103e80004352600002c67301388a50629041e781d4c",
          "newValue": "0x100000000000000000000103e80004352600002c67301388a10629041e780000"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000008000029fe1d4c1c20"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x744254435f5f555344435f55534454000000000000000000000000000000001e"
        },
        "0xb6395f9c432dd8cece69c29d0bafa901e98160153dacb5e1d5fb45e8d47ba1d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001020"
        },
        "0xced4e33c332c88844af6910ceeedbb601b7d918fc4928995418b5dbaa5c0d7f3": {
          "previousValue": "0x100000000000000000000003e800609b72000000000107d085122af8189c16a8",
          "newValue": "0x100000000000000000000003e800609b72000000000107d081122af8189c0000"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481917": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000000402af81c8419c8"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481918": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x414156455f5f555344435f55534454000000000000000000000000000000001e"
        },
        "0xe1eef7f3dc95a7682cb02e33f0d6a7c6e59cd5f4d1f5d7b4e6308bb610481919": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001020"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49b": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000040002af8189c16a8"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4152425f5f555344435f5553445400000000000000000000000000000000001c"
        },
        "0xe6576186fab02514991562c0b55059c5b708dacefbb0b209be6f33d8dcdcb49d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000001020"
        },
        "0xef66773292b31b85b823946b8a102222c47696e9ab09e204141cbd3b223241ce": {
          "previousValue": "0x100000000000000000000003e8000015f9000000000107d0811229fe000a0005",
          "newValue": "0x100000000000000000000003e8000015f9000000000107d0811229fe000a0000"
        }
      }
    },
    "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
      "label": "GovernanceV3Arbitrum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc2": {
          "previousValue": "0x00697804d8000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00697804d8000000000003000000000000000000000000000000000000000000"
        },
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc3": {
          "previousValue": "0x000000000000000000093a8000000000000069a6295900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a62959000000000000697804d9"
        }
      }
    }
  }
}
```