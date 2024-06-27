## Reserve changes

### Reserve altered

#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1 | 1 |
| variableBorrowIndex | 1.005 | 1.005 |
| currentLiquidityRate | 0 % | 0 % |
| currentVariableBorrowRate | 0.057 % | 0.057 % |


#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.062 | 1.062 |
| variableBorrowIndex | 1.092 | 1.092 |
| currentLiquidityRate | 4.44 % | 4.468 % |
| currentVariableBorrowRate | 7.902 % | 7.926 % |


#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.069 | 1.069 |
| variableBorrowIndex | 1.095 | 1.095 |
| currentLiquidityRate | 6.153 % | 6.598 % |
| currentVariableBorrowRate | 8.959 % | 9.556 % |


#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.013 | 1.013 |
| variableBorrowIndex | 1.024 | 1.024 |
| currentLiquidityRate | 3.766 % | 3.782 % |
| currentVariableBorrowRate | 7.277 % | 7.293 % |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.025 | 1.025 |
| variableBorrowIndex | 1.044 | 1.044 |
| currentLiquidityRate | 1.598 % | 1.598 % |
| currentVariableBorrowRate | 2.419 % | 2.419 % |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.071 | 1.071 |
| variableBorrowIndex | 1.094 | 1.094 |
| currentLiquidityRate | 6.981 % | 6.991 % |
| currentVariableBorrowRate | 8.711 % | 8.717 % |


## Raw diff

```json
{
  "reserves": {
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "currentLiquidityRate": {
        "from": "1659836261066362781114",
        "to": "1659771848727538564925"
      },
      "currentVariableBorrowRate": {
        "from": "568107331101960664527896",
        "to": "568096307883051393588673"
      },
      "liquidityIndex": {
        "from": "1000456730358550514148890742",
        "to": "1000456730364869366350858074"
      },
      "variableBorrowIndex": {
        "from": "1005159597889188179417501584",
        "to": "1005159600062089766557618647"
      }
    },
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "currentLiquidityRate": {
        "from": "44404243986499267693379515",
        "to": "44675428103549749758186909"
      },
      "currentVariableBorrowRate": {
        "from": "79021179506518754059720155",
        "to": "79262109971042806953451750"
      },
      "liquidityIndex": {
        "from": "1062142367939849038752272911",
        "to": "1062186139663888566715917250"
      },
      "variableBorrowIndex": {
        "from": "1091647828488811375393343412",
        "to": "1091727890856102919600249934"
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "currentLiquidityRate": {
        "from": "61528642026171560624376762",
        "to": "65977929622120857921989330"
      },
      "currentVariableBorrowRate": {
        "from": "89585015749800159814316154",
        "to": "95558602663561602969337406"
      },
      "liquidityIndex": {
        "from": "1068727738552886107465030384",
        "to": "1068727813618372921232610490"
      },
      "variableBorrowIndex": {
        "from": "1095081397071433792798832129",
        "to": "1095081509061033200231425660"
      }
    },
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "currentLiquidityRate": {
        "from": "37658427022051317998268121",
        "to": "37821451962118284767683553"
      },
      "currentVariableBorrowRate": {
        "from": "72771672373087363269004784",
        "to": "72929018107834715283211818"
      },
      "liquidityIndex": {
        "from": "1013158577557574282540504055",
        "to": "1013158693703566229929336300"
      },
      "variableBorrowIndex": {
        "from": "1023755522087214747405426120",
        "to": "1023755748876893923794970406"
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "currentLiquidityRate": {
        "from": "15984364844558912418292867",
        "to": "15982930816674802534341733"
      },
      "currentVariableBorrowRate": {
        "from": "24187778895661838866829677",
        "to": "24186693875152088877822707"
      },
      "liquidityIndex": {
        "from": "1025072860440363156846241433",
        "to": "1025072891614523342413945303"
      },
      "variableBorrowIndex": {
        "from": "1043613619868626386966916572",
        "to": "1043613667895064859245457310"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "currentLiquidityRate": {
        "from": "69808713792355388851002182",
        "to": "69914025175886059806790617"
      },
      "currentVariableBorrowRate": {
        "from": "87108574050331621094332972",
        "to": "87174254012273089531764499"
      },
      "liquidityIndex": {
        "from": "1070631312827591503033044740",
        "to": "1070634099913093650245488799"
      },
      "variableBorrowIndex": {
        "from": "1094239432556713565931573746",
        "to": "1094242987025339664598251283"
      }
    }
  }
}
```