## Reserve changes

### Reserve altered

#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 106,435.1469 LUSD [106435146991153500610108] | 92,218.4613 LUSD [92218461394279151682364] |
| virtualBalance | 106,434.9878 LUSD [106434987881929276913954] | 92,218.3022 LUSD [92218302285054927986210] |


#### USDC ([0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8](https://arbiscan.io/address/0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 523,273.5575 USDC [523273557554] | 470,941.9823 USDC [470941982303] |
| virtualBalance | 523,161.0279 USDC [523161027996] | 470,829.4527 USDC [470829452745] |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | DAI, USDC, USDT, EURS, USDC | DAI, USDC, USDT, EURS, USDC |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, EURS, USDC | DAI, USDC, USDT, EURS, USDC |


### EMode: ETH correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH, wstETH, weETH | WETH, wstETH, weETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, weETH | WETH, wstETH, weETH |


## Raw diff

```json
{
  "reserves": {
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "aTokenUnderlyingBalance": {
        "from": "106435146991153500610108",
        "to": "92218461394279151682364"
      },
      "virtualBalance": {
        "from": "106434987881929276913954",
        "to": "92218302285054927986210"
      }
    },
    "0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8": {
      "aTokenUnderlyingBalance": {
        "from": "523273557554",
        "to": "470941982303"
      },
      "virtualBalance": {
        "from": "523161027996",
        "to": "470829452745"
      }
    }
  }
}
```