## Reserve changes

### Reserve altered

#### Cake ([0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82](https://bscscan.com/address/0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wstETH ([0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C](https://bscscan.com/address/0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### FDUSD ([0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409](https://bscscan.com/address/0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 0 % [0] |
| borrowingEnabled | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7000,
        "to": 0
      }
    }
  },
  "raw": {
    "0x6807dc923806fe8fd134338eabca509979a7e0cb": {
      "label": "AaveV3BNB.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x4f7e401a3bd0628317467a9b48b7a242cbced3635594d81f505845155d278cdc": {
          "previousValue": "0x100000000000000000000003e800000000100000000105dc851229fe1d4c1c20",
          "newValue": "0x100000000000000000000003e800000000100000000105dc811229fe1d4c1c20"
        },
        "0x5d54c6410275cc5a5b440259b3bdba59addb097a220aaccc7a447ece2a2b45b3": {
          "previousValue": "0x10014dc93800000000000003e8000124f8000000000107d085122af817d40000",
          "newValue": "0x10014dc93800000000000003e8000124f8000000000107d081122af817d40000"
        },
        "0x736fd0af6a08a2b2749fa3064a0b73eac95be3d9ec3b096778dfebe1892b0329": {
          "previousValue": "0x100000000000000000000003e8000b71b00000a4cb8007d0a51229041d4c1b58",
          "newValue": "0x100000000000000000000003e8000b71b00000a4cb8007d0a11229041d4c0000"
        }
      }
    },
    "0xe5ef2dd06755a97e975f7e282f828224f2c3e627": {
      "label": "GovernanceV3BNB.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x2bb318060b44525c3d947c00393e6d416e9d457a7e83b67b8daab0973739b0fa": {
          "previousValue": "0x00698c59c5000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00698c59c5000000000003000000000000000000000000000000000000000000"
        },
        "0x2bb318060b44525c3d947c00393e6d416e9d457a7e83b67b8daab0973739b0fb": {
          "previousValue": "0x000000000000000000093a8000000000000069ba7e4600000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069ba7e46000000000000698c59c6"
        }
      }
    }
  }
}
```