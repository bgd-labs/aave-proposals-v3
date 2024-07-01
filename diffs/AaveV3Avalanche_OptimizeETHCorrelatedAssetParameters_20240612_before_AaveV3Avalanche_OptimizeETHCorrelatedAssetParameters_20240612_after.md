## Reserve changes

### Reserves altered

#### WETH.e ([0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB](https://snowscan.xyz/address/0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x271f5f8325051f22caDa18FfedD4a805584a232A](https://snowscan.xyz/address/0x271f5f8325051f22caDa18FfedD4a805584a232A) | [0xd5CA18a70189309664e34FB8150799ff13722308](https://snowscan.xyz/address/0xd5CA18a70189309664e34FB8150799ff13722308) |
| variableRateSlope1 | 3.8 % | 2.7 % |
| baseStableBorrowRate | 6.8 % | 5.7 % |
| interestRate | ![before](/.assets/ccc572c1f8557ea58d4ab36b39c7b63825179d06.svg) | ![after](/.assets/a4877f5866751d4c748b2860e175e398fd8b0f20.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "interestRateStrategy": {
        "from": "0x271f5f8325051f22caDa18FfedD4a805584a232A",
        "to": "0xd5CA18a70189309664e34FB8150799ff13722308"
      }
    }
  },
  "strategies": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "address": {
        "from": "0x271f5f8325051f22caDa18FfedD4a805584a232A",
        "to": "0xd5CA18a70189309664e34FB8150799ff13722308"
      },
      "baseStableBorrowRate": {
        "from": "68000000000000000000000000",
        "to": "57000000000000000000000000"
      },
      "variableRateSlope1": {
        "from": "38000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```