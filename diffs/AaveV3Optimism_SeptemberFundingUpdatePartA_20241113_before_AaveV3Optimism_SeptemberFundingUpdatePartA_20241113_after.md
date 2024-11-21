## Reserve changes

### Reserve altered

#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 546,549.4039 USDC [546549403932] | 500,025.5539 USDC [500025553970] |
| virtualBalance | 546,472.3570 USDC [546472357070] | 499,948.5071 USDC [499948507108] |


#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 50,745.9305 LUSD [50745930580778611947683] | 47,655.2558 LUSD [47655255883422205911590] |
| virtualBalance | 50,745.9305 LUSD [50745930580778611947683] | 47,655.2558 LUSD [47655255883422205911590] |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | DAI, USDC, USDT, sUSD, USDC | DAI, USDC, USDT, sUSD, USDC |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, sUSD, USDC | DAI, USDC, USDT, sUSD, USDC |


### EMode: ETH correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH, wstETH, rETH | WETH, wstETH, rETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH, rETH | WETH, wstETH, rETH |


## Raw diff

```json
{
  "reserves": {
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "aTokenUnderlyingBalance": {
        "from": "546549403932",
        "to": "500025553970"
      },
      "virtualBalance": {
        "from": "546472357070",
        "to": "499948507108"
      }
    },
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "aTokenUnderlyingBalance": {
        "from": "50745930580778611947683",
        "to": "47655255883422205911590"
      },
      "virtualBalance": {
        "from": "50745930580778611947683",
        "to": "47655255883422205911590"
      }
    }
  }
}
```