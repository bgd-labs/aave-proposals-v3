## Reserve changes

### Reserves altered

#### CRV ([0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 51,000,000 CRV | 7,500,000 CRV |
| borrowCap | 7,700,000 CRV | 5,000,000 CRV |
| debtCeiling | 5,000,000 $ | 1,000,000 $ |
| borrowingEnabled | false | true |


## Raw diff

```json
{
  "reserves": {
    "0xD533a949740bb3306d119CC777fa900bA034cd52": {
      "borrowCap": {
        "from": 7700000,
        "to": 5000000
      },
      "borrowingEnabled": {
        "from": false,
        "to": true
      },
      "debtCeiling": {
        "from": 500000000,
        "to": 100000000
      },
      "supplyCap": {
        "from": 51000000,
        "to": 7500000
      }
    }
  }
}
```