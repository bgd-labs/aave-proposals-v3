## Reserve changes

### Reserve altered

#### UNI ([0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984](https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 77 % | 74 % |


#### FXS ([0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0](https://etherscan.io/address/0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 35 % | 0 % |
| liquidationThreshold | 45 % | 42 % |


#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 77 % | 0 % |
| liquidationThreshold | 80 % | 77 % |
| reserveFactor | 10 % | 20 % |


#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % | 25 % |


#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % | 0 % |
| liquidationThreshold | 75 % | 72 % |
| reserveFactor | 10 % | 20 % |


#### STG ([0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6](https://etherscan.io/address/0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 35 % | 0 % |
| liquidationThreshold | 40 % | 37 % |


#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 62 % | 59 % |


#### KNC ([0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202](https://etherscan.io/address/0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 35 % | 0 % |
| liquidationThreshold | 40 % | 37 % |


## Raw diff

```json
{
  "reserves": {
    "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984": {
      "liquidationThreshold": {
        "from": 7700,
        "to": 7400
      }
    },
    "0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "liquidationThreshold": {
        "from": 4500,
        "to": 4200
      },
      "ltv": {
        "from": 3500,
        "to": 0
      }
    },
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7700
      },
      "ltv": {
        "from": 7700,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "reserveFactor": {
        "from": 1000,
        "to": 2500
      }
    },
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "liquidationThreshold": {
        "from": 7500,
        "to": 7200
      },
      "ltv": {
        "from": 7000,
        "to": 0
      },
      "reserveFactor": {
        "from": 1000,
        "to": 2000
      }
    },
    "0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "liquidationThreshold": {
        "from": 4000,
        "to": 3700
      },
      "ltv": {
        "from": 3500,
        "to": 0
      }
    },
    "0xba100000625a3754423978a60c9317c58a424e3D": {
      "liquidationThreshold": {
        "from": 6200,
        "to": 5900
      }
    },
    "0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "liquidationThreshold": {
        "from": 4000,
        "to": 3700
      },
      "ltv": {
        "from": 3500,
        "to": 0
      }
    }
  }
}
```