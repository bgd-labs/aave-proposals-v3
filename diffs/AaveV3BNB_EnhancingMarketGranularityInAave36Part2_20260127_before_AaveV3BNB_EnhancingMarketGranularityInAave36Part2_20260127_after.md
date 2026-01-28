## Reserve changes

### Reserve altered

#### wstETH ([0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C](https://bscscan.com/address/0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### WBNB ([0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c](https://bscscan.com/address/0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 14,000 WBNB | 1 WBNB |
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
    "0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c": {
      "borrowCap": {
        "from": 14000,
        "to": 1
      },
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
        "0x3507e57533f6850604e92e85c1eb4830b1ab953ac938081681df7985bc8fd889": {
          "previousValue": "0x100000000000000000000003e800002da780000036b007d085122af81d4c1b58",
          "newValue": "0x100000000000000000000003e800002da7800000000107d081122af81d4c1b58"
        },
        "0x4f7e401a3bd0628317467a9b48b7a242cbced3635594d81f505845155d278cdc": {
          "previousValue": "0x100000000000000000000003e800000000100000000105dc851229fe1d4c1c20",
          "newValue": "0x100000000000000000000003e800000000100000000105dc811229fe1d4c1c20"
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
          "previousValue": "0x0069780c81000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069780c81000000000003000000000000000000000000000000000000000000"
        },
        "0x2bb318060b44525c3d947c00393e6d416e9d457a7e83b67b8daab0973739b0fb": {
          "previousValue": "0x000000000000000000093a8000000000000069a6310200000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a6310200000000000069780c82"
        }
      }
    }
  }
}
```