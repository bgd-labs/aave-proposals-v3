## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH__ETHx_wstETH_ETHx(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | rsETH LST main | rsETH__ETHx_wstETH_ETHx |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap | wstETH, ETHx | WETH, wstETH, ETHx |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: LBTC_WBTC(id: 4)



### EMode: LBTC_cbBTC(id: 5)



### EMode: LBTC_tBTC(id: 6)



### EMode: eBTC/WBTC(id: 7)



### EMode: PT-sUSDe Stablecoins Jul 2025(id: 8)



### EMode: PT-eUSDe Stablecoins May 2025(id: 9)



### EMode: PT-USDe Stablecoins July 2025(id: 10)



### EMode: USDe Stablecoin(id: 11)



### EMode: PT-USDe USDe July 2025(id: 12)



### EMode: PT-eUSDe Stablecoins August 2025(id: 13)



### EMode: PT-eUSDe USDe August 2025(id: 14)



### EMode: eUSDe_Stablecoin(id: 15)



### EMode: FBTC/WBTC(id: 16)



### EMode: PT-sUSDe Stablecoins September 2025(id: 17)



### EMode: PT-sUSDe USDe September 2025(id: 18)



### EMode: PT-USDe Stablecoins September 2025(id: 19)



### EMode: PT-USDe USDe September 2025(id: 20)



### EMode: tETH/Stablecoins(id: 21)



### EMode: ezETH/wstETH(id: 22)



### EMode: ezETH/Stablecoins(id: 23)



### EMode: PT-sUSDe Stablecoins Nov 2025(id: 24)



### EMode: PT-sUSDe USDe Nov 2025(id: 25)



### EMode: weETH/wstETH ETH Correlated(id: 26)



### EMode: PT-USDe Stablecoins Nov 2025(id: 27)



### EMode: PT-USDe USDe Nov 2025(id: 28)



### EMode: PTUSDe5FEB/Stablecoins(id: 29)



### EMode: PTUSDe5FEB/USDe(id: 30)



### EMode: PTsUSDe5FEB/Stablecoins(id: 31)



### EMode: PTsUSDe5FEB/USDe(id: 32)



### EMode: syrupUSDT Stablecoins(id: 33)



## Raw diff

```json
{
  "eModes": {
    "3": {
      "borrowableBitmap": {
        "from": "2147483650",
        "to": "2147483651"
      },
      "label": {
        "from": "rsETH LST main",
        "to": "rsETH__ETHx_wstETH_ETHx"
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3155": {
          "previousValue": "0x00000000000000000000000000000000000000000010000000002774251c2454",
          "newValue": "0x00000000000000000000000000000000000000000010000000002774251c2454"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3156": {
          "previousValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c",
          "newValue": "0x72734554485f5f455448785f7773744554485f4554487800000000000000002e"
        },
        "0x81d0999fde243adcc41b7fa1be5cea14f789e3a6065b815ac58f4bc0838c3157": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000080000002",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000080000003"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xb01818f3e9f0631d183410281d3672cfa0e4d82ad4d20b2f4def7db946608191": {
          "previousValue": "0x00695e7812000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00695e7812000000000003000000000000000000000000000000000000000000"
        },
        "0xb01818f3e9f0631d183410281d3672cfa0e4d82ad4d20b2f4def7db946608192": {
          "previousValue": "0x000000000000000000093a80000000000000698c9c9300000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000698c9c93000000000000695e7813"
        }
      }
    }
  }
}
```