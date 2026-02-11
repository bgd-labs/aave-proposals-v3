## Reserve changes

### Reserve altered

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://lineascan.build/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| ltv | 72.5 % [7250] | 0 % [0] |


#### wstETH ([0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F](https://lineascan.build/address/0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F))

| description | value before | value after |
| --- | --- | --- |
| borrowingEnabled | true | false |


#### wrsETH ([0xD2671165570f41BBB3B0097893300b6EB6101E6C](https://lineascan.build/address/0xD2671165570f41BBB3B0097893300b6EB6101E6C))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 0 % [0] |


## Emodes changed

### EMode: wstETH correlated(id: 1)



### EMode: ezETH correlated(id: 2)



### EMode: weETH correlated(id: 3)



### EMode: wrsETH/WETH Isolated Liquid E-mode(id: 4)



### EMode: ezETH__USDC_USDT(id: 5)

| description | value before | value after |
| --- | --- | --- |
| eMode.label | - | ezETH__USDC_USDT |
| eMode.ltv | - | 72.5 % |
| eMode.liquidationThreshold | - | 75 % |
| eMode.liquidationBonus | - | 7.5 % |
| eMode.borrowableBitmap | - | USDC, USDT |
| eMode.collateralBitmap | - | ezETH |


## Raw diff

```json
{
  "eModes": {
    "5": {
      "from": null,
      "to": {
        "borrowableBitmap": "12",
        "collateralBitmap": "32",
        "eModeCategory": 5,
        "label": "ezETH__USDC_USDT",
        "liquidationBonus": 10750,
        "liquidationThreshold": 7500,
        "ltv": 7250
      }
    }
  },
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "ltv": {
        "from": 7250,
        "to": 0
      }
    },
    "0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      }
    },
    "0xD2671165570f41BBB3B0097893300b6EB6101E6C": {
      "ltv": {
        "from": 7000,
        "to": 0
      }
    }
  },
  "raw": {
    "0x3bce23a1363728091bc57a58a226cf2940c2e074": {
      "label": "GovernanceV3Linea.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x94f2575c7592b1dfd5a8846a17482da7b0e38fb10c93880d74916c5f16792464": {
          "previousValue": "0x00698c5a02000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00698c5a02000000000003000000000000000000000000000000000000000000"
        },
        "0x94f2575c7592b1dfd5a8846a17482da7b0e38fb10c93880d74916c5f16792465": {
          "previousValue": "0x000000000000000000093a8000000000000069ba7e8300000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069ba7e83000000000000698c5a03"
        }
      }
    },
    "0xc47b8c00b0f69a36fa203ffeac0334874574a8ac": {
      "label": "AaveV3Linea.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7040": {
          "previousValue": "0x100000000000000000000003e8000007530000000000119481122af81c841b58",
          "newValue": "0x100000000000000000000003e8000007530000000000119481122af81c840000"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8257": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000002029fe1d4c1c52"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8258": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x657a4554485f5f555344435f5553445400000000000000000000000000000020"
        },
        "0x50039cf134a124858bd88bbc9225ec3c537b89a0e9237ce39fe1813e6edf8259": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000000000000000000000c"
        },
        "0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2": {
          "previousValue": "0x100000000000000000000003e8000012c000000000011194811229fe1d4c1c52",
          "newValue": "0x100000000000000000000003e8000012c000000000011194811229fe1d4c0000"
        },
        "0x93edf0d849d0004112c50b390a5a5697e3b8453a41d624f054adf855aab35092": {
          "previousValue": "0x100000000000000000000003e8000004b000000012c001f4851229cc1edc1d4c",
          "newValue": "0x100000000000000000000003e8000004b000000012c001f4811229cc1edc1d4c"
        }
      }
    }
  }
}
```