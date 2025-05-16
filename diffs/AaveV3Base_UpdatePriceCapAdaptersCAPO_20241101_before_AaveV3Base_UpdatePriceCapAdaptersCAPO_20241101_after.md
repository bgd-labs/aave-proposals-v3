## Reserve changes

### Reserve altered

#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f](https://basescan.org/address/0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f) | [0xfcF82bFa2485253263969167583Ea4de09e9993b](https://basescan.org/address/0xfcF82bFa2485253263969167583Ea4de09e9993b) |


#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f](https://basescan.org/address/0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f) | [0xfcF82bFa2485253263969167583Ea4de09e9993b](https://basescan.org/address/0xfcF82bFa2485253263969167583Ea4de09e9993b) |


## Raw diff

```json
{
  "reserves": {
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "oracle": {
        "from": "0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f",
        "to": "0xfcF82bFa2485253263969167583Ea4de09e9993b"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "oracle": {
        "from": "0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f",
        "to": "0xfcF82bFa2485253263969167583Ea4de09e9993b"
      }
    }
  },
  "raw": {
    "0x2cc0fc26ed4563a5ce5e8bdcfe1a2878676ae156": {
      "label": "AaveV3Base.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x167d7ad8ce5bbf928e114a13d4a925d29e6437f0d5be246a7858d666db460b9d": {
          "previousValue": "0x000000000000000000000000978d8878b53fbe40dab7d4ab47b97ab622ffef9f",
          "newValue": "0x000000000000000000000000fcf82bfa2485253263969167583ea4de09e9993b"
        },
        "0xfd9d8e5cf6730e7e57eb97f3b1049464bdecd36ad3cb0f2ef433a52cab89a82e": {
          "previousValue": "0x000000000000000000000000978d8878b53fbe40dab7d4ab47b97ab622ffef9f",
          "newValue": "0x000000000000000000000000fcf82bfa2485253263969167583ea4de09e9993b"
        }
      }
    },
    "0x2dc219e716793fb4b21548c0f009ba3af753ab01": {
      "label": "GovernanceV3Base.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a5": {
          "previousValue": "0x0068246cc6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068246cc6000000000003000000000000000000000000000000000000000000"
        },
        "0xdd629e5d55690c61d87bb2283f8033a4ed0c9727f0b3cc897e051f7afda800a6": {
          "previousValue": "0x000000000000000000093a800000000000006852914700000000000000000000",
          "newValue": "0x000000000000000000093a800000000000006852914700000000000068246cc7"
        }
      }
    }
  }
}
```