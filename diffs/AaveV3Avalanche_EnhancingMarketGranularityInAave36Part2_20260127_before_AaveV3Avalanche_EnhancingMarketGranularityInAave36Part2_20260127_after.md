## Reserve changes

### Reserve altered

#### LINK.e ([0x5947BB275c521040051D82396192181b413227A3](https://snowscan.xyz/address/0x5947BB275c521040051D82396192181b413227A3))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 45,000 LINK.e | 1 LINK.e |
| ltv | 66 % [6600] | 0 % [0] |
| borrowingEnabled | true | false |


#### AAVE.e ([0x63a72806098Bd3D9520cC43356dD78afe5D386D9](https://snowscan.xyz/address/0x63a72806098Bd3D9520cC43356dD78afe5D386D9))

| description | value before | value after |
| --- | --- | --- |
| ltv | 63 % [6300] | 0 % [0] |


#### wrsETH ([0x7bFd4CA2a6Cf3A3fDDd645D10B323031afe47FF0](https://snowscan.xyz/address/0x7bFd4CA2a6Cf3A3fDDd645D10B323031afe47FF0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 0.05 % [5] | 0 % [0] |


#### EURC ([0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD](https://snowscan.xyz/address/0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % [7500] | 0 % [0] |


## Emodes changed

### EMode: Stablecoins(id: 1)



### EMode: AVAX correlated(id: 2)



### EMode: USDe/Stablecoin(id: 3)



### EMode: sUSDe/Stablecoin(id: 4)



### EMode: wrsETH/ETH(id: 5)



### EMode: EURC__USDC_USDT(id: 6)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | EURC__USDC_USDT |
| eMode.ltv | - | 75 % |
| eMode.liquidationThreshold | - | 78 % |
| eMode.liquidationBonus | - | 5 % |
| eMode.borrowableBitmap | - | USDC, USDt |
| eMode.collateralBitmap | - | EURC |


## Raw diff

```json
{
  "eModes": {
    "6": {
      "from": null,
      "to": {
        "borrowableBitmap": "36",
        "collateralBitmap": "16384",
        "eModeCategory": 6,
        "label": "EURC__USDC_USDT",
        "liquidationBonus": 10500,
        "liquidationThreshold": 7800,
        "ltv": 7500
      }
    }
  },
  "reserves": {
    "0x5947BB275c521040051D82396192181b413227A3": {
      "borrowCap": {
        "from": 45000,
        "to": 1
      },
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "ltv": {
        "from": 6600,
        "to": 0
      }
    },
    "0x63a72806098Bd3D9520cC43356dD78afe5D386D9": {
      "ltv": {
        "from": 6300,
        "to": 0
      }
    },
    "0x7bFd4CA2a6Cf3A3fDDd645D10B323031afe47FF0": {
      "ltv": {
        "from": 5,
        "to": 0
      }
    },
    "0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD": {
      "ltv": {
        "from": 7500,
        "to": 0
      }
    }
  },
  "raw": {
    "0x1140cb7cafacc745771c2ea31e7b5c653c5d0b80": {
      "label": "GovernanceV3Avalanche.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x296cfac21069339fcd7b6795214eac09a46f358e68cba56520ec496c3c1f4ad5": {
          "previousValue": "0x00698c5973000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00698c5973000000000003000000000000000000000000000000000000000000"
        },
        "0x296cfac21069339fcd7b6795214eac09a46f358e68cba56520ec496c3c1f4ad6": {
          "previousValue": "0x000000000000000000093a8000000000000069ba7df400000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069ba7df4000000000000698c5974"
        }
      }
    },
    "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
      "label": "AaveV3Avalanche.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d6": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000400029041e781d4c"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d7": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x455552435f5f555344435f55534454000000000000000000000000000000001e"
        },
        "0x01290583d43e205f46f8d824d1236df318521e471f570a5b36fa1844856e40d8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000024"
        },
        "0x25a922d75e2aaab8592dc46a8370195c26f61c233dc944290b27aa0dbd9ef70b": {
          "previousValue": "0x100000000000000000000003e800006b6c000000afc807d0851229fe1bbc19c8",
          "newValue": "0x100000000000000000000003e800006b6c000000000107d0811229fe1bbc0000"
        },
        "0x2a7909caa58f2aafa4aa80a78d11afd8a031d07aa8b6f3706ecd1984b27d326f": {
          "previousValue": "0x100000000000000000000003e8000b71b00000aae60003e8850629041e781d4c",
          "newValue": "0x100000000000000000000003e8000b71b00000aae60003e8850629041e780000"
        },
        "0x2ef0af43460a7d17297e15c9980a774850f93f9db2b1c0c472493f417a9a533a": {
          "previousValue": "0x100000000000000000000003e8000001c200000000000000811229fe1b58189c",
          "newValue": "0x100000000000000000000003e8000001c200000000000000811229fe1b580000"
        },
        "0x6af900617289e2e9ed4b1e16072f0f9e1d4e9b41e80b95362ac4859a0c516a58": {
          "previousValue": "0x10005f5e1000000000000103e800000000100000000107d0811229041e140000",
          "newValue": "0x10005f5e1000000000000103e800000000100000000107d0811229041e140000"
        },
        "0xb812b08fc94f6751621c5f09eda8cff1b6d95c23621bb67471e4a584de3a2b6a": {
          "previousValue": "0x100000000000000000000003e80000061a80000000011194811229cc000a0005",
          "newValue": "0x100000000000000000000003e80000061a80000000011194811229cc000a0000"
        }
      }
    }
  }
}
```