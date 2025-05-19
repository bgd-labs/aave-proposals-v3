## Reserve changes

### Reserve altered

#### LBTC ([0x8236a87084f8B84306f72007F36F2618A5634494](https://etherscan.io/address/0x8236a87084f8B84306f72007F36F2618A5634494))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### rsETH ([0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### osETH ([0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38](https://etherscan.io/address/0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx |


### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: PT-sUSDe Stablecoins Jul 2025(id: 8)



### EMode: PT-eUSDe Stablecoins May 2025(id: 9)



### EMode: USDe Stablecoin(id: 11)



## Raw diff

```json
{
  "eModes": {
    "1": {
      "borrowableBitmap": {
        "from": "2952790659",
        "to": "1"
      }
    }
  },
  "reserves": {
    "0x8236a87084f8B84306f72007F36F2618A5634494": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0aa88caa1bb30a042b74c9bc2dc685ff713c2f3c10e3ff1bc752f50479dcc4a2": {
          "previousValue": "0x100000000000000000000003e8000001644000000001138885082a621d4c1b58",
          "newValue": "0x100000000000000000000003e8000001644000000001138881082a621d4c1b58"
        },
        "0x1f90421f12d8e2ce282f76d42efa0c95b3551bd055d13a1de40c0e6b1e99c380": {
          "previousValue": "0x100000000000000000000103e800003f7a000000000105dc851229fe1d4c1c52",
          "newValue": "0x100000000000000000000103e800003f7a000000000105dc811229fe1d4c1c52"
        },
        "0x8e0cc0f1f0504b4cb44a23b328568106915b169e79003737a7b094503cdbeeb2": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000000b0000283",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000001"
        },
        "0xed45a05ce0954e645f11725167843283bb37c29952c0335b670d63d10fcad8ef": {
          "previousValue": "0x100000000000000000000003e800007530000000000105dc851229fe1d4c1c20",
          "newValue": "0x100000000000000000000003e800007530000000000105dc811229fe1d4c1c20"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x31f3c3c26b9f7b2a5e2a988f330d4f0e06c36e0dafa800031083080450670401": {
          "previousValue": "0x00682b2062000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682b2062000000000003000000000000000000000000000000000000000000"
        },
        "0x31f3c3c26b9f7b2a5e2a988f330d4f0e06c36e0dafa800031083080450670402": {
          "previousValue": "0x000000000000000000093a80000000000000685944e300000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000685944e3000000000000682b2063"
        }
      }
    }
  }
}
```