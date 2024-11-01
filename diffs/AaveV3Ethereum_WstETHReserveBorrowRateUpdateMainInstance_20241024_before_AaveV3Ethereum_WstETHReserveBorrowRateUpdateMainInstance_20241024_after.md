## Reserve changes

### Reserves altered

#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| maxVariableBorrowRate | 84.75 % | 82 % |
| baseVariableBorrowRate | 0.25 % | 0 % |
| variableRateSlope1 | 4.5 % | 2 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=45000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=2500000000000000000000000&maxVariableBorrowRate=847500000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=20000000000000000000000000&variableRateSlope2=800000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=820000000000000000000000000) |

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
  "strategies": {
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "baseVariableBorrowRate": {
        "from": "2500000000000000000000000",
        "to": "0"
      },
      "maxVariableBorrowRate": {
        "from": "847500000000000000000000000",
        "to": "820000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "45000000000000000000000000",
        "to": "20000000000000000000000000"
      }
    }
  }
}
```