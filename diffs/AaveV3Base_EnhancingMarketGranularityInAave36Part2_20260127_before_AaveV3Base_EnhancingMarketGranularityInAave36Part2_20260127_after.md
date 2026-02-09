## Reserve changes

### Reserve altered

#### weETH ([0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A](https://basescan.org/address/0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### tBTC ([0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b](https://basescan.org/address/0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b))

| description | value before | value after |
| --- | --- | --- |
| ltv | 73 % [7300] | 0 % [0] |
| borrowingEnabled | true | false |


#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://basescan.org/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### cbETH ([0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22](https://basescan.org/address/0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### EURC ([0x60a3E35Cc302bFA44Cb288Bc5a4F316Fdb1adb42](https://basescan.org/address/0x60a3E35Cc302bFA44Cb288Bc5a4F316Fdb1adb42))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


#### AAVE ([0x63706e401c06ac8513145b7687A14804d17f814b](https://basescan.org/address/0x63706e401c06ac8513145b7687A14804d17f814b))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % [6000] | 0 % [0] |


#### wrsETH ([0xEDfa23602D0EC14714057867A78d01e94176BEA0](https://basescan.org/address/0xEDfa23602D0EC14714057867A78d01e94176BEA0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### wstETH ([0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452](https://basescan.org/address/0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |
| borrowingEnabled | true | false |


#### LBTC ([0xecAc9C5F704e954931349Da37F60E39f515c11c1](https://basescan.org/address/0xecAc9C5F704e954931349Da37F60E39f515c11c1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 68 % [6800] | 0 % [0] |


## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: ezETH wstETH(id: 2)



### EMode: ezETH Stablecoins(id: 3)



### EMode: LBTC_cbBTC(id: 4)



### EMode: rsETH/wstETH(id: 5)



### EMode: rsETH/USDC(id: 6)



### EMode: weETH/WETH(id: 7)



### EMode: wstETH/WETH(id: 8)



### EMode: cbETH/WETH(id: 9)



### EMode: cbBTC Stablecoins(id: 10)



### EMode: SyrupUSDC__USDC_GHO(id: 11)



### EMode: AAVE__USDC_GHO(id: 12)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | AAVE__USDC_GHO |
| eMode.ltv | - | 63 % |
| eMode.liquidationThreshold | - | 70 % |
| eMode.liquidationBonus | - | 10 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | AAVE |


### EMode: EURC__USDC_GHO(id: 13)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | EURC__USDC_GHO |
| eMode.ltv | - | 75 % |
| eMode.liquidationThreshold | - | 78 % |
| eMode.liquidationBonus | - | 5 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | EURC |


### EMode: LBTC__USDC_GHO(id: 14)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | LBTC__USDC_GHO |
| eMode.ltv | - | 75 % |
| eMode.liquidationThreshold | - | 78 % |
| eMode.liquidationBonus | - | 5 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | LBTC |


### EMode: tBTC__USDC_GHO(id: 15)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | tBTC__USDC_GHO |
| eMode.ltv | - | 72 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDC, GHO |
| eMode.collateralBitmap | - | tBTC |


## Raw diff

```json
{
  "eModes": {
    "12": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "4096",
        "eModeCategory": 12,
        "label": "AAVE__USDC_GHO",
        "liquidationBonus": 11000,
        "liquidationThreshold": 7000,
        "ltv": 6300
      }
    },
    "13": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "2048",
        "eModeCategory": 13,
        "label": "EURC__USDC_GHO",
        "liquidationBonus": 10500,
        "liquidationThreshold": 7800,
        "ltv": 7500
      }
    },
    "14": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "1024",
        "eModeCategory": 14,
        "label": "LBTC__USDC_GHO",
        "liquidationBonus": 10500,
        "liquidationThreshold": 7800,
        "ltv": 7500
      }
    },
    "15": {
      "from": null,
      "to": {
        "borrowableBitmap": "272",
        "collateralBitmap": "8192",
        "eModeCategory": 15,
        "label": "tBTC__USDC_GHO",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7200
      }
    }
  },
  "reserves": {
    "0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7300,
        "to": 0
      }
    },
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x60a3E35Cc302bFA44Cb288Bc5a4F316Fdb1adb42": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0x63706e401c06ac8513145b7687A14804d17f814b": {
      "ltv": {
        "from": 6000,
        "to": 0
      }
    },
    "0xEDfa23602D0EC14714057867A78d01e94176BEA0": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7500,
        "to": 0
      }
    },
    "0xecAc9C5F704e954931349Da37F60E39f515c11c1": {
      "ltv": {
        "from": 6800,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66047": {
          "previousValue": "0x0069780a38000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069780a38000000000003000000000000000000000000000000000000000000"
        },
        "0x767e32fd18349f6756b14c9960d71c7fab8d03be981e4c9c8d4aa06a28b66048": {
          "previousValue": "0x000000000000000000093a8000000000000069a62eb900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069a62eb900000000000069780a39"
        }
      }
    },
    "0xa238dd80c259a72e81d7e4664a9801593f98d1c5": {
      "label": "AaveV3Base.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d6f": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000080029041e781d4c"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d70": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x455552435f5f555344435f47484f00000000000000000000000000000000001c"
        },
        "0x04e6a57294bb916b654e5f2a9be58b33bb23f83005593c07f959637b56d00d71": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x06511f122a6ecc4dc280e9f39df5119c2e43c998c438a2cdea36d46bbc885187": {
          "previousValue": "0x100000000000000000000103e80000249f00000000011194851229fe1e141d4c",
          "newValue": "0x100000000000000000000103e80000249f00000000011194811229fe1e141d4c"
        },
        "0x142b8024331e7a0999f0b47d24464879477fb31a681c25e930aab464ba948f9d": {
          "previousValue": "0x100000000000000000000003e800000006e000000001138881082a621c841a90",
          "newValue": "0x100000000000000000000003e800000006e000000001138881082a621c840000"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000000010002af81b58189c"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x414156455f5f555344435f47484f00000000000000000000000000000000001c"
        },
        "0x1aec1d7d90e7fdc8d0cb5cae39901fd57c1eb538af488d7215b10b8d307d84b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a1": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000040029041e781d4c"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a2": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x4c4254435f5f555344435f47484f00000000000000000000000000000000001c"
        },
        "0x2ab8cd8eab3e8c901115e793997bc427e1596b98dcca832d2eb3bc8b02d226a3": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x576d2086a3d5f0898768a114197adc4053263301f03ff1504528cd2771084b42": {
          "previousValue": "0x100000000000000000000003e800017c9d8000108e481388a50629041e781d4c",
          "newValue": "0x100000000000000000000003e800017c9d8000108e481388a10629041e780000"
        },
        "0x5f6aa73d31c2f4ef6adff1bc9136292ba6ec4a935a3394501b252da30ee66ef5": {
          "previousValue": "0x100000000000000000000003e800222b8f00015fb71003e8850629041e781d4c",
          "newValue": "0x100000000000000000000003e800222b8f00015fb71003e8850629041e780000"
        },
        "0x70f3bb6a392ddd8da0d065901d06be3531eaee419994175e61f7027f7f10e693": {
          "previousValue": "0x100000000000000000000003e800000753000000000107d0811229fe000a0005",
          "newValue": "0x100000000000000000000003e800000753000000000107d0811229fe000a0000"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000200029fe1d4c1c20"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x744254435f5f555344435f47484f00000000000000000000000000000000001c"
        },
        "0x769cad6e4f69fb39d4bdc2ee07759d8d4955411817e0dd7fe8899ea55308f3d9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000110"
        },
        "0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2": {
          "previousValue": "0x100000000000000000000003e8000001c2000000000105dc811229fe000a0005",
          "newValue": "0x100000000000000000000003e8000001c2000000000105dc811229fe000a0000"
        },
        "0x96beb4f9742350119893c92f4298c1cc379c4d82d0886b6326a3a5b4c22e68a7": {
          "previousValue": "0x100000000000000000000003e800000008200000000d07d0851229fe1e781c84",
          "newValue": "0x100000000000000000000003e800000008200000000d07d0811229fe1e780000"
        },
        "0xaa500ffa00a5d6e86c03b52ec24b3e4017fc1ff3799a0fec773e15c518a611d7": {
          "previousValue": "0x100000000000000000000103e800000271000000025605dc851229fe1edc1d4c",
          "newValue": "0x100000000000000000000103e800000271000000025605dc811229fe1edc1d4c"
        },
        "0xb2fb8b7096735d73c6c4d5b1a418a8cdf1a6f7c6702f0c322b17a7e19c120ebe": {
          "previousValue": "0x100000000000000000000103e800000a028000000d4801f4851229681edc1d4c",
          "newValue": "0x100000000000000000000103e800000a028000000d4801f4811229681edc1d4c"
        },
        "0xd70f257193c79f7683dc422d26d444f336579483b3e679e2693fd67db2791a97": {
          "previousValue": "0x100000000000000000000003e800000753000000000107d081122af819641770",
          "newValue": "0x100000000000000000000003e800000753000000000107d081122af819640000"
        }
      }
    }
  }
}
```