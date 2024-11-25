## Reserve changes

### Reserves added

#### wstETH ([0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C](https://bscscan.com/address/0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,900 wstETH |
| borrowCap | 190 wstETH |
| debtCeiling | 0 $ [0] |
| isSiloed | false |
| isFlashloanable | true |
| oracle | [0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80](https://bscscan.com/address/0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80) |
| oracleDecimals | 8 |
| oracleDescription | Capped wstETH / stETH(ETH) / USD |
| oracleLatestAnswer | 3179.8496515 |
| usageAsCollateralEnabled | true |
| ltv | 72 % [7200] |
| liquidationThreshold | 75 % [7500] |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % [1000] |
| reserveFactor | 15 % [1500] |
| aToken | [0xBDFd4E51D3c14a232135f04988a42576eFb31519](https://bscscan.com/address/0xBDFd4E51D3c14a232135f04988a42576eFb31519) |
| aTokenImpl | [0x6c23bAF050ec192afc0B967a93b83e6c5405df43](https://bscscan.com/address/0x6c23bAF050ec192afc0B967a93b83e6c5405df43) |
| variableDebtToken | [0x2c391998308c56D7572A8F501D58CB56fB9Fe1C5](https://bscscan.com/address/0x2c391998308c56D7572A8F501D58CB56fB9Fe1C5) |
| variableDebtTokenImpl | [0x777fBA024bA1228fDa76149A4ff8B23475ed057D](https://bscscan.com/address/0x777fBA024bA1228fDa76149A4ff8B23475ed057D) |
| borrowingEnabled | true |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5](https://bscscan.com/address/0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5) |
| aTokenName | Aave BNB Smart Chain wstETH |
| aTokenSymbol | aBnbwstETH |
| aTokenUnderlyingBalance | 0.04 wstETH [40000000000000000] |
| id | 7 |
| isPaused | false |
| variableDebtTokenName | Aave BNB Smart Chain Variable Debt wstETH |
| variableDebtTokenSymbol | variableDebtBnbwstETH |
| virtualAccountingActive | true |
| virtualBalance | 0.04 wstETH [40000000000000000] |
| optimalUsageRatio | 45 % |
| maxVariableBorrowRate | 307 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| interestRate | ![ir](https://dash.onaave.com/api/static?variableRateSlope1=70000000000000000000000000&variableRateSlope2=3000000000000000000000000000&optimalUsageRatio=450000000000000000000000000&baseVariableBorrowRate=0&maxVariableBorrowRate=3070000000000000000000000000) |


## Emodes changed

### EMode: ETH-Correlated(id: 1)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ETH-Correlated |
| eMode.ltv | - | 93 % |
| eMode.liquidationThreshold | - | 95 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.borrowableBitmap | - | ETH |
| eMode.collateralBitmap | - | wstETH |


## Raw diff

```json
{
  "eModes": {
    "1": {
      "from": null,
      "to": {
        "borrowableBitmap": "8",
        "collateralBitmap": "128",
        "eModeCategory": 1,
        "label": "ETH-Correlated",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9500,
        "ltv": 9300
      }
    }
  },
  "reserves": {
    "0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C": {
      "from": null,
      "to": {
        "aToken": "0xBDFd4E51D3c14a232135f04988a42576eFb31519",
        "aTokenImpl": "0x6c23bAF050ec192afc0B967a93b83e6c5405df43",
        "aTokenName": "Aave BNB Smart Chain wstETH",
        "aTokenSymbol": "aBnbwstETH",
        "aTokenUnderlyingBalance": "40000000000000000",
        "borrowCap": 190,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "id": 7,
        "interestRateStrategy": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "ltv": 7200,
        "oracle": "0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80",
        "oracleDecimals": 8,
        "oracleDescription": "Capped wstETH / stETH(ETH) / USD",
        "oracleLatestAnswer": "317984965150",
        "reserveFactor": 1500,
        "supplyCap": 1900,
        "symbol": "wstETH",
        "underlying": "0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x2c391998308c56D7572A8F501D58CB56fB9Fe1C5",
        "variableDebtTokenImpl": "0x777fBA024bA1228fDa76149A4ff8B23475ed057D",
        "variableDebtTokenName": "Aave BNB Smart Chain Variable Debt wstETH",
        "variableDebtTokenSymbol": "variableDebtBnbwstETH",
        "virtualAccountingActive": true,
        "virtualBalance": "40000000000000000"
      }
    }
  },
  "strategies": {
    "0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C": {
      "from": null,
      "to": {
        "address": "0x86AB1C62A8bf868E1b3E1ab87d587Aba6fbCbDC5",
        "baseVariableBorrowRate": "0",
        "maxVariableBorrowRate": "3070000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```