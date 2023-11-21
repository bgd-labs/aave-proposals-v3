## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xCE5870016D3cFa4e1c71Fb7c7EE8Cef67712a7a3](https://polygonscan.com/address/0xCE5870016D3cFa4e1c71Fb7c7EE8Cef67712a7a3) | [0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E](https://polygonscan.com/address/0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/b7a99628770bb40a32e5073151026c58d6315660.svg) | ![after](/.assets/d0ce1d7b0f30792388a361ffa100ec476087d905.svg) |

#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x499e74993FFa39dd314782C4262a7443c31f8422](https://polygonscan.com/address/0x499e74993FFa39dd314782C4262a7443c31f8422) | [0x283Df7893eF10F729890017F57d76B8D78e18915](https://polygonscan.com/address/0x283Df7893eF10F729890017F57d76B8D78e18915) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/ace6978308d6eec66d8d065157ff2ad57060388d.svg) | ![after](/.assets/e4bd0b47b6f0a753cd3286f1a05fa61c8781f53c.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xAcBbD7E2e8C14DBdBB974B1Be2FB29f34C1E5048](https://polygonscan.com/address/0xAcBbD7E2e8C14DBdBB974B1Be2FB29f34C1E5048) | [0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39](https://polygonscan.com/address/0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39) |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/c067ea0ccdd4d6df420480855146164d81b3771d.svg) | ![after](/.assets/fed28c8fca229c5bb66e0ae2b4ce72db46b36da2.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "interestRateStrategy": {
        "from": "0xCE5870016D3cFa4e1c71Fb7c7EE8Cef67712a7a3",
        "to": "0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "interestRateStrategy": {
        "from": "0x499e74993FFa39dd314782C4262a7443c31f8422",
        "to": "0x283Df7893eF10F729890017F57d76B8D78e18915"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xAcBbD7E2e8C14DBdBB974B1Be2FB29f34C1E5048",
        "to": "0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39"
      }
    }
  },
  "strategies": {
    "0x283Df7893eF10F729890017F57d76B8D78e18915": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "290000000000000000000000000",
        "optimalUsageRatio": "710000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1050000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "1050000000000000000000000000"
      }
    },
    "0x8D6dA015e69A84644BFc7455F871bDe2A7Fedf39": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "480000000000000000000000000",
        "optimalUsageRatio": "520000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "2360000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "2360000000000000000000000000"
      }
    },
    "0xc7008Df6B900b41CD528ceb23283Cf4BBCd0ac6E": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "230000000000000000000000000",
        "optimalUsageRatio": "770000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1340000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "1340000000000000000000000000"
      }
    }
  }
}
```