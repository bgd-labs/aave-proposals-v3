## Hub Spoke Config Changes

### sUSDe (assetId: 2) on Hub [0x06002e9c4412CB7814a791eA3666D905871E536A](https://etherscan.io/address/0x06002e9c4412CB7814a791eA3666D905871E536A) / Spoke [0xba1B3D55D249692b669A164024A838309B7508AF](https://etherscan.io/address/0xba1B3D55D249692b669A164024A838309B7508AF)

| description | value before | value after |
| --- | --- | --- |
| addCap | 6,000,000 (6e6) sUSDe | 8,000,000 (8e6) sUSDe |

### WETH (assetId: 0) on Hub [0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931](https://etherscan.io/address/0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931) / Spoke [0x973a023A77420ba610f06b3858aD991Df6d85A08](https://etherscan.io/address/0x973a023A77420ba610f06b3858aD991Df6d85A08)

| description | value before | value after |
| --- | --- | --- |
| addCap | 3,200 (3.2e3) WETH | 5,000 (5e3) WETH |

### WETH (assetId: 0) on Hub [0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9](https://etherscan.io/address/0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9) / Spoke [0x94e7A5dCbE816e498b89aB752661904E2F56c485](https://etherscan.io/address/0x94e7A5dCbE816e498b89aB752661904E2F56c485)

| description | value before | value after |
| --- | --- | --- |
| addCap | 24,000 (2.4e4) WETH | 30,000 (3e4) WETH |
| drawCap | 2,050 (2.05e3) WETH | 2,600 (2.6e3) WETH |

### cbBTC (assetId: 12) on Hub [0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9](https://etherscan.io/address/0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9) / Spoke [0x94e7A5dCbE816e498b89aB752661904E2F56c485](https://etherscan.io/address/0x94e7A5dCbE816e498b89aB752661904E2F56c485)

| description | value before | value after |
| --- | --- | --- |
| addCap | 220 cbBTC | 400 cbBTC |
| drawCap | 14 cbBTC | 26 cbBTC |

### USDC (assetId: 5) on Hub [0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9](https://etherscan.io/address/0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9) / Spoke [0x94e7A5dCbE816e498b89aB752661904E2F56c485](https://etherscan.io/address/0x94e7A5dCbE816e498b89aB752661904E2F56c485)

| description | value before | value after |
| --- | --- | --- |
| addCap | 12,500,000 (1.25e7) USDC | 15,000,000 (1.5e7) USDC |
| drawCap | 12,500,000 (1.25e7) USDC | 15,000,000 (1.5e7) USDC |

### USDG (assetId: 8) on Hub [0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9](https://etherscan.io/address/0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9) / Spoke [0x956d8e0A89cfa3744428C4641b5a53B56167a7f9](https://etherscan.io/address/0x956d8e0A89cfa3744428C4641b5a53B56167a7f9)

| description | value before | value after |
| --- | --- | --- |
| drawCap | 15,000,000 (1.5e7) USDG | 20,000,000 (2e7) USDG |

## Event logs

#### 0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9 (AaveV4Ethereum.ALL_HUBS[0], AaveV4Ethereum.HUBS.CORE_HUB)

| index | event |
| --- | --- |
| 0 | UpdateSpokeConfig(assetId: 5, spoke: 0x94e7A5dCbE816e498b89aB752661904E2F56c485, config: {addCap: 15000000, drawCap: 15000000, riskPremiumThreshold: 0, active: true, halted: false}) |
| 1 | UpdateSpokeConfig(assetId: 0, spoke: 0x94e7A5dCbE816e498b89aB752661904E2F56c485, config: {addCap: 30000, drawCap: 2600, riskPremiumThreshold: 0, active: true, halted: false}) |
| 2 | UpdateSpokeConfig(assetId: 12, spoke: 0x94e7A5dCbE816e498b89aB752661904E2F56c485, config: {addCap: 400, drawCap: 26, riskPremiumThreshold: 0, active: true, halted: false}) |
| 5 | UpdateSpokeConfig(assetId: 8, spoke: 0x956d8e0A89cfa3744428C4641b5a53B56167a7f9, config: {addCap: 0, drawCap: 20000000, riskPremiumThreshold: 0, active: true, halted: false}) |

#### 0x06002e9c4412CB7814a791eA3666D905871E536A (AaveV4Ethereum.ALL_HUBS[1], AaveV4Ethereum.HUBS.PLUS_HUB)

| index | event |
| --- | --- |
| 3 | UpdateSpokeConfig(assetId: 2, spoke: 0xba1B3D55D249692b669A164024A838309B7508AF, config: {addCap: 8000000, drawCap: 0, riskPremiumThreshold: 0, active: true, halted: false}) |

#### 0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931 (AaveV4Ethereum.ALL_HUBS[2], AaveV4Ethereum.HUBS.PRIME_HUB)

| index | event |
| --- | --- |
| 4 | UpdateSpokeConfig(assetId: 0, spoke: 0x973a023A77420ba610f06b3858aD991Df6d85A08, config: {addCap: 5000, drawCap: 0, riskPremiumThreshold: 0, active: true, halted: false}) |

#### 0x14339e2178A954d5FB839D5Ff31644fE0F25F517

| index | event |
| --- | --- |
| 6 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1784118935, withDelegatecall: true, resultData: 0x) |

## Raw storage changes

### 0x06002e9c4412cb7814a791ea3666d905871e536a (AaveV4Ethereum.ALL_HUBS[1], AaveV4Ethereum.HUBS.PLUS_HUB)

| slot | previous value | new value |
| --- | --- | --- |
| 0x0ebc18c00c44b55501f91a7275feb1ba6c99323cd6a1c803e7cd8db27bf307bf | 0x00000001000000000000000000005b8d8000000000026f7b8084efce5b64e6e3 | 0x00000001000000000000000000007a120000000000026f7b8084efce5b64e6e3 |

### 0x943827dca022d0f354a8a8c332da1e5eb9f9f931 (AaveV4Ethereum.ALL_HUBS[2], AaveV4Ethereum.HUBS.PRIME_HUB)

| slot | previous value | new value |
| --- | --- | --- |
| 0x62ed29c1d84c565c6a0ddddc30c563b3dacb56f65b860666b11676f11fab7a95 | 0x0000000100000000000000000000000c800000000000003e975d8bde4cf9e6b9 | 0x00000001000000000000000000000013880000000000003e975d8bde4cf9e6b9 |

### 0xcca852bc40e560adc3b1cc58ca5b55638ce826c9 (AaveV4Ethereum.ALL_HUBS[0], AaveV4Ethereum.HUBS.CORE_HUB)

| slot | previous value | new value |
| --- | --- | --- |
| 0x26969e8cb9b6d2b93d6249521e49ce58bb9755ebd4b3e61d008464dc3787d464 | 0x000000010000000000e4e1c00000000000000000000000000000000000000000 | 0x000000010000000001312d000000000000000000000000000000000000000000 |
| 0x5b9586d402c452e7fe7cabbff7e97e54e284cbc1a1ac82882fc4e48a8165fba5 | 0x00000001000000000000000e00000000dc0000000000000000000004765429ed | 0x00000001000000000000001a00000001900000000000000000000004765429ed |
| 0xadd1cde0277cb30a8760d92eb9d95713943d29f7cc2af265f8f64fbcbd0b6a93 | 0x0000000100000000000008020000005dc00000000000030eceb3cea29d799594 | 0x000000010000000000000a2800000075300000000000030eceb3cea29d799594 |
| 0xb98d39dd7f8c58a7de07a240db1814ab05b9c6c8912d8daaf2ff31c413f37c53 | 0x000000010000000000bebc200000bebc2000000000000000000005529aa6b2fe | 0x000000010000000000e4e1c00000e4e1c000000000000000000005529aa6b2fe |


## Raw diff

```json
{
  "spokeConfigs": {
    "0x06002e9c4412CB7814a791eA3666D905871E536A_2_0xba1B3D55D249692b669A164024A838309B7508AF": {
      "addCap": {
        "from": 6000000,
        "to": 8000000
      }
    },
    "0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931_0_0x973a023A77420ba610f06b3858aD991Df6d85A08": {
      "addCap": {
        "from": 3200,
        "to": 5000
      }
    },
    "0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9_0_0x94e7A5dCbE816e498b89aB752661904E2F56c485": {
      "addCap": {
        "from": 24000,
        "to": 30000
      },
      "drawCap": {
        "from": 2050,
        "to": 2600
      }
    },
    "0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9_12_0x94e7A5dCbE816e498b89aB752661904E2F56c485": {
      "addCap": {
        "from": 220,
        "to": 400
      },
      "drawCap": {
        "from": 14,
        "to": 26
      }
    },
    "0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9_5_0x94e7A5dCbE816e498b89aB752661904E2F56c485": {
      "addCap": {
        "from": 12500000,
        "to": 15000000
      },
      "drawCap": {
        "from": 12500000,
        "to": 15000000
      }
    },
    "0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9_8_0x956d8e0A89cfa3744428C4641b5a53B56167a7f9": {
      "drawCap": {
        "from": 15000000,
        "to": 20000000
      }
    }
  }
}
```
