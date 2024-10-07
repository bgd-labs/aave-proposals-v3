## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 9,959,119.1684 DAI [9959119168440593981367052] | 10,412,279.1136 DAI [10412279113680893868774808] |
| virtualBalance | 9,959,077.9501 DAI [9959077950161256517910498] | 10,412,237.8954 DAI [10412237895401556405318254] |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 170,416,398.0105 USDC [170416398010523] | 173,156,644.6678 USDC [173156644667898] |
| virtualBalance | 170,410,060.0852 USDC [170410060085249] | 173,150,306.7426 USDC [173150306742624] |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 125,525.8289 WETH [125525828903647493339324] | 125,645.1966 WETH [125645196632342373482070] |
| virtualBalance | 125,525.8224 WETH [125525822450101205809733] | 125,645.1901 WETH [125645190178796085952479] |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 279,591,839.3705 USDT [279591839370520] | 282,560,728.7530 USDT [282560728753066] |
| virtualBalance | 279,590,685.1563 USDT [279590685156308] | 282,559,574.5388 USDT [282559574538854] |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "aTokenUnderlyingBalance": {
        "from": "9959119168440593981367052",
        "to": "10412279113680893868774808"
      },
      "virtualBalance": {
        "from": "9959077950161256517910498",
        "to": "10412237895401556405318254"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "aTokenUnderlyingBalance": {
        "from": 170416398010523,
        "to": 173156644667898
      },
      "virtualBalance": {
        "from": 170410060085249,
        "to": 173150306742624
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "aTokenUnderlyingBalance": {
        "from": "125525828903647493339324",
        "to": "125645196632342373482070"
      },
      "virtualBalance": {
        "from": "125525822450101205809733",
        "to": "125645190178796085952479"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "aTokenUnderlyingBalance": {
        "from": 279591839370520,
        "to": 282560728753066
      },
      "virtualBalance": {
        "from": 279590685156308,
        "to": 282559574538854
      }
    }
  }
}
```