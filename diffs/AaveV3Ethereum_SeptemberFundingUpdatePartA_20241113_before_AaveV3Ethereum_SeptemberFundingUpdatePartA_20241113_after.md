## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 12,815,520.1423 DAI [12815520142310148635171895] | 12,315,520.1423 DAI [12315520142310148635171895] |
| virtualBalance | 12,815,478.9240 DAI [12815478924030811171715341] | 12,315,478.9240 DAI [12315478924030811171715341] |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 132,811,898.4664 USDC [132811898466405] | 131,561,898.4664 USDC [131561898466405] |
| virtualBalance | 132,805,560.5411 USDC [132805560541131] | 131,555,560.5411 USDC [131555560541131] |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 136,087,964.4434 USDT [136087964443430] | 134,837,964.4434 USDT [134837964443430] |
| virtualBalance | 136,086,810.2292 USDT [136086810229218] | 134,836,810.2292 USDT [134836810229218] |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx | WETH, wstETH, cbETH, rETH, weETH, osETH, ETHx |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "aTokenUnderlyingBalance": {
        "from": "12815520142310148635171895",
        "to": "12315520142310148635171895"
      },
      "virtualBalance": {
        "from": "12815478924030811171715341",
        "to": "12315478924030811171715341"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "aTokenUnderlyingBalance": {
        "from": "132811898466405",
        "to": "131561898466405"
      },
      "virtualBalance": {
        "from": "132805560541131",
        "to": "131555560541131"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "aTokenUnderlyingBalance": {
        "from": "136087964443430",
        "to": "134837964443430"
      },
      "virtualBalance": {
        "from": "136086810229218",
        "to": "134836810229218"
      }
    }
  }
}
```