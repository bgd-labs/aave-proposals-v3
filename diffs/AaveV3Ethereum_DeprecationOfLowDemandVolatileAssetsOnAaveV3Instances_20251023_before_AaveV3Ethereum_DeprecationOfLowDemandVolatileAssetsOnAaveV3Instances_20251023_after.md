## Reserve changes

### Reserve altered

#### 1INCH ([0x111111111117dC0aa78b770fA6A738034120C302](https://etherscan.io/address/0x111111111117dC0aa78b770fA6A738034120C302))

| description | value before | value after |
| --- | --- | --- |
| ltv | 57 % [5700] | 0 % [0] |


#### UNI ([0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984](https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % [6500] | 0 % [0] |


#### LDO ([0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32](https://etherscan.io/address/0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32))

| description | value before | value after |
| --- | --- | --- |
| ltv | 40 % [4000] | 0 % [0] |


#### ENS ([0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72](https://etherscan.io/address/0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72))

| description | value before | value after |
| --- | --- | --- |
| ltv | 39 % [3900] | 0 % [0] |


#### CRV ([0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52))

| description | value before | value after |
| --- | --- | --- |
| ltv | 35 % [3500] | 0 % [0] |


#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| ltv | 57 % [5700] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x111111111117dC0aa78b770fA6A738034120C302": {
      "ltv": {
        "from": 5700,
        "to": 0
      }
    },
    "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984": {
      "ltv": {
        "from": 6500,
        "to": 0
      }
    },
    "0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32": {
      "ltv": {
        "from": 4000,
        "to": 0
      }
    },
    "0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72": {
      "ltv": {
        "from": 3900,
        "to": 0
      }
    },
    "0xD533a949740bb3306d119CC777fa900bA034cd52": {
      "ltv": {
        "from": 3500,
        "to": 0
      }
    },
    "0xba100000625a3754423978a60c9317c58a424e3D": {
      "ltv": {
        "from": 5700,
        "to": 0
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x5fe3c5c588b626d5a9cebe169e8cb576ea92298dc18cf4686c056d112b1eeec2": {
          "previousValue": "0x1000ee6b2800000000000003e80004c4b4000000000107d085122a9413880fa0",
          "newValue": "0x1000ee6b2800000000000003e80004c4b4000000000107d085122a9413880000"
        },
        "0x6073da802cfd57970e5c385150de92b75756eff0ea9d13effae07956cf21353a": {
          "previousValue": "0x10011490c800000000000003e800098968000000000107d085122a4e170c1644",
          "newValue": "0x10011490c800000000000003e800098968000000000107d085122a4e170c0000"
        },
        "0x7260d0353b66d7d275011cfa96cce988d9fbea0c355c88ff8fa2b523ba74a259": {
          "previousValue": "0x1006553f1000000000000003e80005b8d8000000000107d085122af81ce81964",
          "newValue": "0x1006553f1000000000000003e80005b8d8000000000107d085122af81ce80000"
        },
        "0x96a2cfdf9c0c5c0235e6e0938af959edeb6c20aa9f5f08b186fa02225ea33535": {
          "previousValue": "0x100070800000000000000003e800112a88000000000107d0851229fe1a2c1644",
          "newValue": "0x100070800000000000000003e800112a88000000000107d0851229fe1a2c0000"
        },
        "0xd76b69b0f7b1c04da356d786043ab33773b3ac2ca4b62d97fc88b41c43fd124f": {
          "previousValue": "0x10005f5e1000000000000003e80010736d00000000010dac85122a4e10040dac",
          "newValue": "0x10005f5e1000000000000003e80010736d00000000010dac85122a4e10040000"
        },
        "0xfc39a0dc3cc2d218b0a564e17dd6503d95d4724793595e7902e4d0141373ff14": {
          "previousValue": "0x100061800280000000000003e80000186a000000000107d085122a3013240f3c",
          "newValue": "0x100061800280000000000003e80000186a000000000107d085122a3013240000"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x6ac082d0dae0a32ca46deb4a24cad599947bdb193adc34198fe8054d27fd8c9d": {
          "previousValue": "0x0068fa72ee000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068fa72ee000000000003000000000000000000000000000000000000000000"
        },
        "0x6ac082d0dae0a32ca46deb4a24cad599947bdb193adc34198fe8054d27fd8c9e": {
          "previousValue": "0x000000000000000000093a800000000000006928976f00000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006928976f00000000000068fa72ef"
        }
      }
    }
  }
}
```