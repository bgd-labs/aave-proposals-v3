## Reserve changes

### Reserve altered

#### WPOL ([0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 52,650,750.6758 WPOL [52650750675856200640974187] | 52,662,441.0177 WPOL [52662441017715394164705770] |
| virtualBalance | 52,650,750.6758 WPOL [52650750675856200640974187] | 52,662,441.0177 WPOL [52662441017715394164705770] |


#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 1,707,045.0579 USDC [1707045057954] | 1,619,562.8108 USDC [1619562810825] |
| virtualBalance | 1,706,866.8345 USDC [1706866834534] | 1,619,384.5874 USDC [1619384587405] |


#### LINK ([0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39](https://polygonscan.com/address/0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 760,821.4170 LINK [760821417069511886594222] | 760,826.7958 LINK [760826795837651869949477] |
| virtualBalance | 760,821.4105 LINK [760821410547668237659103] | 760,826.7893 LINK [760826789315808221014358] |


#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 15,758.8942 WETH [15758894219160674399387] | 15,763.4010 WETH [15763401070433413872477] |
| virtualBalance | 15,758.8942 WETH [15758894219160674399387] | 15,763.4010 WETH [15763401070433413872477] |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 796,729.9585 DAI [796729958523072652649220] | 1,043,554.5600 DAI [1043554560064100889468696] |
| virtualBalance | 796,569.0625 DAI [796569062545281907932762] | 1,043,393.6640 DAI [1043393664086310144752238] |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 3,912,929.3134 USDT [3912929313459] | 4,244,431.8572 USDT [4244431857297] |
| virtualBalance | 3,912,857.1847 USDT [3912857184739] | 4,244,359.7285 USDT [4244359728577] |


## Emodes changed

### EMode: Stablecoins(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | Stablecoins | Stablecoins |
| eMode.ltv (unchanged) | 93 % | 93 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC |
| eMode.collateralBitmap (unchanged) | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC | DAI, USDC, USDT, EURS, jEUR, EURA, miMATIC, USDC |


### EMode: MATIC correlated(id: 2)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | MATIC correlated | MATIC correlated |
| eMode.ltv (unchanged) | 92.5 % | 92.5 % |
| eMode.liquidationThreshold (unchanged) | 95 % | 95 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WPOL, stMATIC, MaticX | WPOL, stMATIC, MaticX |
| eMode.collateralBitmap (unchanged) | WPOL, stMATIC, MaticX | WPOL, stMATIC, MaticX |


### EMode: ETH correlated(id: 3)

| description | value before | value after |
| --- | --- | --- |
| eMode.label (unchanged) | ETH correlated | ETH correlated |
| eMode.ltv (unchanged) | 90 % | 90 % |
| eMode.liquidationThreshold (unchanged) | 93 % | 93 % |
| eMode.liquidationBonus (unchanged) | 1 % | 1 % |
| eMode.borrowableBitmap (unchanged) | WETH, wstETH | WETH, wstETH |
| eMode.collateralBitmap (unchanged) | WETH, wstETH | WETH, wstETH |


## Raw diff

```json
{
  "reserves": {
    "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270": {
      "aTokenUnderlyingBalance": {
        "from": "52650750675856200640974187",
        "to": "52662441017715394164705770"
      },
      "virtualBalance": {
        "from": "52650750675856200640974187",
        "to": "52662441017715394164705770"
      }
    },
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "aTokenUnderlyingBalance": {
        "from": "1707045057954",
        "to": "1619562810825"
      },
      "virtualBalance": {
        "from": "1706866834534",
        "to": "1619384587405"
      }
    },
    "0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39": {
      "aTokenUnderlyingBalance": {
        "from": "760821417069511886594222",
        "to": "760826795837651869949477"
      },
      "virtualBalance": {
        "from": "760821410547668237659103",
        "to": "760826789315808221014358"
      }
    },
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "aTokenUnderlyingBalance": {
        "from": "15758894219160674399387",
        "to": "15763401070433413872477"
      },
      "virtualBalance": {
        "from": "15758894219160674399387",
        "to": "15763401070433413872477"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "aTokenUnderlyingBalance": {
        "from": "796729958523072652649220",
        "to": "1043554560064100889468696"
      },
      "virtualBalance": {
        "from": "796569062545281907932762",
        "to": "1043393664086310144752238"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "aTokenUnderlyingBalance": {
        "from": "3912929313459",
        "to": "4244431857297"
      },
      "virtualBalance": {
        "from": "3912857184739",
        "to": "4244359728577"
      }
    }
  }
}
```