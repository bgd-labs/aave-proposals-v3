## Reserve changes

### Reserve altered

#### USDC ([0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.094 | 1.094 |
| variableBorrowIndex | 1.138 | 1.138 |
| currentLiquidityRate | 16.778 % | 17.399 % |
| currentVariableBorrowRate | 24.785 % | 25.691 % |


#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.01 | 1.01 |
| variableBorrowIndex | 1.043 | 1.043 |
| currentLiquidityRate | 0.473 % | 0.472 % |
| currentVariableBorrowRate | 2.096 % | 2.095 % |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.086 | 1.086 |
| variableBorrowIndex | 1.127 | 1.127 |
| currentLiquidityRate | 5.861 % | 5.811 % |
| currentVariableBorrowRate | 8.863 % | 8.826 % |


#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| liquidityIndex | 1.111 | 1.111 |
| variableBorrowIndex | 1.148 | 1.148 |
| currentLiquidityRate | 9.316 % | 8.267 % |
| currentVariableBorrowRate | 11.662 % | 10.346 % |


## Raw diff

```json
{
  "reserves": {
    "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174": {
      "currentLiquidityRate": {
        "from": "167777431629089775326864348",
        "to": "173990871363647271170288967"
      },
      "currentVariableBorrowRate": {
        "from": "247849733719127000113515928",
        "to": "256910235930476033053339664"
      },
      "liquidityIndex": {
        "from": "1094314631001983416170783397",
        "to": "1094314654289819309581219574"
      },
      "variableBorrowIndex": {
        "from": "1137851112530156186630713217",
        "to": "1137851148300843474463012221"
      }
    },
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "currentLiquidityRate": {
        "from": "4730436269028159432768788",
        "to": "4724526042216584926620028"
      },
      "currentVariableBorrowRate": {
        "from": "20955102303851472349790675",
        "to": "20946111428677677992097233"
      },
      "liquidityIndex": {
        "from": "1010361123708703701615131819",
        "to": "1010361178874844023926218441"
      },
      "variableBorrowIndex": {
        "from": "1043224995389068909767068672",
        "to": "1043225247715414903408129593"
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "currentLiquidityRate": {
        "from": "58605690790677348388818059",
        "to": "58112946183586556754702945"
      },
      "currentVariableBorrowRate": {
        "from": "88634828332642643332151287",
        "to": "88259605815122235165723064"
      },
      "liquidityIndex": {
        "from": "1085731295835795387743768764",
        "to": "1085731324083526757517893710"
      },
      "variableBorrowIndex": {
        "from": "1126598209430110751073584403",
        "to": "1126598253759821876052094919"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "currentLiquidityRate": {
        "from": "93164676975655879438190604",
        "to": "82673687895149355712306667"
      },
      "currentVariableBorrowRate": {
        "from": "116615480764054634829470430",
        "to": "103464010654762537742186753"
      },
      "liquidityIndex": {
        "from": "1111232419492207810087028311",
        "to": "1111232472017631151978488813"
      },
      "variableBorrowIndex": {
        "from": "1147913361833630483882513733",
        "to": "1147913429750663603260581924"
      }
    }
  }
}
```