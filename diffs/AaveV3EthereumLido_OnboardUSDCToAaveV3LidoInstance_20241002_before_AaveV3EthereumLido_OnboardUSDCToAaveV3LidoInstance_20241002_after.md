## Reserve changes

### Reserves added

#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 30,000,000 USDC |
| borrowCap | 27,600,000 USDC |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x736bF902680e68989886e9807CD7Db4B3E015d3C](https://etherscan.io/address/0x736bF902680e68989886e9807CD7Db4B3E015d3C) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDC/USD |
| oracleLatestAnswer | 0.99995995 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 10 % [1000] |
| aToken | [0x09AA30b182488f769a9824F15E6Ce58591Da4781](https://etherscan.io/address/0x09AA30b182488f769a9824F15E6Ce58591Da4781) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E](https://etherscan.io/address/0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| stableDebtToken | [0x779dB175167C60c2B2193Be6B8d8B3602435e89E](https://etherscan.io/address/0x779dB175167C60c2B2193Be6B8d8B3602435e89E) |
| stableDebtTokenImpl | [0x36284fED68f802c5733432c3306D8e92c504a243](https://etherscan.io/address/0x36284fED68f802c5733432c3306D8e92c504a243) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | true |
| interestRateStrategy | [0x6642dcAaBc80807DD083c66a301d308568CBcA3D](https://etherscan.io/address/0x6642dcAaBc80807DD083c66a301d308568CBcA3D) |
| aTokenName | Aave Ethereum Lido USDC |
| aTokenSymbol | aEthLidoUSDC |
| aTokenUnderlyingBalance | 100 USDC [100000000] |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Lido Stable Debt USDC |
| stableDebtTokenSymbol | stableDebtEthLidoUSDC |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt USDC |
| variableDebtTokenSymbol | variableDebtEthLidoUSDC |
| virtualAccountingActive | true |
| virtualBalance | 100 USDC [100000000] |
| optimalUsageRatio | 92 % |
| maxVariableBorrowRate | 65.5 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5.5 % |
| variableRateSlope2 | 60 % |
| interestRate | ![ir](/.assets/964cf35b8d3a35020a80b38115449e51d8c0ae34.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "from": null,
      "to": {
        "aToken": "0x09AA30b182488f769a9824F15E6Ce58591Da4781",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido USDC",
        "aTokenSymbol": "aEthLidoUSDC",
        "aTokenUnderlyingBalance": 100000000,
        "borrowCap": 27600000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 0,
        "interestRateStrategy": "0x6642dcAaBc80807DD083c66a301d308568CBcA3D",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0x736bF902680e68989886e9807CD7Db4B3E015d3C",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDC/USD",
        "oracleLatestAnswer": 99995995,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x779dB175167C60c2B2193Be6B8d8B3602435e89E",
        "stableDebtTokenImpl": "0x36284fED68f802c5733432c3306D8e92c504a243",
        "stableDebtTokenName": "Aave Ethereum Lido Stable Debt USDC",
        "stableDebtTokenSymbol": "stableDebtEthLidoUSDC",
        "supplyCap": 30000000,
        "symbol": "USDC",
        "underlying": "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt USDC",
        "variableDebtTokenSymbol": "variableDebtEthLidoUSDC",
        "virtualAccountingActive": true,
        "virtualBalance": 100000000
      }
    }
  },
  "strategies": {
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "from": null,
      "to": {
        "address": "0x6642dcAaBc80807DD083c66a301d308568CBcA3D",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "655000000000000000000000000",
        "optimalUsageRatio": "920000000000000000000000000",
        "variableRateSlope1": "55000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```