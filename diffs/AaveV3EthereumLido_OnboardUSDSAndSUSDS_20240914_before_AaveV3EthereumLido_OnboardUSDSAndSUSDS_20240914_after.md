## Reserve changes

### Reserves added

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 50,000,000 USDS |
| borrowCap | 45,000,000 USDS |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6](https://etherscan.io/address/0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6) |
| oracleDecimals | 8 |
| oracleDescription | Capped USDS <-> DAI / USD |
| oracleLatestAnswer | 0.9999124 |
| usageAsCollateralEnabled | true |
| ltv | 63 % [6300] |
| liquidationThreshold | 72 % [7200] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 25 % [2500] |
| aToken | [0x09AA30b182488f769a9824F15E6Ce58591Da4781](https://etherscan.io/address/0x09AA30b182488f769a9824F15E6Ce58591Da4781) |
| aTokenImpl | [0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2](https://etherscan.io/address/0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2) |
| variableDebtToken | [0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E](https://etherscan.io/address/0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E) |
| variableDebtTokenImpl | [0x3E59212c34588a63350142EFad594a20C88C2CEd](https://etherscan.io/address/0x3E59212c34588a63350142EFad594a20C88C2CEd) |
| stableDebtToken | [0x779dB175167C60c2B2193Be6B8d8B3602435e89E](https://etherscan.io/address/0x779dB175167C60c2B2193Be6B8d8B3602435e89E) |
| stableDebtTokenImpl | [0x36284fED68f802c5733432c3306D8e92c504a243](https://etherscan.io/address/0x36284fED68f802c5733432c3306D8e92c504a243) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x6642dcAaBc80807DD083c66a301d308568CBcA3D](https://etherscan.io/address/0x6642dcAaBc80807DD083c66a301d308568CBcA3D) |
| aTokenName | Aave Ethereum Lido USDS |
| aTokenSymbol | aEthLidoUSDS |
| aTokenUnderlyingBalance | 100 USDS [100000000000000000000] |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Lido Stable Debt USDS |
| stableDebtTokenSymbol | stableDebtEthLidoUSDS |
| variableDebtTokenName | Aave Ethereum Lido Variable Debt USDS |
| variableDebtTokenSymbol | variableDebtEthLidoUSDS |
| virtualAccountingActive | true |
| virtualBalance | 100 USDS [100000000000000000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 80.5 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5.5 % |
| variableRateSlope2 | 75 % |
| interestRate | ![ir](/.assets/ffb352507c25f7196c1b03be2bce3ab770f34ba7.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "from": null,
      "to": {
        "aToken": "0x09AA30b182488f769a9824F15E6Ce58591Da4781",
        "aTokenImpl": "0x7F8Fc14D462bdF93c681c1f2Fd615389bF969Fb2",
        "aTokenName": "Aave Ethereum Lido USDS",
        "aTokenSymbol": "aEthLidoUSDS",
        "aTokenUnderlyingBalance": "100000000000000000000",
        "borrowCap": 45000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x6642dcAaBc80807DD083c66a301d308568CBcA3D",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7200,
        "ltv": 6300,
        "oracle": "0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6",
        "oracleDecimals": 8,
        "oracleDescription": "Capped USDS <-> DAI / USD",
        "oracleLatestAnswer": 99991240,
        "reserveFactor": 2500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x779dB175167C60c2B2193Be6B8d8B3602435e89E",
        "stableDebtTokenImpl": "0x36284fED68f802c5733432c3306D8e92c504a243",
        "stableDebtTokenName": "Aave Ethereum Lido Stable Debt USDS",
        "stableDebtTokenSymbol": "stableDebtEthLidoUSDS",
        "supplyCap": 50000000,
        "symbol": "USDS",
        "underlying": "0xdC035D45d973E3EC169d2276DDab16f1e407384F",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x2D9fe18b6c35FE439cC15D932cc5C943bf2d901E",
        "variableDebtTokenImpl": "0x3E59212c34588a63350142EFad594a20C88C2CEd",
        "variableDebtTokenName": "Aave Ethereum Lido Variable Debt USDS",
        "variableDebtTokenSymbol": "variableDebtEthLidoUSDS",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000000000000000"
      }
    }
  },
  "strategies": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "from": null,
      "to": {
        "address": "0x6642dcAaBc80807DD083c66a301d308568CBcA3D",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "805000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "variableRateSlope1": "55000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```