## Reserve changes

### Reserves added

#### AUSD ([0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://snowtrace.io/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 19,000,000 AUSD |
| borrowCap | 17,400,000 AUSD |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0x83f32c0882B12Ef16214c417efF11FD9e764bf34](https://snowtrace.io/address/0x83f32c0882B12Ef16214c417efF11FD9e764bf34) |
| oracleDecimals | 8 |
| oracleDescription | Capped AUSD / USD |
| oracleLatestAnswer | 0.99925546 |
| usageAsCollateralEnabled | false |
| ltv | 0 % [0] |
| liquidationThreshold | 0 % [0] |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % [0] |
| reserveFactor | 10 % [1000] |
| aToken | [0x724dc807b04555b71ed48a6896b6F41593b8C637](https://snowtrace.io/address/0x724dc807b04555b71ed48a6896b6F41593b8C637) |
| aTokenImpl | [0x1E81af09001aD208BDa68FF022544dB2102A752d](https://snowtrace.io/address/0x1E81af09001aD208BDa68FF022544dB2102A752d) |
| variableDebtToken | [0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a](https://snowtrace.io/address/0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a) |
| variableDebtTokenImpl | [0xa0d9C1E9E48Ca30c8d8C3B5D69FF5dc1f6DFfC24](https://snowtrace.io/address/0xa0d9C1E9E48Ca30c8d8C3B5D69FF5dc1f6DFfC24) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da](https://snowtrace.io/address/0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da) |
| aTokenName | Aave Avalanche AUSD |
| aTokenSymbol | aAvaAUSD |
| aTokenUnderlyingBalance | 100 AUSD [100000000] |
| id | 12 |
| isPaused | false |
| variableDebtTokenName | Aave Avalanche Variable Debt AUSD |
| variableDebtTokenSymbol | variableDebtAvaAUSD |
| virtualAccountingActive | true |
| virtualBalance | 100 AUSD [100000000] |
| optimalUsageRatio | 90 % |
| maxVariableBorrowRate | 80.5 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 5.5 % |
| variableRateSlope2 | 75 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=55000000000000000000000000&variableRateSlope2=750000000000000000000000000&optimalUsageRatio=900000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=805000000000000000000000000) |


## Raw diff

```json
{
  "reserves": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "from": null,
      "to": {
        "aToken": "0x724dc807b04555b71ed48a6896b6F41593b8C637",
        "aTokenImpl": "0x1E81af09001aD208BDa68FF022544dB2102A752d",
        "aTokenName": "Aave Avalanche AUSD",
        "aTokenSymbol": "aAvaAUSD",
        "aTokenUnderlyingBalance": "100000000",
        "borrowCap": 17400000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "id": 12,
        "interestRateStrategy": "0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0x83f32c0882B12Ef16214c417efF11FD9e764bf34",
        "oracleDecimals": 8,
        "oracleDescription": "Capped AUSD / USD",
        "oracleLatestAnswer": "99925546",
        "reserveFactor": 1000,
        "supplyCap": 19000000,
        "symbol": "AUSD",
        "underlying": "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a",
        "variableDebtTokenImpl": "0xa0d9C1E9E48Ca30c8d8C3B5D69FF5dc1f6DFfC24",
        "variableDebtTokenName": "Aave Avalanche Variable Debt AUSD",
        "variableDebtTokenSymbol": "variableDebtAvaAUSD",
        "virtualAccountingActive": true,
        "virtualBalance": "100000000"
      }
    }
  },
  "strategies": {
    "0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a": {
      "from": null,
      "to": {
        "address": "0xCe1C5509f2f4d755aA64B8D135B15ec6F12a93da",
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