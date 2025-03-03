## Reserve changes

### Reserve altered

#### USDC ([0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359](https://polygonscan.com/address/0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 70 % [7000] |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0 % [0] | 70 % [7000] |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv | 93 % | 91.25 % |
| eMode.liquidationThreshold | 95 % | 94.25 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC |  |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC |


### EMode: MATIC correlated(id: 2)



### EMode: ETH correlated(id: 3)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "1171493",
        "to": "0"
      },
      "liquidationThreshold": {
        "from": 9500,
        "to": 9425
      },
      "ltv": {
        "from": 9300,
        "to": 9125
      }
    }
  },
  "reserves": {
    "0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359": {
      "ltv": {
        "from": 0,
        "to": 7000
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "ltv": {
        "from": 0,
        "to": 7000
      }
    }
  },
  "raw": {
    "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
      "label": "GovernanceV3Polygon.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Polygon.POOL",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0x8145edddf43f50276641b55bd3ad95944510021e": {
      "label": "AaveV3Polygon.POOL_CONFIGURATOR",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
      "label": "AaveV3Polygon.ACL_MANAGER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
      "label": "AaveV3Polygon.POOL_ADDRESSES_PROVIDER",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xb7467b66d86ce80cc258f28d266a18a51db7fac8": {
      "label": "AaveV3Polygon.POOL_IMPL",
      "balanceDiff": null,
      "stateDiff": {
        "0x436c14203ee76e79d5652d508249351bf2aad2332f57381e04c70b85c9582d7c": {
          "previousValue": "0x100000000000000000000103e8005f5e1000055d4a8007d0850629041e780000",
          "newValue": "0x100000000000000000000103e8005f5e1000055d4a8007d0850629041e781b58"
        },
        "0x7bdd64832954533ce1bb06477375d759a0b8390bd9a186c07915b18bf5315b0c": {
          "previousValue": "0x100000000000000000000103e80055d4a8000510ff4009c4a50629041e780000",
          "newValue": "0x100000000000000000000103e80055d4a8000510ff4009c4a50629041e781b58"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb0": {
          "previousValue": "0x000000000000000000000000000000000000000000000011e0252774251c2454",
          "newValue": "0x000000000000000000000000000000000000000000000011e025277424d123a5"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb1": {
          "previousValue": "0x537461626c65636f696e73000000000000000000000000000000000000000016",
          "newValue": "0x537461626c65636f696e73000000000000000000000000000000000000000016"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000011e025",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        }
      }
    },
    "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0xeaaacae94bbfc90c56bc9f09c078e38d09be79409287043ed56adc78213c2109": {
          "previousValue": "0x0067c229a8000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067c229a8000000000003000000000000000000000000000000000000000000"
        },
        "0xeaaacae94bbfc90c56bc9f09c078e38d09be79409287043ed56adc78213c210a": {
          "previousValue": "0x000000000000000000093a8000000000000067f04e2900000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067f04e2900000000000067c229a9"
        }
      }
    },
    "0xdf7d0e6454db638881302729f5ba99936eaab233": {
      "label": "AaveV2Polygon.POOL_ADMIN, AaveV3Polygon.ACL_ADMIN, GovernanceV3Polygon.EXECUTOR_LVL_1",
      "balanceDiff": null,
      "stateDiff": {}
    },
    "0xe5e48ad1f9d1a894188b483dcf91f4fad6aba43b": {
      "label": "AaveV3Polygon.POOL_CONFIGURATOR_IMPL",
      "balanceDiff": null,
      "stateDiff": {}
    }
  }
}
```