## Reserve changes

### Reserves altered

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x736bF902680e68989886e9807CD7Db4B3E015d3C](https://etherscan.io/address/0x736bF902680e68989886e9807CD7Db4B3E015d3C) | [0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA](https://etherscan.io/address/0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA) |


## Emodes changed

### EMode: ETH correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93.5 % | 93.5 % |
| eMode.liquidationThreshold (unchanged) | 95.5 % | 95.5 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH | WETH |
| eMode.collateralBitmap (unchanged) | wstETH, WETH | wstETH, WETH |


### EMode: LRT Stablecoins main(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT Stablecoins main | LRT Stablecoins main |
| eMode.ltv (unchanged) | 75 % | 75 % |
| eMode.liquidationThreshold (unchanged) | 78 % | 78 % |
| eMode.liquidationBonus (unchanged) | 7.5 % | 7.5 % |
| eMode.borrowableBitmap (unchanged) | USDS | USDS |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


### EMode: LRT wstETH main(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LRT wstETH main | LRT wstETH main |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | ezETH | ezETH |


## Raw diff

```json
{
  "reserves": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "oracle": {
        "from": "0x736bF902680e68989886e9807CD7Db4B3E015d3C",
        "to": "0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA"
      }
    }
  }
}
```