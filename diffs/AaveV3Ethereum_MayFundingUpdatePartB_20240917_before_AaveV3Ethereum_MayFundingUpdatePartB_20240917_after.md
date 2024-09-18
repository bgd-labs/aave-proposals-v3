## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 13,649,815.5772 DAI [13649815577259411745389414] | 14,040,760.6551 DAI [14040760655143533374641264] |
| virtualBalance | 13,649,774.3589 DAI [13649774358980074281932860] | 14,040,719.4368 DAI [14040719436864195911184710] |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 272,426,038.2653 USDC [272426038265314] | 274,812,378.9594 USDC [274812378959433] |
| virtualBalance | 272,419,700.3400 USDC [272419700340040] | 274,806,041.0341 USDC [274806041034159] |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 120,653.9358 WETH [120653935880624504124464] | 120,738.1078 WETH [120738107841077234026293] |
| virtualBalance | 120,653.9294 WETH [120653929427078216594873] | 120,738.1013 WETH [120738101387530946496702] |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 473,454,976.3677 USDT [473454976367726] | 475,459,464.4127 USDT [475459464412762] |
| virtualBalance | 473,453,822.1535 USDT [473453822153514] | 475,458,310.1985 USDT [475458310198550] |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "aTokenUnderlyingBalance": {
        "from": "13649815577259411745389414",
        "to": "14040760655143533374641264"
      },
      "virtualBalance": {
        "from": "13649774358980074281932860",
        "to": "14040719436864195911184710"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "aTokenUnderlyingBalance": {
        "from": 272426038265314,
        "to": 274812378959433
      },
      "virtualBalance": {
        "from": 272419700340040,
        "to": 274806041034159
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "aTokenUnderlyingBalance": {
        "from": "120653935880624504124464",
        "to": "120738107841077234026293"
      },
      "virtualBalance": {
        "from": "120653929427078216594873",
        "to": "120738101387530946496702"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "aTokenUnderlyingBalance": {
        "from": 473454976367726,
        "to": 475459464412762
      },
      "virtualBalance": {
        "from": 473453822153514,
        "to": 475458310198550
      }
    }
  }
}
```