## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb](https://polygonscan.com/address/0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb) | [0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb](https://polygonscan.com/address/0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb) |


#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb](https://polygonscan.com/address/0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb) | [0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb](https://polygonscan.com/address/0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb) |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xF86577E7d27Ed35b85A7645c58bAaA64453fe32B](https://polygonscan.com/address/0xF86577E7d27Ed35b85A7645c58bAaA64453fe32B) | [0xa1913Df228db08F02F3F3Dc0f397Af3A2d2f96A1](https://polygonscan.com/address/0xa1913Df228db08F02F3F3Dc0f397Af3A2d2f96A1) |


#### miMATIC ([0xa3Fa99A148fA48D14Ed51d610c367C61876997F1](https://polygonscan.com/address/0xa3Fa99A148fA48D14Ed51d610c367C61876997F1))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x4ae2Ab1af7e3b0092dbF3A4B20ec3de8fC834873](https://polygonscan.com/address/0x4ae2Ab1af7e3b0092dbF3A4B20ec3de8fC834873) | [0x1e2Ba4725c6847dC8304466c4eA25A872A7D43a8](https://polygonscan.com/address/0x1e2Ba4725c6847dC8304466c4eA25A872A7D43a8) |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0xaA574f4f6E124E77a7a1B5Ed91c8b407000A7730](https://polygonscan.com/address/0xaA574f4f6E124E77a7a1B5Ed91c8b407000A7730) | [0x01Aba1Fe7D72a3490bEef7CD0C09e1Ba2dD88D83](https://polygonscan.com/address/0x01Aba1Fe7D72a3490bEef7CD0C09e1Ba2dD88D83) |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "oracle": {
        "from": "0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb",
        "to": "0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb"
      }
    },
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "oracle": {
        "from": "0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb",
        "to": "0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "oracle": {
        "from": "0xF86577E7d27Ed35b85A7645c58bAaA64453fe32B",
        "to": "0xa1913Df228db08F02F3F3Dc0f397Af3A2d2f96A1"
      }
    },
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "oracle": {
        "from": "0x4ae2Ab1af7e3b0092dbF3A4B20ec3de8fC834873",
        "to": "0x1e2Ba4725c6847dC8304466c4eA25A872A7D43a8"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "oracle": {
        "from": "0xaA574f4f6E124E77a7a1B5Ed91c8b407000A7730",
        "to": "0x01Aba1Fe7D72a3490bEef7CD0C09e1Ba2dD88D83"
      }
    }
  },
  "raw": {
    "0x0229f777b0fab107f9591a41d5f02e4e98db6f2d": {
      "label": "AaveV2Polygon.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x8b2e538b61367ab6db116a167f81f6719b95ca851e61e8f6f696c68dfa6d6197": {
          "previousValue": "0x00000000000000000000000008edd9e1df3b0b8498864c60a2fd6cdb13148885",
          "newValue": "0x000000000000000000000000c368bab13a2b46d02c20c28aebab79bbe7e067aa"
        },
        "0xc618dfc57a3acb49a61f0a674c8ceab79d3bd365d6db55920808d8b91372dfbf": {
          "previousValue": "0x000000000000000000000000b611aa5e98112c7c3711ca3a5187dc025b83c8e4",
          "newValue": "0x000000000000000000000000eaa310d63670b8c36699ce53e3e926b23355f3df"
        },
        "0xd5112a050b4ee6e508ac6604a4b364d8ce770ce82d7a3a374f6625bb0a3ee8cf": {
          "previousValue": "0x000000000000000000000000f840c80932908ef206056df0882bc595e7150607",
          "newValue": "0x000000000000000000000000f44fee6877f2f1a0b84c8bc49ff4ec35df089ea0"
        }
      }
    },
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc2": {
          "previousValue": "0x0068246dbb000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068246dbb000000000003000000000000000000000000000000000000000000"
        },
        "0x004ef3f825c8849c73999f6e84fcb0332c1597fa3afbd85f7f1f35c7ac696bc3": {
          "previousValue": "0x000000000000000000093a800000000000006852923c00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006852923c00000000000068246dbc"
        }
      }
    },
    "0xb023e699f5a33916ea823a16485e259257ca8bd1": {
      "label": "AaveV3Polygon.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x055aec32800c1157d69820865326b61e91384dc9cf7d6e5d81cc0f17b3c39783": {
          "previousValue": "0x000000000000000000000000f86577e7d27ed35b85a7645c58baaa64453fe32b",
          "newValue": "0x000000000000000000000000a1913df228db08f02f3f3dc0f397af3a2d2f96a1"
        },
        "0x905324f6ac5b7ced7b5c02238633a89b1812b204b997b2d9662e7ee96782f059": {
          "previousValue": "0x00000000000000000000000017e33d122fc34c7ad8fbd4a1995dff9c8ae675eb",
          "newValue": "0x00000000000000000000000031ebeb03223aac82c8eb24c77624ea40f4d849fb"
        },
        "0xae02604fb37f9c24800df454b9c35a512bc615e51b1cb51c5f01fd34e5087042": {
          "previousValue": "0x00000000000000000000000017e33d122fc34c7ad8fbd4a1995dff9c8ae675eb",
          "newValue": "0x00000000000000000000000031ebeb03223aac82c8eb24c77624ea40f4d849fb"
        },
        "0xae871f1c0f24260bf16ce363697c574e479f5282cc4daf3a440f3994f778f49d": {
          "previousValue": "0x0000000000000000000000004ae2ab1af7e3b0092dbf3a4b20ec3de8fc834873",
          "newValue": "0x0000000000000000000000001e2ba4725c6847dc8304466c4ea25a872a7d43a8"
        },
        "0xfaad2634be2a92239146fcf31c9286389570ac13f367a3736a19ed2cf0ce788c": {
          "previousValue": "0x000000000000000000000000aa574f4f6e124e77a7a1b5ed91c8b407000a7730",
          "newValue": "0x00000000000000000000000001aba1fe7d72a3490beef7cd0c09e1ba2dd88d83"
        }
      }
    }
  }
}
```