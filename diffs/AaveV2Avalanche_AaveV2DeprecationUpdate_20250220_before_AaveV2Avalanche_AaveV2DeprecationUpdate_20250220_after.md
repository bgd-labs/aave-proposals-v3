## Reserve changes

### Reserve altered

#### WETH.e ([0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB](https://snowtrace.io/address/0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### WBTC.e ([0x50b7545627a5162F82A992c33b87aDc75187B218](https://snowtrace.io/address/0x50b7545627a5162F82A992c33b87aDc75187B218))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 85 % [8500] | 99.99 % [9999] |
| borrowingEnabled | true | false |
| interestRateStrategy | [0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647](https://snowtrace.io/address/0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowtrace.io/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| baseVariableBorrowRate | 0 % | 20 % |
| variableRateSlope1 | 7 % | 0 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=undefined) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=0&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=200000000000000000000000000&maxVariableBorrowRate=undefined) |

#### WAVAX ([0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://snowtrace.io/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### USDT.e ([0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### DAI.e ([0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0x50b7545627a5162F82A992c33b87aDc75187B218": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "interestRateStrategy": {
        "from": "0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "reserveFactor": {
        "from": 8500,
        "to": 9999
      }
    },
    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xc7198437980c041c805A1EDcbA50c1Ce5db95118": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xd586E7F844cEa2F87f50152665BCbc2C279D8d70": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "strategies": {
    "0x50b7545627a5162F82A992c33b87aDc75187B218": {
      "address": {
        "from": "0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "200000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "0"
      }
    }
  }
}
```