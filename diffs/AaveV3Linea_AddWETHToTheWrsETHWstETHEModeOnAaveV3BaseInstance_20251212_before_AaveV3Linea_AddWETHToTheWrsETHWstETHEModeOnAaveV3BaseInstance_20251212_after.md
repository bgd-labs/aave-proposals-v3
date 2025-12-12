## Reserve changes

### Reserves altered

#### wrsETH ([0xD2671165570f41BBB3B0097893300b6EB6101E6C](https://lineascan.build/address/0xD2671165570f41BBB3B0097893300b6EB6101E6C))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 140,000 wrsETH | 30,000 wrsETH |


## Raw diff

```json
{
  "reserves": {
    "0xD2671165570f41BBB3B0097893300b6EB6101E6C": {
      "supplyCap": {
        "from": 140000,
        "to": 30000
      }
    }
  },
  "raw": {
    "0x3bce23a1363728091bc57a58a226cf2940c2e074": {
      "label": "GovernanceV3Linea.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x8a8166be5f30abeb6c91ee2f07eeb0b2eb14b4d59534d10a1c143964bd617919": {
          "previousValue": "0x00693bdf77000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693bdf77000000000003000000000000000000000000000000000000000000"
        },
        "0x8a8166be5f30abeb6c91ee2f07eeb0b2eb14b4d59534d10a1c143964bd61791a": {
          "previousValue": "0x000000000000000000093a80000000000000696a03f800000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000696a03f8000000000000693bdf78"
        }
      }
    },
    "0xc47b8c00b0f69a36fa203ffeac0334874574a8ac": {
      "label": "AaveV3Linea.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x0555d39d14c318dd3fd549cef0a010aff224252cdce9cfef2c350d76cc8a7040": {
          "previousValue": "0x100000000000000000000003e80000222e0000000000119481122af81c841b58",
          "newValue": "0x100000000000000000000003e8000007530000000000119481122af81c841b58"
        }
      }
    }
  }
}
```