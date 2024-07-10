## Reserve changes

### Reserve altered

#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1 | 1 |
| variableBorrowIndex | 1.005 | 1.005 |
| currentLiquidityRate | 0 % | 0 % |
| currentVariableBorrowRate | 0.072 % | 0.072 % |


#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.065 | 1.065 |
| variableBorrowIndex | 1.097 | 1.097 |
| currentLiquidityRate | 4.653 % | 4.692 % |
| currentVariableBorrowRate | 8.089 % | 8.123 % |


#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.074 | 1.074 |
| variableBorrowIndex | 1.103 | 1.103 |
| currentLiquidityRate | 6.054 % | 6.143 % |
| currentVariableBorrowRate | 8.887 % | 8.952 % |


#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.016 | 1.016 |
| variableBorrowIndex | 1.029 | 1.029 |
| currentLiquidityRate | 5.221 % | 5.255 % |
| currentVariableBorrowRate | 8.569 % | 8.597 % |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.027 | 1.027 |
| variableBorrowIndex | 1.045 | 1.045 |
| currentLiquidityRate | 3.147 % | 3.099 % |
| currentVariableBorrowRate | 4.106 % | 4.043 % |


#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.075 | 1.075 |
| variableBorrowIndex | 1.1 | 1.1 |
| currentLiquidityRate | 4.81 % | 4.816 % |
| currentVariableBorrowRate | 7.231 % | 7.235 % |


## Raw diff

```json
{
  "reserves": {
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "currentLiquidityRate": {
        "from": "2646542393167084676298",
        "to": "2646442306756572846325"
      },
      "currentVariableBorrowRate": {
        "from": "717360066729424410196749",
        "to": "717346502111466234777400"
      },
      "liquidityIndex": {
        "from": "1000465370020133583838594722",
        "to": "1000465370180329956871306471"
      },
      "variableBorrowIndex": {
        "from": "1005207693448329648786290575",
        "to": "1005207737076276344599119363"
      }
    },
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "currentLiquidityRate": {
        "from": "46534266873410566066400878",
        "to": "46917088926763715972583068"
      },
      "currentVariableBorrowRate": {
        "from": "80894259864797334414134344",
        "to": "81226323506152533227769691"
      },
      "liquidityIndex": {
        "from": "1065001425922298034706719919",
        "to": "1065099544564675798993963139"
      },
      "variableBorrowIndex": {
        "from": "1097096088198807480183330640",
        "to": "1097271809987298676759596099"
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "currentLiquidityRate": {
        "from": "60544618987759513098138887",
        "to": "61432708711476878770099133"
      },
      "currentVariableBorrowRate": {
        "from": "88865765150561321770473334",
        "to": "89515149588462456383068154"
      },
      "liquidityIndex": {
        "from": "1073732826599498265091147670",
        "to": "1073752467749968435045602809"
      },
      "variableBorrowIndex": {
        "from": "1102607884228762660432320146",
        "to": "1102637488648243450155744626"
      }
    },
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "currentLiquidityRate": {
        "from": "52212681681534777427917459",
        "to": "52553181209652003867614486"
      },
      "currentVariableBorrowRate": {
        "from": "85687854223721975962609311",
        "to": "85966802357696852070501390"
      },
      "liquidityIndex": {
        "from": "1015889880079133397697729205",
        "to": "1015903746168972944194997436"
      },
      "variableBorrowIndex": {
        "from": "1028892332619818233507027224",
        "to": "1028915380205491202682792264"
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "currentLiquidityRate": {
        "from": "31470295679277715938428603",
        "to": "30985441457385649578335093"
      },
      "currentVariableBorrowRate": {
        "from": "41057479649069311865386320",
        "to": "40428443504890284159313608"
      },
      "liquidityIndex": {
        "from": "1026558633295940611422609262",
        "to": "1026559592152900394984713369"
      },
      "variableBorrowIndex": {
        "from": "1045371833351583977417679864",
        "to": "1045373107243514710089709995"
      }
    },
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
      "currentLiquidityRate": {
        "from": "48102238616602322495891992",
        "to": "48156641811099471741202141"
      },
      "currentVariableBorrowRate": {
        "from": "72308396451980417184539729",
        "to": "72349274966394694747784442"
      },
      "liquidityIndex": {
        "from": "1075260274025387662225497114",
        "to": "1075261080958217693054379349"
      },
      "variableBorrowIndex": {
        "from": "1100402503891243657949312075",
        "to": "1100403745254941220127417541"
      }
    }
  }
}
```