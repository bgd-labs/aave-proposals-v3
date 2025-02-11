## Reserve changes

### Reserves altered

#### cbBTC ([0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf](https://etherscan.io/address/0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf))

| description | value before | value after |
| --- | --- | --- |
| optimalUsageRatio | 45 % | 80 % |
| interestRate | ![before](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) | ![after](https://dash.onaave.com/api/static?variableRateSlope1=40000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=800000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3040000000000000000000000000) |

## Emodes changed

### EMode: ETH correlated(id: 1)



### EMode: sUSDe Stablecoins(id: 2)



### EMode: rsETH LST main(id: 3)



### EMode: LBTC / WBTC(id: 4)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | LBTC / WBTC | LBTC / WBTC |
| eMode.ltv (unchanged) | 84 % | 84 % |
| eMode.liquidationThreshold (unchanged) | 86 % | 86 % |
| eMode.liquidationBonus (unchanged) | 3 % | 3 % |
| eMode.borrowableBitmap | WBTC | WBTC, cbBTC |
| eMode.collateralBitmap (unchanged) | LBTC | LBTC |


## Raw diff

```json
{
  "eModes": {
    "4": {
      "borrowableBitmap": {
        "from": "4",
        "to": "17179869188"
      }
    }
  },
  "strategies": {
    "0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf": {
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "800000000000000000000000000"
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354c": {
          "previousValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0",
          "newValue": "0x0000000000000000000000000000000000000000002000000000283c219820d0"
        },
        "0x533efb5c9f032d0e72b35f5d59b231dc7a9fb94625f73b3c45c394126326354e": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000004",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000400000004"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df8": {
          "previousValue": "0x00000000000031fffd663b2d6a03eede00000000033b45134258ade84fe27746",
          "newValue": "0x0000000000001c1fff4f1c504f38b7a700000000033b4513d081838bd6a329fe"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173df9": {
          "previousValue": "0x0000000000043ca2a2747988b91126eb00000000033c178eecfad3292d1c1c68",
          "newValue": "0x000000000002621b83c0d17b7c4d72c700000000033c179afbdf36bdec7a5d63"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dfa": {
          "previousValue": "0x00000000000000000000220067ab6d6f00000000000000000000000000000000",
          "newValue": "0x00000000000000000000220067ab72c700000000000000000000000000000000"
        },
        "0x89c297050f05308a1ebd800db358705332b6d10d9be0598b08aa6c1829173dff": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000047a85",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000048029"
        }
      }
    },
    "0x9ec6f08190dea04a54f8afc53db96134e5e3fdfb": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x1df6378d90dbe801fca9d47d5375a5a229ffa4eb34516b72a9e9ff9483681050": {
          "previousValue": "0x0000000000000000000000000000000000000000753000000190000000001194",
          "newValue": "0x0000000000000000000000000000000000000000753000000190000000001f40"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": null,
      "balanceDiff": null,
      "stateDiff": {
        "0x23bb3ede395a2a36ce5a71330f9b50700fb3bb6f8c34a5068b0a28319f2df48f": {
          "previousValue": "0x0067ab72c6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0067ab72c6000000000003000000000000000000000000000000000000000000"
        },
        "0x23bb3ede395a2a36ce5a71330f9b50700fb3bb6f8c34a5068b0a28319f2df490": {
          "previousValue": "0x000000000000000000093a8000000000000067d9974700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000067d9974700000000000067ab72c7"
        }
      }
    }
  }
}
```