## Reserve changes

### Reserve altered

#### ZK ([0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E](https://era.zksync.network//address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### WETH ([0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91](https://era.zksync.network//address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wstETH ([0x703b52F2b28fEbcB60E1372858AF5b18849FE867](https://era.zksync.network//address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867))

| description | value before | value after |
| --- | --- | --- |
| ltv | 71 % [7100] | 0 % [0] |
| borrowingEnabled | true | false |


#### sUSDe ([0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8](https://era.zksync.network//address/0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % [6500] | 0 % [0] |


#### wrsETH ([0xd4169E045bcF9a86cC00101225d9ED61D2F51af2](https://era.zksync.network//address/0xd4169E045bcF9a86cC00101225d9ED61D2F51af2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x703b52F2b28fEbcB60E1372858AF5b18849FE867": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 7100,
        "to": 0
      }
    },
    "0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8": {
      "ltv": {
        "from": 6500,
        "to": 0
      }
    },
    "0xd4169E045bcF9a86cC00101225d9ED61D2F51af2": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    }
  },
  "raw": {
    "0x2e79349c3f5e4751e87b966812c9e65e805996f1": {
      "label": "GovernanceV3ZkSync.PAYLOADS_CONTROLLER",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x9f4e12e393433b9749089d7660b578840ae05c9423ce1aefceb0c80c340a21c6": {
          "previousValue": "0x0069644443000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069644443000000000003000000000000000000000000000000000000000000"
        },
        "0x9f4e12e393433b9749089d7660b578840ae05c9423ce1aefceb0c80c340a21c7": {
          "previousValue": "0x000000000000000000093a80000000000000699268c400000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000699268c400000000000069644444"
        }
      }
    },
    "0x78e30497a3c7527d953c6b1e3541b021a98ac43c": {
      "label": "AaveV3ZkSync.POOL",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x1c3a3d2a4df728190844161beade417d6fb2d58213cc5fc888aa5646275f5af1": {
          "previousValue": "0x100000000000000000000103e80000007d00000000c801f4851229cc1db01bbc",
          "newValue": "0x100000000000000000000103e80000007d00000000c801f4811229cc1db00000"
        },
        "0x368739792e5d3e8d39a0b48906860940b391a277b6646bf51d971d2058c5675e": {
          "previousValue": "0x100000000000000000000003e80000000c80000000011194811229fe1d4c1c52",
          "newValue": "0x100000000000000000000003e80000000c80000000011194811229fe1d4c1c52"
        },
        "0xaab9473d3c2d823ad831e02d9c613808f1256c8d227ca0ebdfd0d67e251a0560": {
          "previousValue": "0x10003d090000000000000007d000773594000000000107d085122af811940000",
          "newValue": "0x10003d090000000000000007d000773594000000000107d081122af811940000"
        },
        "0xad39ffe4e896465fb71f607021cc246af1c1c6e37e175cd4c95126e4510625f4": {
          "previousValue": "0x10002625a000000000000003e8000030d4000000000107d081122a621d4c1964",
          "newValue": "0x10002625a000000000000003e8000030d4000000000107d081122a621d4c0000"
        },
        "0xbab4eff7783aa82368f9f225078df58ba76d9300d9fab7eb66ee012b397fb5b3": {
          "previousValue": "0x100000000000000000000103e8000000bb8000000a8c05dc851229681e781d4c",
          "newValue": "0x100000000000000000000103e8000000bb8000000a8c05dc811229681e781d4c"
        },
        "0xe4bda0fe8d1522b6c18f7123896520f05aaa4c4a8917913b5f71611470ee9d30": {
          "previousValue": "0x100000000000000000000003e80000002bc00000000103e8811229fe000a0005",
          "newValue": "0x100000000000000000000003e80000002bc00000000103e8811229fe000a0000"
        }
      }
    }
  }
}
```