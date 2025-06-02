## Emodes changed

### EMode: wstETH/WETH(id: 1)



### EMode: LRT Stablecoins main(id: 2)



### EMode: LRT wstETH main(id: 3)



### EMode: sUSDe Stablecoins(id: 4)



### EMode: rsETH LST main(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | rsETH LST main | rsETH LST main |
| eMode.ltv | 92.5 % | 93 % |
| eMode.liquidationThreshold | 94.5 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | wstETH | wstETH |
| eMode.collateralBitmap (unchanged) | rsETH | rsETH |


### EMode: rsETH/Stablecoins(id: 6)



## Raw diff

```json
{
  "eModes": {
    "5": {
      "liquidationThreshold": {
        "from": 9450,
        "to": 9500
      },
      "ltv": {
        "from": 9250,
        "to": 9300
      }
    }
  },
  "raw": {
    "0x4e033931ad43597d96d6bcc25c280717730b58b1": {
      "label": "AaveV3EthereumLido.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000080277424ea2422",
          "newValue": "0x00000000000000000000000000000000000000000000000000802774251c2454"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c",
          "newValue": "0x7273455448204c5354206d61696e00000000000000000000000000000000001c"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x60c4bd52853516a4ad3e3dbefa5ca3d5b5f891da2433d0d3a1077c90dd29981d": {
          "previousValue": "0x00683db0aa000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00683db0aa000000000003000000000000000000000000000000000000000000"
        },
        "0x60c4bd52853516a4ad3e3dbefa5ca3d5b5f891da2433d0d3a1077c90dd29981e": {
          "previousValue": "0x000000000000000000093a80000000000000686bd52b00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000686bd52b000000000000683db0ab"
        }
      }
    }
  }
}
```