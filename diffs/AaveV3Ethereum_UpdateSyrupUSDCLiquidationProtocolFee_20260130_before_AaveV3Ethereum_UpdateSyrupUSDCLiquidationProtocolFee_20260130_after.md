## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH__ETH_wstETH_ETHx(id: 3)



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



### EMode: PT_USDe_7MAY2026__Stablecoins(id: 34)



### EMode: PT_USDe_7MAY2026__USDe(id: 35)



### EMode: PT_sUSDe_7MAY2026__Stablecoins(id: 36)



### EMode: PT_sUSDe_7MAY2026__USDe(id: 37)



### EMode: PT_srUSDe_2APR2026_sUSDe__USDT_USDe_USDC(id: 38)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC | PT_srUSDe_2APR2026_sUSDe__USDT_USDe_USDC |
| eMode.ltv (unchanged) | 89.5 % | 89.5 % |
| eMode.liquidationThreshold (unchanged) | 91.5 % | 91.5 % |
| eMode.liquidationBonus (unchanged) | 4.5 % | 4.5 % |
| eMode.borrowableBitmap (unchanged) | USDC, USDT, USDe | USDC, USDT, USDe |
| eMode.collateralBitmap (unchanged) | sUSDe, PT-srUSDe-2APR2026 | sUSDe, PT-srUSDe-2APR2026 |


### EMode: PT_srUSDe_2APR2026_sUSDe__USDe(id: 39)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | PT_srUSDe_1APR2026_sUSDe__USDe | PT_srUSDe_2APR2026_sUSDe__USDe |
| eMode.ltv (unchanged) | 91.2 % | 91.2 % |
| eMode.liquidationThreshold (unchanged) | 93.2 % | 93.2 % |
| eMode.liquidationBonus (unchanged) | 2.6 % | 2.6 % |
| eMode.borrowableBitmap (unchanged) | USDe | USDe |
| eMode.collateralBitmap (unchanged) | sUSDe, PT-srUSDe-2APR2026 | sUSDe, PT-srUSDe-2APR2026 |


## Raw diff

```json
{
  "eModes": {
    "38": {
      "label": {
        "from": "PT_srUSDe_1APR2026_sUSDe__USDT_USDe_USDC",
        "to": "PT_srUSDe_2APR2026_sUSDe__USDT_USDe_USDC"
      }
    },
    "39": {
      "label": {
        "from": "PT_srUSDe_1APR2026_sUSDe__USDe",
        "to": "PT_srUSDe_2APR2026_sUSDe__USDe"
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
        "0x21211c22bab1e82beffe41364244e814bccce99119fc5b075c3982302cb042a0": {
          "previousValue": "0x50545f7372555344655f31415052323032365f73555344655f5f555344545f55",
          "newValue": "0x50545f7372555344655f32415052323032365f73555344655f5f555344545f55"
        },
        "0x21211c22bab1e82beffe41364244e814bccce99119fc5b075c3982302cb042a1": {
          "previousValue": "0x5344655f55534443000000000000000000000000000000000000000000000000",
          "newValue": "0x5344655f55534443000000000000000000000000000000000000000000000000"
        },
        "0x95523e2aaf0261491aab353f3c5bf6ca15923b0c692d360f21ef703a84734c01": {
          "previousValue": "0x000000000000000000000000000000000000400000010000000028d223be22f6",
          "newValue": "0x000000000000000000000000000000000000400000010000000028d223be22f6"
        },
        "0x95523e2aaf0261491aab353f3c5bf6ca15923b0c692d360f21ef703a84734c02": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000051",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000051"
        },
        "0xcc4f1f1446f3ec7599ba69fd606d797ed01857ae28ed6ec85eeaee46b97caa5f": {
          "previousValue": "0x00000000000000000000000000000000000040000001000000002814246823a0",
          "newValue": "0x00000000000000000000000000000000000040000001000000002814246823a0"
        },
        "0xcc4f1f1446f3ec7599ba69fd606d797ed01857ae28ed6ec85eeaee46b97caa60": {
          "previousValue": "0x50545f7372555344655f31415052323032365f73555344655f5f55534465003c",
          "newValue": "0x50545f7372555344655f32415052323032365f73555344655f5f55534465003c"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x62d3caefc27072d8a29831635245f4b528ba9b3356b77b4a38e93725f0197aa0": {
          "previousValue": "0x0069828736000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0069828736000000000003000000000000000000000000000000000000000000"
        },
        "0x62d3caefc27072d8a29831635245f4b528ba9b3356b77b4a38e93725f0197aa1": {
          "previousValue": "0x000000000000000000093a8000000000000069b0abb700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069b0abb700000000000069828737"
        }
      }
    }
  }
}
```