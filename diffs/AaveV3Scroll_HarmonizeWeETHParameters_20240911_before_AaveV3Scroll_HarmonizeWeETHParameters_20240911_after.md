## Reserve changes

### Reserves altered

#### weETH ([0x01f0a31698C4d065659b9bdC21B3610292a1c506](https://scrollscan.com/address/0x01f0a31698C4d065659b9bdC21B3610292a1c506))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 15 % [1500] | 45 % [4500] |
| optimalUsageRatio | 45 % | 30 % |
| maxVariableBorrowRate | 307 % | 308 % |
| baseVariableBorrowRate | 0 % | 1 % |
| interestRate | ![before](/.assets/8fa1be0a18750a60d1bf8c471ee14d962f51656a.svg) | ![after](/.assets/ba06e5f94338be2fe2b46141ae0af1531fe2e9ed.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x01f0a31698C4d065659b9bdC21B3610292a1c506": {
      "reserveFactor": {
        "from": 1500,
        "to": 4500
      }
    }
  },
  "strategies": {
    "0x01f0a31698C4d065659b9bdC21B3610292a1c506": {
      "baseVariableBorrowRate": {
        "from": "0",
        "to": "10000000000000000000000000"
      },
      "maxVariableBorrowRate": {
        "from": "3070000000000000000000000000",
        "to": "3080000000000000000000000000"
      },
      "optimalUsageRatio": {
        "from": "450000000000000000000000000",
        "to": "300000000000000000000000000"
      }
    }
  }
}
```