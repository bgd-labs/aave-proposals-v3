## Reserve changes

### Reserves altered

#### WETH.e ([0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB](https://snowscan.xyz/address/0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647](https://snowscan.xyz/address/0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647) | [0x3dED180433c1cb0B0697eD2e85cE598414DaCE58](https://snowscan.xyz/address/0x3dED180433c1cb0B0697eD2e85cE598414DaCE58) |
| variableRateSlope1 | 7 % | 2.7 % |
| interestRate | ![before](/.assets/f26fe824cd646f2ec0b6b12317a7bbb670179a6f.svg) | ![after](/.assets/30a46e1d7b3edcf3e05ed39c2b802da3dfb394d4.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "interestRateStrategy": {
        "from": "0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      }
    }
  },
  "strategies": {
    "0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB": {
      "address": {
        "from": "0x6724e923E4bb58fCdF7CEe7A5E7bBb47b99C2647",
        "to": "0x3dED180433c1cb0B0697eD2e85cE598414DaCE58"
      },
      "variableRateSlope1": {
        "from": "70000000000000000000000000",
        "to": "27000000000000000000000000"
      }
    }
  }
}
```